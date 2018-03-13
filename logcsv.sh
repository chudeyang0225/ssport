#!/bin/sh

datetime=$(date '+%Y-%m-%d %H:%M:%S');
traffic33635=$(/sbin/iptables -n -v -L -t filter -x|grep -i 'spt:33635' |awk -F' ' ''{print $2}');
traffic33634=$(/sbin/iptables -n -v -L -t filter -x|grep -i 'spt:33634' |awk -F' ' ''{print $2}');
traffic20034=$(/sbin/iptables -n -v -L -t filter -x|grep -i 'spt:20034' |awk -F' ' ''{print $2}');
/sbin/iptables -Z
echo $datetime,$traffic20034 >> /20034.csv
echo $datetime,$traffic33634 >> /33634.csv
echo $datetime,$traffic33635 >> /33635.csv
