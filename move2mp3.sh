#!/bin/bash

# Summary: Move directories containing mp3's to mp3 directory
# Author: divreg

# Specify base directory $1 
if [ "$1" != "" ] ; then
	cd $1 > /dev/null 2>&1
fi

# Specify mp3 directory $2
if [ "$2" != "" ] ; then
	mp3dir="$2"
else mp3dir="/storage/music/mp3/"
fi

base=$( pwd )

for directory in $(find $base -type d) ; do
	cd $base
	cd $directory > /dev/null 2>&1
	files=$(ls *.[mM][Pp4][3a] > /dev/null 2>&1 | wc -l)
	if [ $files != "0" ] ; then
		cd $base
		rsync -rt -v --delete --force $directory $mp3dir > /dev/null 2>&1
#		cp -r "$directory" "$mp3dir"
		echo "Copying $directory to $mp3dir"
#		echo "Moving $directory to $mp3dir$directory"
		continue
	fi
done

echo "Complete!  Check $mp3dir for your new files!"

exit 0
