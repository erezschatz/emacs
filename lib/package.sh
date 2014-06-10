
function upgrade {
	name=$(uname -a)
	if [[ $name =~ Ubuntu || $name =~ Debian ]]; then
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

function delete {
	name=$(uname -a)
	if [[ $name =~ Ubuntu || $name =~ Debian ]]; then
            for arg in $*; do
	        sudo apt-get purge $arg
	        sudo apt-get autoremove --purge
            done
	elif [[ $name =~ ARCH ]]; then
            for arg in $*; do
		sudo pacman -Rsn $arg
            done
	else
		echo "Unknown operating system uname $name"
	fi
        orphaned
}

function orphaned {
    if [[ $name =~ Ubuntu || $name =~ Debian ]]; then
	sudo deborphan
    elif [[ $name =~ ARCH ]]; then
	pacman -Qtdq
    else
	echo "Unknown operating system uname $name"
    fi
}
