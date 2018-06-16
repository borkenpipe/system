ifsnewline () {
	export IFSOLD=$IFS
	#export IFS=$'\012'
	export IFS=$'\n'
}

ifsold () {
	export IFS=$IFSOLD
}

