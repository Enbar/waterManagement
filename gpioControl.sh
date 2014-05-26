#!/bin/sh

PUMP_OUT="7"
PUMP_IN="8"
ON="1"
OFF="0"

param1=$1
param2=$2


echo "set both pump run"

#echo $PUMP_OUT > /sys/class/gpio/export
#echo "out" > /sys/class/gpio/gpio7/direction

echo $1 > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio$1/direction

echo $2 > /sys/class/gpio/gpio$1/value
#echo $ON > /sys/class/gpio/gpio8/value

echo "pump set"
