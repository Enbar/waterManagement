
#params: PUMP [in, out] | TIME [s]

PUMP_OUT="7"
PUMP_IN="8"
START="1"
STOP="0"
MAX_TIME_SEC=180

red='\e[0;31m'
green='\e[0;32m'
NC='\e[0m' # No Color

pump=666
setTime=0

if [ -n "$2" ]; then
  setTime=$2
fi

if [ "$setTime" -gt "$MAX_TIME_SEC" ]; then
  echo -e "\e[0;31WARNING!\e[0m Set higher time than 180 seconds, is set to 180!"
fi

case $1 in 
  in)  echo -e "${green}room${NC} water pump set!"
          pump=$PUMP_OUT
          ;;
          
  out)  echo "${green}balkony${NC} water pump set!"
          pump=$PUMP_IN
          ;;
  -h)  echo "params: "
       echo "	<pump> (in, out)"
       echo "	<time> (seconds)"
       ;;
          
  *)  echo "${red}No argument for pump!"
          ;;
esac

if [ "$pump" != "666" ]; then
  echo $pump > /sys/class/gpio/export
  echo "out" > /sys/class/gpio/gpio$pump/direction
  echo $START > /sys/class/gpio/gpio$pump/value  
  echo "Pump is running..."

  for pc in $(seq 0  $MAX_TIME_SEC); do
    remainedTime=$(( setTime - pc ))
    echo -ne "Will be stopped in ${green}$remainedTime sec   \\r"
    sleep 1

  if [ "$remainedTime" -eq 1 ]; then 
     break
  fi
  done

  echo $STOP > /sys/class/gpio/gpio$pump/value
  echo $pump > /sys/class/gpio/unexport
  echo
  echo "Pump is stopped!"
fi

exit

