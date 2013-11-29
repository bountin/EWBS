#!/bin/bash

BIN='./dlv.i386-apple-darwin-iodbc'
OPTS='-N=175 -filter=UNCOMPUTED_c,UNCOMPUTED_p,UNEXPECTED_c,UNEXPECTED_p,DUPLICATED_c,DUPLICATED_p'

for CLASS in g b s system;
do
	if [ "$CLASS" == "system" ]; then
		TESTER='system_tester.dl connect.dl s.dl g.dl b.dl'
	else
		TESTER='component_tester.dl $CLASS.dl'
	fi

	echo "----- Test class $CLASS ----"
	for TEST in $CLASS.test* extTests/*/$CLASS.test*;
	do
		RES=`eval "$BIN $OPTS $TESTER $TEST" | sed -e 's/DLV \[build .*//'`
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
