
# takes C/CH/CHALK/Hop-Scotch-1.2345.tar.gz and checks if
# mversion for Hop::Scotch is smaller or equal to 1.2345

function same_mversion {
	# remove path to file name, remove extention
	input=${1##*/}
	input=${input%%.tar.gz}

	# trim version number and replace '-' with '::'
	module=${input%-*}
	module=${module//-/::}

	output=$(echo $(mversion $module) '<' ${input##*-} | bc -l)
	echo $output
}

alias cpan='cpanm'

# Copy module file name from "Can't locate Hop/Scotch.pm in @INC"
# $ cpam Hop/Scotch.pm
# --> Working on Hop::Scotch

function cpam {
         module=${1//\//::}
         module=${module//\.pm/}
         cpanm $module
}

function perlm {
	params=( "$@" )

	code=${params[${#params[@]}-1]}
	unset params[${#params[@]}-1]

	for (( i = 0 ; i < ${#params[@]} ; i++ )) do
		params[$i]=-M${params[$i]}
	done

   	perl -MModern::Perl ${params[@]} -e $code
}

# compile under Modern::Perl
alias perlc='perl -MModern::Perl -wc '

# gets all (local) libraries that report found update using cpan-outdated
# check if not cpanminus, specific creators or mversion repeats same version
# deletes these items from array and runs them through cpanminus

function cpanupdate {
    modules=$(cpan-outdated --local-lib-contained=/home/erez/.perl5/)

    for i in ${modules[@]}; do
	if [[ $i =~ cpanminus ]]; then
	    cpanm $i
	    modules=( "${modules[0]/$i}" )
	else
	    result=$(same_mversion $i)
	    if [[ -z $result || $result -eq 0 ]]; then
		modules=( "${modules[0]/$i}" )
	    fi
       	fi
    done

    if [ ${#modules[@]} -ne 0 ]; then
        cpanm $modules
    fi
}
