#!/bin/bash

extensions="*.[c|h|l|y|i|py|js|ejs]*";
grepopts="-n -H";

if [ -z "$1" ]; then
  echo "usage: $0 [egrep options: -i -C n] string";
  exit;
fi

# check for -L support
find -L /dev/null > /dev/null;
if [ "$?" -eq 0 ] ; then l="-L"; fi


searchstr="$1";
if [ "$2" !=  "" ]; then
  grepopts="$grepopts $1";
  searchstr="$2";
fi
echo "searching for '$searchstr' ... (grep $grepopts)";
find $l . -name "$extensions" -exec egrep $grepopts "$searchstr" {} \; 2>/dev/null;
