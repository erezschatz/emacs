#!/bin/sh

mkdir site-lisp
cd site-lisp

for i in wget git sbcl texlive-core autoconf bitlbee bzr
do
    if [ ! $(which $i) ]; then
        sudo pacman -Syu $i
    fi
done

#fit-frame
wget http://www.emacswiki.org/emacs-en/download/fit-frame.el

git clone https://github.com/alpaker/Fill-Column-Indicator.git
git clone git://git.savannah.gnu.org/tramp.git
git clone git://orgmode.org/org-mode.git
git clone https://github.com/slime/slime.git

# auctex
git clone git://git.savannah.gnu.org/auctex.git
cd auctex
./autogen.sh
./configure
make
cd ..

# magit
git clone https://github.com/magit/git-modes.git
git clone git://github.com/magit/magit.git

# gas-mode
wget http://www.hczim.de/software/gas-mode.el-1.10.gz
gunzip gas-mode.el-1.10.gz
mv gas-mode.el-1.10 gas-mode.el

# flymake

git clone https://github.com/illusori/emacs-flymake.git

# twitter

git clone https://github.com/hayamiz/twittering-mode.git

# screenwriter

wget http://nongnu.org/screenwriter/download/screenwriter-1.6.6.tar.gz

tar -xvf screenwriter-1.6.6.tar.gz

mv screenwriter-1.6.6 screenwriter

# org-trello

git clone http://github.com/org-trello/org-trello.git
