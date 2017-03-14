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
        with open(filename, "rb") as f:
            h = hashlib.new('sha1')
            buf = True
            while buf:
                try:
                    buf = f.read(DEFAULT_BUFFER_SIZE)
                except KeyboardInterrupt:
                    print()
                    sys.exit(130)
                h.update(buf)
            try:
                if digest == h.hexdigest():
                    return True
                else:
                    pass

            except IOError as e:
                if e.errno != 32:
                    raise

    print(filename,': FAILED')
    return False


@click.command()
@click.option('-n', '--number', help="Number of times to repeat, default=3", default=3, type=click.IntRange(min=0))
@click.argument('digest_file', type=click.Path(readable=True))
def main(digest_file, number):
    digest_file = os.path.abspath(os.path.expanduser(digest_file))

    filenames_to_digest = {}

    with open(digest_file) as digest_file_fp:
        for line in digest_file_fp.readlines():
            line = line.split()
            digest, filename = line[0].strip(), line[1].strip()
            filenames_to_digest[filename] = digest

    with multiprocessing.Pool(2) as pool:
        return_vals = pool.starmap(foobar, filenames_to_digest.items())

    return all(return_vals)

if __name__ == '__main__':
    main()
