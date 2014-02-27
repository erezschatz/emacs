#!/bin/sh

# TODO: make sure all prerequisite are installed:
# wget
# git
# sbcl
# LaTeX
# autoconf
# bitlbee

mkdir site-lisp
cd site-lisp

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
