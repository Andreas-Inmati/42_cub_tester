#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'

# VALID MAP CHECK

i=69
while [ $i -le 86 ]
do
	./cub3D ./valid_maps/$i.cub &
	timer=0
	while [ $timer -le 20 ]
	do
		sleep 1
		if pgrep -x "cub3D" > /dev/null; then
			break
		fi
		timer=$(($timer + 1))
	done
	if [ $timer -ge 20 ]
	then
		echo -e "${RED}Map failed:"
		echo -e "${YELLOW}$i.cub"
		pkill -9 cub3D
		exit 0
	fi;
	pkill -9 cub3D
	i=$(($i + 1))
done

echo -e "${GREEN}All Valid Maps Passed!"

# INVALID MAP CHECK

i=0
while [ $i -le 176 ]
do
	./cub3D ./invalid_maps/$i.cub &
	sleep 1
	if pgrep -x "cub3D" > /dev/null;
	then
		echo -e "${RED}Map failed during invalid map check:"
		echo -e "${YELLOW}$i.cub"
		pkill -9 cub3D
		exit 0
	fi;
	pkill -9 cub3D
	i=$(($i + 1))
done

echo -e "${GREEN}All Invalid Maps Passed!"
echo -e "${GREEN}PERFECT PARSING BABY!"
echo -e "${GREEN}Sehr Zart!"