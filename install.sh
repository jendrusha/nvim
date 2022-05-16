#!/usr/bin/env bash

VERSION_CURRENT=$(nvim --version | head -1 | awk '{ printf $2 }' | sed 's/-/+/g' | sed 's/v//')
DOWNLOAD_URL="https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz"

cd /tmp
printf "Downloading latest neovim version..."
{
    wget -O /tmp/nvim_linux64.tar.gz "$DOWNLOAD_URL"
    tar -zxvf nvim_linux64.tar.gz
} &> /dev/null
printf " %s\n" "Done!"

cd /tmp/nvim-linux64
VERSION_DOWNLOADED=$(./bin/nvim --version | head -1 | awk '{ printf $2 }' | sed 's/-/+/g' | sed 's/v//')

[ "$VERSION_CURRENT" == "$VERSION_DOWNLOADED" ] && echo "Nothing to update, you have the latest version." && exit 0

./bin/nvim --headless -u NONE -i NONE -c ':quit'
[ "$?" != 0 ] && echo "Unable to continue, neovim binary corrupted." && exit 1

printf "Installing neovim (version: $VERSION_DOWNLOADED)..."
sudo cp -r lib /usr/
sudo cp -r share /usr/
sudo cp bin/nvim /usr/bin/nvim

# Make Arch vim packages work
sudo mkdir -p /etc/xdg/nvim

sudo sh -c "echo '\" This line makes pacman-installed global Arch Linux vim packages work.' > /etc/xdg/nvim/sysinit.vim"
sudo sh -c "echo 'source /usr/share/nvim/archlinux.vim' >> /etc/xdg/nvim/sysinit.vim"

sudo mkdir -p /usr/share/nvim
sudo sh -c "echo 'set runtimepath+=/usr/share/vim/vimfiles' > /usr/share/nvim/archlinux.vim"
sudo /usr/bin/rm /tmp/nvim_linux64.tar.gz
sudo /usr/bin/rm -rf /tmp/nvim-linux64
printf " %s\n" "Done!"
