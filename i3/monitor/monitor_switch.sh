#!/bin/bash
increase_current=0
force_set=-1

monitor_config_file=~/.config/i3/monitor/current_monitor

declare -a monitors
monitors=( ~/.screenlayout/laptop_monitor_left_right.sh ~/.screenlayout/laptop_only.sh ~/.screenlayout/monitor_only.sh ) 

while [ -n "$1" ]; do # while loop starts
 
    case "$1" in
 
    -inc) increase_current=1 ;;

    -dec) increase_current=-1 ;;

    -set) force_set=$2 ;;
 
    esac
 
    shift
 
done

if [ $force_set -gt -1 ]
then
    current=$(($force_set % ${#monitors[@]}))
else
    current=$(<$monitor_config_file)
    current=$((($current + $increase_current) % ${#monitors[@]}))
fi

echo $current > $monitor_config_file

${monitors[$current]}

i3-msg restart
