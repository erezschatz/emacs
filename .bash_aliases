# There are exactly eighty characters in this line, including the # at the start

# Default stuff, came with OS sometimes back, may be good for something

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# System upgrade commands

function upgrade {
	name=$(uname -a)
	if [[ $name =~ Ubuntu ]]; then
		sudo apt-get update && sudo apt-get dist-upgrade
	elif [[ $name =~ ARCH ]]; then
		sudo pacman -Syu
	else 
		echo "Unknown operating system uname $name"
	fi
}

function upplan9 {
	current=$(pwd)
	cd $PLAN9
	hg pull -u
	cd $current
	echo
}

alias upall='upgrade; cpanupdate; got update; upplan9'

function delete {
	sudo apt-get purge $1
	sudo apt-get autoremove --purge
#	while; do		
#		sudo apt-get remove --purge $(deborphan)
#	done
}

# common linux tools

function les {
	for i in $@; do
		if   [ -d "${i}" ]; then
			ls --color=auto $i
		elif [ -f "${i}}" ]; then		
			less $i
		else 
			echo "${i} is not valid";
		fi
	done;
}

alias ll='ls -alF --color'

# personal tools

alias btsync="$HOME/btsync/btsync"
alias node='nodejs'
alias js='js17'
alias kiwi="$HOME/dev/KiwiIRC/kiwi start"

# possible fonts

# $PLAN9/font/pelm/unicode.8.font
#            /fixed/unicode.6x13.font
#            /fixed/unicode.7x13B.font

function acme {
	nohup acme \
		-f $PLAN9/font/fixed/unicode.6x13.font \
		-m /mnt/acme -l /home/erez/acme.dump \
	>/dev/null 2>&1 &
}

alias sam='nohup /home/erez/plan9/bin/sam > /dev/null 2>&1 &'
alias dentro='firefox -app /home/erez/dev/dentro/application.ini &'


# Perl and CPAN

# Copy module file name from "Can't locate Hop/Scotch.pm in @INC"
# $ cpam Hop/Scotch.pm
# --> Working on Hop::Scotch

function cpam {
         module=${1//\//::}
         module=${module//\.pm/}
         cpanm $module
}

# todo: check for -M stuff to add modules
function perlm {
   	perl -MModern::Perl -e "$1"
}

# takes C/CH/CHALK/Hop-Scotch-1.2345.tar.gz and checks if
# mversion for Hop::Scotch is 1,2345

function same_mversion {
	input=${1##*/}
	input=${input%%.tar.gz}
	module=${input%-*}
	module=${module/-/::}
	return echo $(mversion $module)"<"${input##*-} | bc
}

# compile under Modern::Perl
alias perlc='perl -MModern::Perl -wc '

# gets all (local) libraries that report found update using cpan-outdated
# check if not cpanminus, specific creators or mversion repeats same version
# deletes these items from array and runs them through cpanminus
function cpanupdate {
	modules=$(cpan-outdated --local-lib-contained=/home/erez/.perl5/)

	for i in ${modules[@]}; do
        	if [[ $i =~ IDOPEREL ]]; then
			modules=( "${modules[0]/$i}" )
        	elif [[ $i =~ cpanminus ]]; then
			cpanm $i;
			modules=( "${modules[0]/$i}" )
		elif same_mversion $i; then
			modules=( "${modules[0]/$i}" )	
       		fi;
    	done

	cpanm $modules
}

