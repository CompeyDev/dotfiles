# dotfiles
This repository includes a collection of common configurations and scripts intended for use on personal unix-like devices. You can also use this as a starting point for your configurations by simply cloning this repository and symlinking the necessary files and directories. For example, you could use my `~/.bashrc` by running:
```bash 
git clone https://github.com/CompeyDev/dotfiles.git
cd dotfiles
ln -s .bashrc ~/.bashrc
```

The repository also includes a `./install.sh` convenience script which installs required dependencies and recursively symlinks files to the user's home directory. Currently, this script only works
on Arch Linux based distributions (which have the pacman command).
