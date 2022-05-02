#! /bin/bash
echo "User is ${USER}"
MYNAME=`grep "^${USER}:" /etc/passwd | cut -d: -f5`
echo "$MYNAME"

