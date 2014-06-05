
#run ass nophup ./<file> &
#then ps aux, find pid and kill it

sudo modprobe w1-gpio
sudo modprobe w1-therm


while true
do
    cd /sys/bus/w1/devices/28-000004e1d8f5
    temp_in=$(cat w1_slave | grep "t=*" | cut -d '=' -f2)
    cd /sys/bus/w1/devices/28-000004e1da72
    temp_out=$(cat w1_slave | grep "t=*" | cut -d '=' -f2)

#  temp=$(cat w1_slave | grep "t=*" | cut -d '=' -f2)
#  real_temp=$(echo "$temp/1000" | bc -l)
#  echo "Teplota v byte: $real_temp"
#  echo -ne "$text $(($temp/1000)).$((($temp%1000)/100)) °C\\r"

#   echo -ne "In / Out:  $(($temp_in/1000)).$((($temp_in%1000)/100))°C / $(($temp_out/1000)).$((($temp_out%1000)/100))°C\\r"
    dateMark=$(date +%d%m%y)
    currentMinute=$(date +%M)
    loggingDate=$(date +%c)
    echo "$loggingDate\t$temp_in\t$temp_out" >> temperaturesEveryMinute$dateMark.txt
    #store temperatures every 20 minutes
    if [ "$currentMinutes" -eq 00 ] || [ "$currentMinutes" -eq 20 ] || [ "$currentMinutes" -eq 40 ]; then
        echo "$loggingDate\t$temp_in\t$temp_out" >> temperatures$dateMark.txt
        sleep 60
    fi
done
