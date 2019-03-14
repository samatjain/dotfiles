#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#from __future__ import annotations  # Disabled until Python 3.7

"""
Find filenames that are too long.
"""

import os
import typing
from pathlib import Path

import click


ENCFS_DEFAULT: int = 179


def recursive_scandir(path: 'typing.Union[str, os.PathLike[typing.Any]]',
                      include_dirs: bool = False) -> typing.Generator[os.DirEntry, None, None]:
    """Recursive os.scandir().

    Recursively yield os.DirEntry objects for everything under path.

    Args:
        path: Path to start
        include_dirs: Also include directories. Otherwise, non-directories only.

    """
    for entry in os.scandir(path):
        if entry.is_dir(follow_symlinks=False):
            yield from recursive_scandir(entry.path)
            if include_dirs:
                yield entry
        else:
            yield entry
    return


@click.command()
@click.option("--length", help="", default=ENCFS_DEFAULT, type=click.IntRange(min=0))
@click.argument("path", type=click.Path(readable=True, file_okay=False, resolve_path=True))
def main(length: int, path: os.PathLike) -> None:
    path = Path(path)
    for item in recursive_scandir(path, include_dirs=True):
        fn = item.name
        #if len(fn) > length:
        print("{l} {fn}".format(l=len(fn), fn=fn))
            #print(f'{fn} : filename is longer than {length} ch')


if __name__ == '__main__':
    main()
