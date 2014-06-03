#!/bin/sh

#params: PUMP [in, out] | TIME [s]

PUMP_OUT="7"
PUMP_IN="8"
START="1"
STOP="0"
MAX_TIME_SEC=180

pump=666
time=0

setTime=$2
if (( setTime > MAX_TIME_SEC )); then
  setTime=180
  echo "WARNING! Set higher time than 180 seconds, is set to 180!"
fi

case "$1" in 
  in)  echo "room water pump set!"
          pump=$PUMP_OUT
          ;;
          
  out)  echo "balkony water pump set!"
          pump=$PUMP_IN
          ;;
          
  *)  echo "Unknown command!"
          ;;
esac

if (( pump != 666 )); then 
  echo $pump > /sys/class/gpio/export
  echo "out" > /sys/class/gpio/gpio+$pump/direction
  echo $START > /sys/class/gpio/gpio+$pump/value
  
  echo "pump is running..."
  
  for pc in $(seq 0  MAX_TIME_SEC); do
    remainedTime=$(( setTime - pc ))
    echo -ne "remained Time: $remainedTime   \\r"
    sleep 1
    if (( $remainedTime == 0 )) ; then
      break
    fi
  done

  echo $STOP > /sys/class/gpio/gpio+$pump/value
  echo $pump > /sys/class/gpio/unexport

  echo "Pump is stopped!"
else
  echo "ERROR Unknown pump"
fi

exit

