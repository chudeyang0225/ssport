#!/bin/bash

iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $1 -j ACCEPT;
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $1 -j ACCEPT;
iptables -I OUTPUT -s 127.0.0.1 -p tcp --sport $1;
iptables -I OUTPUT -s 127.0.0.1 -p udp --sport $1;
/etc/init.d/iptables save;
/etc/init.d/iptables restart;
