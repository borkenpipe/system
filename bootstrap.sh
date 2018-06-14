
export DEFAULT_SOURCE_FILE=$HOME/.default_source

COLOR_RED="\e[31;1m"
COLOR_GREEN="\e[32;1m"
COLOR_YELLOW="\e[33;1m"
COLOR_NONE="\e[0m"

colorgreen()
{
    echo -e $COLOR_GREEN"$1"$COLOR_NONE
}

colorred()
{
    echo -e $COLOR_RED"$1"$COLOR_NONE
}

fail()
{
    echo -e $COLOR_RED"[FAILED] $1"$COLOR_NONE >&2
    exit 1
}

info()
{
    echo "[*] $1" >&2
}

warn()
{
    echo -e $COLOR_YELLOW"[WARN] $1"$COLOR_NONE >&2
}

debug()
{
    if [ -n $debug ] ; then 
        echo "[D] $1" >&2
    fi
}

success()
{
    echo -e $COLOR_GREEN"[SUCCESS] $1"$COLOR_NONE >&2
}

export_to_file()
{
	local key=$1
	local val=$2
	local file=$3
	echo $1 $2 $3
	if [ -z "$key" ] ; then
		warn "Cannot export to file because you didn't give me a key"
		return 1
	fi
	if [ -z "$val" ] ; then
		warn "Cannot export to file because you didn't give me a value"
		return 1
	fi
	if [ -z "$file" ] ; then
		warn "Using default source: $DEFAULT_SOURCE_FILE"
		file=$DEFAULT_SOURCE_FILE
	fi
	echo $key=$val >> $file
	return 0
}
