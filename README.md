# Samat Jain's configuration files

The configuration files in this repository are meant to be installed and managed with
[Evan Purkhiser's `dots` utility](https://github.com/EvanPurkhiser/dots).

### Installation

To install these files on a new machine (copy & paste the below):

    mkdir -p ~/src/git.other/
    cd ~/src/git.other/
    git clone https://github.com/samatjain/dotfiles.git
    cd dotfiles
    source init-dots
    dots groups set base # Set addtl groups as necessary
    dots install

While not required, it's recommended to read through the [dots
README](https://github.com/EvanPurkhiser/dots/blob/master/README.md).

## Inspiration

Files in this repository have been inspired by:

 * My own dotfiles, littered across many different types of machines
 * [Evan Purkhiser's dotfiles-personal](https://github.com/EvanPurkhiser/dots-personal/) (since he's the creator of dots)

## Configuration profiles

### common/egypt

Scripts, settings, etc only applicable to the egypt network.

### common/rome

Scripts, settings, etc only applicable to the rome network.

## System packages

The configuration in this repository will work best w/ additional system packages installed.

### Debian and Ubuntu

    sudo aptitude install \
      python-pygments # Provides pygmentize for lessfilter \
      vim-addon-manager # Debian/Vim addons manager \
      vim-pathogen \
      vim-syntastic \
      vim-editorconfig

After running the above, to install vim plugins for the current user:

    vim-addons install pathogen
    vim-addons install editorconfig
    vim-addons install syntastic

