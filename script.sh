#!/bin/bash
if [ $# -eq 0 ]
   then
	SERVER="Default"
   else
	SERVER=$1
fi

CURR_DATE=$(date +'%d_%m_%Y')
FILENAME=./${SERVER}_${CURR_DATE}_running.out


curl https://raw.githubusercontent.com/GreatMedivack/files/master/list.out -s | grep Running | awk '{print $1}' > $FILENAME

mkdir ./archives 2> /dev/null
tar -czf ./archives/${SERVER}_${CURR_DATE}.tar.gz ./$FILENAME
tar -tvzf ./archives/${SERVER}_${CURR_DATE}.tar.gz >> /dev/null && GOOD=1

if [ $GOOD -eq 1 ]
	then
		echo "Archive created and not corrupted!"
	else
		echo "Archive damaged"
fi

rm -f $FILENAME
