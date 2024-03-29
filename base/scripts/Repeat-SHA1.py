#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from __future__ import print_function
from __future__ import unicode_literals

import functools
import hashlib
import io
import itertools
import os
import sys
from io import DEFAULT_BUFFER_SIZE
from pprint import pprint  # NOQA

import click
import click._compat
from colorama import Fore
from tqdm import tqdm


def PerformChecksum(
    filename,
    digest,
    delete: bool = False,
    delete_rm: bool = False,
    repeat=3,
    pbar=None,
    is_interactive: bool = False,
    color: bool = True,
) -> bool:
    # If we're not in batch (i.e. interactive) mode, then use colors and
    # update progress bar. Otherwise, use stdout.
    if is_interactive:
        out = tqdm
        pbar.update(1)
    else:
        out = sys.stdout

    out_fp = io.StringIO()  # File-like for output from this thread
    for _ in range(repeat):
        try:
            with open(filename, "rb") as f:
                h = hashlib.new("sha1")
                buf = True
                while buf:
                    buf = f.read(DEFAULT_BUFFER_SIZE)
                    h.update(buf)
                if digest == h.hexdigest():
                    # checksum matches, everything is good!
                    return True
                else:
                    # checksum didn't match, try again at next loop iteration
                    pass

        except (IOError, OSError) as e:
            if e.errno != 32:  # Ignore EPIPE (broken pipe)
                click.echo(
                    click.style("ERROR", fg="yellow"), out_fp, nl=False, color=color
                )
                click.echo(
                    ": {filename}".format(filename=filename),
                    out_fp,
                    nl=(not is_interactive),
                )
                out.write(out_fp.getvalue())
                return False
        except KeyboardInterrupt:
            print()
            sys.exit(130)

    if delete:
        click.echo(click.style("DELETE", fg="magenta"), out_fp, nl=False, color=color)
        click.echo(
            ": {filename}".format(filename=filename), out_fp, nl=(not is_interactive)
        )
        os.unlink(filename)
    elif delete_rm:
        click.echo("# " + click.style("FAILED", fg="red"), out_fp, nl=True, color=color)
        click.echo(
            'rm "{filename}"'.format(filename=filename), out_fp, nl=(not is_interactive)
        )
    else:
        click.echo(click.style("FAILED", fg="red"), out_fp, nl=False, color=color)
        click.echo(
            ": {filename}".format(filename=filename), out_fp, nl=(not is_interactive)
        )

    out.write(out_fp.getvalue())
    return False


@click.command()
@click.option(
    "--delete",
    help="Delete file if checksum fails. default=False",
    is_flag=True,
    default=False,
)
@click.option(
    "--delete-rm",
    help="Write out an `rm` command deleting a file if checksum fails. default=False",
    is_flag=True,
    default=False,
)
@click.option(
    "--batch",
    "batch_mode",
    help="Batch mode hides progress bar and colors. default=False",
    is_flag=True,
    default=False,
)
@click.option(
    "-n",
    "--repeat",
    help="Number of times to repeat. default=3",
    default=3,
    type=click.IntRange(min=0),
)
@click.option(
    "-j",
    "--jobs",
    help="Number of jobs/processes. Should be function of I/O bandwidth, and not processor cores. 0 is autodetect, default=4",
    default=4,
    type=click.IntRange(min=0),
)
@click.option("-a", "--algorithm", help="", default="sha1")
@click.argument("digest_files", type=click.Path(readable=True), nargs=-1)
def main(digest_files, delete, delete_rm, batch_mode, repeat, jobs, algorithm):
    filenames_to_digest = {}

    # Interactive mode?
    try:
        is_interactive = sys.stdout.isatty()
        color = is_interactive
    except:
        is_interactive = False
        color = False
    if batch_mode:
        is_interactive = False

    if is_interactive:
        import multiprocessing.dummy as multiprocessing
    else:
        import multiprocessing

    if jobs == 0:
        import multiprocessing as mp_real

        jobs = mp_real.cpu_count()

    for current_digest_file in digest_files:
        current_digest_file = os.path.abspath(os.path.expanduser(current_digest_file))
        with open(current_digest_file, encoding="utf-8") as digest_file_fp:
            for line in digest_file_fp.readlines():
                line = line.split(maxsplit=1)
                digest, filename = line[0].strip(), line[1].strip()
                filenames_to_digest[filename] = digest

    total_files = len(filenames_to_digest)
    pbar = None
    if is_interactive:
        click.echo(
            "Checksumming {total_files} file(s) from {total_digests} digest(s).".format(
                total_files=total_files, total_digests=len(digest_files)
            )
        )
        pbar = tqdm(
            total=total_files,
            bar_format="{l_bar}%s{bar}%s{r_bar}" % (Fore.BLUE, Fore.RESET),
            unit="files",
            dynamic_ncols=True,
            position=0,
        )

    fnChecksum = functools.partial(
        PerformChecksum,
        delete=delete,
        delete_rm=delete_rm,
        repeat=repeat,
        pbar=pbar,
        is_interactive=is_interactive,
        color=color,
    )

    # with multiprocessing.dummy.Pool(jobs, initializer=tqdm.set_lock, initargs=(RLock(),)) as pool:
    with multiprocessing.Pool(jobs) as pool:
        return_vals = pool.starmap(fnChecksum, filenames_to_digest.items())

    if is_interactive:
        pbar.close()

    return all(return_vals)


if __name__ == "__main__":
    main()
