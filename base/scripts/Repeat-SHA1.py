#!/usr/bin/env python3

import hashlib
import multiprocessing
import os
import itertools

from io import DEFAULT_BUFFER_SIZE
from pprint import pprint

import click


def foobar(filename, digest):
    for i in range(3):
        try:
            with open(filename, "rb") as f:
                h = hashlib.new('sha1')
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
            if e.errno != 32: # Ignore EPIPE (broken pipe)
                print('ERROR:', filename)
                return False
        except KeyboardInterrupt:
            print()
            sys.exit(130)

    print('FAILED:', filename)
    return False


@click.command()
@click.option('-n', '--number', help="Number of times to repeat. default=3", default=3, type=click.IntRange(min=0))
@click.option('-j', '--jobs', help="Number of jobs/processes. Should be function of I/O bandwidth, and not processor cores. default=2", default=2, type=click.IntRange(min=0))
@click.argument('digest_files', type=click.Path(readable=True), nargs=-1)
def main(digest_files, number, jobs):
    filenames_to_digest = {}

    for current_digest_file in digest_files:
        current_digest_file = os.path.abspath(os.path.expanduser(current_digest_file))
        with open(current_digest_file) as digest_file_fp:
            for line in digest_file_fp.readlines():
                line = line.split(maxsplit=1)
                digest, filename = line[0].strip(), line[1].strip()
                filenames_to_digest[filename] = digest

    with multiprocessing.Pool(jobs) as pool:
        return_vals = pool.starmap(foobar, filenames_to_digest.items())

    return all(return_vals)

if __name__ == '__main__':
    main()
