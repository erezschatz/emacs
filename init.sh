#!/bin/sh

mkdir site-lisp
cd site-lisp

for i in wget git autoconf bitlbee bzr
do
    if [ ! $(which $i) ]; then
        sudo pacman -Syu $i
    fi
done

# one-in-one
mkdir one-on-one
cd one-on-one

wget http://www.emacswiki.org/emacs-en/download/fit-frame.el
wget http://www.emacswiki.org/emacs/download/frame-cmds.el
wget http://www.emacswiki.org/emacs/download/frame-fns.el
wget http://www.emacswiki.org/emacs/download/misc-cmds.el

cd ..

# gnus
git clone http://git.gnus.org/gnus.git

# tramp
git clone git://git.savannah.gnu.org/tramp.git

# org-mode
git clone git://orgmode.org/org-mode.git

# magit
git clone https://github.com/magnars/dash.el.git
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

# xs-mode
wget http://www.emacswiki.org/emacs/download/xs-mode.el

#

cd $here
