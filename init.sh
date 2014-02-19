mkdir site-lisp
cd site-lisp
wget http://www.emacswiki.org/emacs-en/download/fit-frame.el
git clone https://github.com/alpaker/Fill-Column-Indicator.git
git clone https://github.com/DamienCassou/shell-switcher.git
git clone git://git.savannah.gnu.org/tramp.git
git clone git://orgmode.org/org-mode.git
git clone https://github.com/slime/slime.git
git clone git://git.savannah.gnu.org/auctex.git
cd auctex
./autogen.sh
./configure
make
cd ..
git clone git://github.com/magit/magit.git
