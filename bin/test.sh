#!/bin/bash
var1=$*
var2=$@
echo "var1: $var1"
echo "var2: $var2"
countvar1=1
countvar2=1
for param in "$*"
do
    echo "first loop param$countvar1: $param"
    countvar1=$[ $countvar1 + 1 ]
done
echo "countvar1: $countvar1"

for param in "$@"
do
    echo "second param$countvar2: $param"
    countvar2=$[ $countvar2 + 1 ]
done
echo "countvar2: $countvar2"


# sh ./bin/test.sh 12 34 56 78
# var1: 12 34 56 78
# var2: 12 34 56 78
# first loop param1: 12 34 56 78
# countvar1: 2
# second param1: 12
# second param2: 34
# second param3: 56
# second param4: 78
# countvar2: 5