#!/bin/bash

BIN='./dlv.i386-apple-darwin-iodbc'
OPTS='-N=75 component_tester.dl -filter=UNCOMPUTED_c,UNCOMPUTED_p,UNEXPECTED_c,UNEXPECTED_p,DUPLICATED_c,DUPLICATED_p'

for CLASS in g b s;
do
	echo "----- Test class $CLASS ----"
	for TEST in $CLASS.test* ;
	do
		RES=`eval "$BIN $OPTS $CLASS.dl $TEST" | sed -e 's/DLV \[build .*//'`
		COUNT=`eval echo '$RES' | wc -c`
		echo -n $TEST "..... "
		if [ $COUNT -eq 3 ]; then
			echo "OK"
		else
			echo "FAILED"
			echo $RES
		fi
	done
done;
