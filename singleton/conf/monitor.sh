#!/bin/bash

export WEB1="http://localhost:8081"
export WEB2="http://localhost:8082"

function runCommand() {
	curl POST --url $1/jms/admin -H "Content-Type: text/plain" -d $2 -s -f
}

function checkStatus() {
	WEB1Status=-$(runCommand $WEB1 status)
	WEB2Status=-$(runCommand $WEB2 status)
	echo "WEB1 Status is $WEB1Status"
	echo "WEB2 Status is $WEB2Status"
}
checkStatus

if [ $WEB1Status != "-ok" ]
then
	echo WEB1 $(runCommand $WEB1 start)
fi

checkStatus

if [ $WEB1Status != "-ok" ]
then
	echo WEB2 $(runCommand $WEB2 start)
else
	echo WEB2 $(runCommand $WEB2 stop)
fi

echo "resulting status is :"
checkStatus