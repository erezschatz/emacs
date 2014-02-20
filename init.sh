#!/bin/sh

# TODO: make sure all prerequisite are installed:
# wget
# git
# sbcl
# LaTeX
# cvs
# autoconf

mkdir site-lisp
cd site-lisp

#fit-frame
wget http://www.emacswiki.org/emacs-en/download/fit-frame.el

#w3m
cvs -d :pserver:anonymous@cvs.namazu.org:/storage/cvsroot login
# hit enter?
cvs -d :pserver:anonymous@cvs.namazu.org:/storage/cvsroot co emacs-w3m
cd emacs-w3m
autoconf
./configure
make
cd ..

git clone https://github.com/alpaker/Fill-Column-Indicator.git
git clone git://git.savannah.gnu.org/tramp.git
git clone git://orgmode.org/org-mode.git
git clone https://github.com/slime/slime.git

#auctex
git clone git://git.savannah.gnu.org/auctex.git
cd auctex
./autogen.sh
./configure
make
cd ..

# magit
git clone https://github.com/magit/git-modes.git
git clone git://github.com/magit/magit.git
