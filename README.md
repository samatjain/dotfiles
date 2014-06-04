# Samat Jain's configuration files

The configuration files in this repository are meant to be installed and managed with
[Evan Purkhiser's `dots` utility](https://github.com/EvanPurkhiser/dots).

### Setting Up Your Dotfiles

 1. Create configuration groups as you see fit. All directories aside from the
    `base` directory should contain a second directory in them representing a
    sub-configuration group.

    For example you could have a `machines/desktop` configuration group for
    your desktop and a `machines/laptop` configuration group for your laptop.
    You could also for example have a `common/develop` for configuration files
    specifically used for development tools.

 2. Organize your dotfiles into their respective configuration groups.

 3. Execute `source init` to install the dots manager and initialize your
    dotfiles into ther directories.

 4. Execute `dots groups set [list of groups here]` then `dots install`.

 5. Enjoy your organized dotfiles!


While not required, it's recommended to read through the [dots
README](https://github.com/EvanPurkhiser/dots/blob/master/README.md).

## Inspiration

Files in this repository have been inspired by:

 * My own dotfiles, littered across many different types of machines˙
 * [Evan Purkhiser's dotfiles-personal](https://github.com/EvanPurkhiser/dots-personal/) (since he's the creator of dots)
