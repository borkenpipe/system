#!/bin/sh

LS=/bin/ls
AWK=/usr/bin/awk
LINK_FS="-> "
DEBUG=0;
export DEPTH=0 

quit(){
	exit $1;
}

dref(){
	if [ 99 -lt $DEPTH ] ; then
		return 1 ;
	fi
	export DEPTH=$(( $DEPTH + 1 )) ;
	file=$1 ;
	if [ $DEBUG -gt 0 ] ; then
		echo "file is $file" ;
		echo "depth is $DEPTH" ;
	fi
	if [ -h $file ] ; then
		nextfile=$($LS -l $file | $AWK -F $LINK_FS '{ print $2 }') ;
		dref $nextfile ;
	
	else
		echo $file ;
		return $?
	fi	
}

dref $1 ;
quit $? ;
