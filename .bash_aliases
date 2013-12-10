# There are exactly eighty characters in this line, including the # at the start

# Default stuff, came with OS sometimes back, may be good for something

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# packages maintenance commands

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

alias upall='upgrade; cpanupdate; gpull $HOME/dev/; upplan9'

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
			echo "${i} is not valid"
		fi
	done
}

alias ll='ls -alF --color'

# tools

alias btsync="$HOME/btsync/btsync"
alias js='js17'

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

if [ ! -r $HOME/.samcmds ]; then
	touch $HOME/.samcmds
fi
alias Sam='nohup /home/erez/plan9/bin/sam .samcmds > /dev/null 2>&1 &'

alias dentro='firefox -app /home/erez/dev/dentro/application.ini &'

source $HOME/dev/dotfiles/lib/perl.sh

# git

function gpull {
	if [ ! -z "$1" ]; then
		for $i in $(ls $1); do
			cd $1'/'$i
			pull_master_from $branch
		done
	else

		pull_master_from $branch
	fi

}

function pull_master_from {
	branch=$(__git_ps1 "%s")
	if [ ! -z "$branch" ]; then
		git checkout master && git pull
		git checkout $branch
	fi
}

