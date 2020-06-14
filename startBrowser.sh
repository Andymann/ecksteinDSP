#!/bin/bash

URL=https://www.mcdonalds-eckstein.de/de/home

while true; do
	wget $URL --spider --retry-connrefused --waitretry=1 --read-timeout=10 --timeout=5 -t 3 >/dev/null 2>&1
	if [ $? -eq 0 ]
	then
		echo "good. we are online"
		pidof chromium
		if [ $? -ne 0 ]
		then
			echo starting Chromium
			chromium --kiosk $URL &
		else
			echo Chromium already running
		fi
		sleep 10
		pkill feh
	else
		echo "bad. Showing offline image"
		pidof feh
		if [ $? -ne 0 ]
		then
			feh -F /home/pi/Pictures/mcd.jpg &
			sleep 3
			echo killing Chromium
			pkill chromium
		else
			echo Image already showing
		fi
	fi
	echo wait 10 seconds
	sleep 10
done

# chromium update-msg fuer ein jahr nach hinten schieben
#sudo touch /etc/chromium-browser/customizations/01-disable-update-check;echo CHROMIUM_FLAGS=\"\$\{CHROMIUM_FLAGS\} --check-for-update-interv$


#while true; do
#        pkill chromium
#        sleep 3
#        chromium --kiosk http://www.google.de
#        #echo NACH CHROMIUM
#        sleep 5
#done

