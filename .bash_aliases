# Default stuff, came with OS sometimes back, may be good for something

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# System upgrade commands

alias upgrade='sudo apt-get update && sudo apt-get dist-upgrade'

function cpanupdate {
	modules=$(cpan-outdated --local-lib-contained=/home/erez/.perl5/)

    for i in ${modules[@]}; do
        if [[ $i =~ IDOPEREL ]]; then
			modules=( "${modules[0]/$i}" )
        elif [[ $i =~ cpanminus ]]; then
            cpanm $i;
			modules=( "${modules[0]/$i}" )			
        fi;
    done

	cpanm $modules
}

function upplan9 {
	current=$(pwd)
	cd $PLAN9
	hg pull -u
	cd $current
}

alias upall='upgrade; cpanupdate; got update; upplan9'


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

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# from https://github.com/vigneshwaranr/bd
alias bd=". /home/erez/dev/bd/bd -s"

# personal tools

alias node='nodejs'
alias js='js17'
function acme {
	nohup acme \
		-f $PLAN9/font/fixed/unicode.6x13.font \
		-m /mnt/acme -l /home/erez/acme.dump \
	>/dev/null 2>&1 &
}
alias dentro='firefox -app /home/erez/dev/dentro/application.ini &'


# Perl and CPAN

# this is for copy/paste module not found errors
function cpam {
         module=${1//\//::}
         module=${module//\.pm/}
         cpanm $module
}

# todo: check for -M stuff to add modules
function perlm {
	echo $1
   	perl -MModern::Perl -e '$1'
}


alias perlc='perl -MModern::Perl -c '
