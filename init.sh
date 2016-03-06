#!/bin/sh

mkdir site-lisp
cd site-lisp

for i in wget git autoconf bitlbee bzr erlang ledger
do
    if [ ! $(which $i) ]; then
        sudo yaourt -Syua $i
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
git clone https://github.com/emacs-pe/docker-tramp.el.git docker-tramp

# org-mode
git clone git://orgmode.org/org-mode.git

# magit
git clone https://github.com/magit/git-modes.git
git clone https://github.com/magit/magit.git
git clone https://github.com/magnars/dash.el.git dash
git clone https://github.com/magit/with-editor.git


# gas-mode
wget http://www.hczim.de/software/gas-mode.el-1.10.gz
gunzip gas-mode.el-1.10.gz
mv gas-mode.el-1.10 gas-mode.el

# twitter

git clone https://github.com/hayamiz/twittering-mode.git

# tt-mode

git clone https://github.com/davorg/tt-mode.git

# js2-mode

git clone https://github.com/mooz/js2-mode.git

# xs-mode
wget http://www.emacswiki.org/emacs/download/xs-mode.el

# flycheck

git clone https://github.com/flycheck/flycheck.git
wget http://elpa.gnu.org/packages/let-alist-1.0.4.el
mv let-alist-1.0.4.el flycheck/let-alist.el
git clone https://github.com/NicolasPetton/seq.el.git seq

# AUCTeX

wget http://ftp.gnu.org/pub/gnu/auctex/auctex-11.89.tar.gz
tar -xvzf auctex-11.89.tar.gz
mv auctex-11.89 auctex
rm auctex-11.89.tar.gz
cd auctex
./configure
make
cd ..

# slime
git clone https://github.com/slime/slime.git

# php
git clone https://github.com/ejmr/php-mode.git

# web-mode
git clone https://github.com/fxbois/web-mode.git

# restclient

git clone https://github.com/pashky/restclient.el.git restclient

cd $here
