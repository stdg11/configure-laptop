#!/bin/bash

# This script creates symlinks from the home directory to any dotfiles in dotfiles/
# Adapted from https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh

## Variables

cur_dir=`pwd` # directory path to git repo
dot_dir=dotfiles # dotfiles directory
old_dir=dotfiles_old # old dotfiles backup directory

## Create dotfiles_old
echo -n "Creating $old_dir for backup of any existing dotfiles in ~ ..."
mkdir -p $cur_dir/$old_dir
echo "done"

## Change to the dotfiles directory
echo -n "Changing to the $dot_dir directory ..."
cd $cur_dir/$dot_dir
echo "done"

## Move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the dotfiles directory specified in $files
for file in *; do
    echo "Moving existing dotfile ~/.$file to $cur_dir/$old_dir"
    mv ~/.$file $cur_dir/$old_dir/
    echo "Creating symlink to $cur_dir/$dot_dir/$file -> ~/.$file "
    ln -s $cur_dir/$dot_dir/$file ~/.$file
    #echo $file
done

install_zsh () {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Clone my oh-my-zsh repository from GitHub only if it isn't already present
    if [[ ! -d $dot_dir/oh-my-zsh/ ]]; then
        git clone http://github.com/robbyrussell/oh-my-zsh.git
    fi
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
    fi
else
    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    # If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
        sudo apt-get install zsh
        install_zsh
    # If the platform is OS X, tell the user to install zsh :)
    elif [[ $platform == 'Darwin' ]]; then
        echo "Please install zsh, then re-run this script!"
        exit
    fi
fi
}

#install_zsh
