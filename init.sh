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
git clone https://github.com/magnars/dash.el.git dash

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

# perlnow
wget http://obsidianrook.com/perlnow/code/perlnow.el
wget http://downloads.sourceforge.net/project/emacs-template/template/3.1c/template-3.1c.tar.gz
tar -xvzf template-3.1c.tar.gz
mv template-3.1.tar.gz template

mkdir $HOME/.templates
here=$(pwd)
cd $HOME/.templates

for i in perlnow-pl perlnow-pm perlnow-object-pm perlnow-pm-t perlnow-pl-t pl pm t; do
    wget http://obsidianrook.com/perlnow/code/templates/standard/TEMPLATE.$i.tpl
done

cd $here
