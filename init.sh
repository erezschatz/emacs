#!/bin/sh

#TODO: make sure all prerequisite are installed:
# wget
# git
# sbcl
# LaTeX

mkdir site-lisp
cd site-lisp
wget http://www.emacswiki.org/emacs-en/download/fit-frame.el
wget http://bzr.savannah.gnu.org/lh/emacs/trunk/download/head:/eww.el-20130610114603-80ap3gwnw4x4m5ix-1/eww.el

git clone https://github.com/alpaker/Fill-Column-Indicator.git
git clone git://git.savannah.gnu.org/tramp.git
git clone git://orgmode.org/org-mode.git
git clone https://github.com/slime/slime.git
git clone git://git.savannah.gnu.org/auctex.git
cd auctex
./autogen.sh
./configure
make
cd ..
git clone https://github.com/magit/git-modes.git
git clone git://github.com/magit/magit.git
