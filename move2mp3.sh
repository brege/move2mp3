#!/bin/bash

# Summary: Copy directories containing mp3's to mp3 directory
# Author: divreg

# Specify base directory $1 
if [ "$1" != "" ] ; then
	cd $1 > /dev/null 2>&1
else 
	cd "/storage/music/flac"
fi

# Specify mp3 directory $2
if [ "$2" != "" ] ; then
	mp3dir="$2"
else mp3dir="/storage/music/mp3"
fi

base=$( pwd )

for directory in $(find $base -type d) ; do
	cd $base
	cd $directory > /dev/null 2>&1
	files=$(ls *.[Mm][Pp]3 2> /dev/null | wc -l)
	if [ $files != "0" ] ; then
		reldir="."$( echo $directory | sed s^"$base"^^ )
		cd $base
		rsync -Rrtvz --delete --force $reldir $mp3dir > /dev/null 2>&1
#		cp -r "$directory" "$mp3dir"
		echo "Syncing $directory to $mp3dir"
		continue
	fi
done

echo "Complete!  Check $mp3dir for your new files!"

exit 0
