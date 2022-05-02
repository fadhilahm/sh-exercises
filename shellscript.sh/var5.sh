#! /bin/bash
OLD_IFS="$IFS"
IFS=:
echo "Please input some data separated by colons ..."
read x y z
IFS=$OLD_IFS
echo "x is $x y is $y z is $z"

