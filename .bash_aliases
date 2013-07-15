# upgrade system
alias upgrade='sudo apt-get update && sudo apt-get dist-upgrade'

function cpanupdate {
    for i in $(cpan-outdated --local-lib-contained=/home/erez/.perl5/); do
        if [[ $i =~ IDOPEREL ]]; then
            echo "found $i - will not update"
        else
            cpanm $i;
        fi;
        echo;
    done;
}

alias upall='upgrade; cpanupdate; got update'

# routing

source ~/.route.sh

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias node='nodejs'
alias js='js17'
alias acme='acme -f $PLAN9/font/fixed/unicode.6x12.font &'
alias dentro='firefox -app /home/erez/dev/dentro/application.ini &'

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
