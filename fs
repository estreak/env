#!/bin/bash
if [ -z "$1" ]; then
    echo usage: $0 [egrep options: -i -C n] string
exit
fi
find -L /dev/null > /dev/null
if [ "$?" -eq 0 ] ; then
    l="-L"
fi
if [ "$2" !=  "" ]; then
echo "searching for $2 ... (grep $1)";
find $l . -name "*.[c|h|l|y|i|py|js]*" -exec egrep $1 -n -H "$2" {} \; 2>/dev/null
else
echo "searching for $1 ...";
find $l . -name "*.[c|h|l|y|i|py|js]*" -exec egrep -n -H "$1" {} \; 2>/dev/null
fi
