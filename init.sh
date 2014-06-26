#!/bin/sh

mkdir site-lisp
cd site-lisp

for i in wget git autoconf bitlbee bzr
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

# tt-mode

git clone https://github.com/davorg/tt-mode.git

# js2-mode

git clone https://github.com/mooz/js2-mode.git

# circe
 https://github.com/jorgenschaefer/circe.git
