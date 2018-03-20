#!/bin/bash

aport()
{
PORT=$1;
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $PORT -j ACCEPT;
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $PORT -j ACCEPT;
iptables -I OUTPUT -p tcp --sport $PORT;
iptables -I OUTPUT -p udp --sport $PORT;
/etc/init.d/iptables save;
/etc/init.d/iptables restart;
}

dport()
{
PORT=$1;
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $PORT -j ACCEPT;
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $PORT -j ACCEPT;
iptables -D OUTPUT -p tcp --sport $PORT;
iptables -D OUTPUT -p udp --sport $PORT;
/etc/init.d/iptables save;
/etc/init.d/iptables restart;
}

createcronfile()
{
cat > logcsv.sh << EOF
#!/bin/sh
mkdir -p /portlog
timestamp=\$(date +%s);
/sbin/iptables -Z
EOF

chmod +x logcsv.sh
}


alogport()
{
if [ ! -f "logcsv.sh" ];
then createcronfile;
fi;

PORT=$1;
if grep -Fwq "$PORT" logcsv.sh;then
echo "Port Already Exists!"
else
sed -i '4i\
traffic'$PORT'=$(/sbin/iptables -n -v -L -t filter -x|grep -i '\''tcp spt:'$PORT''\'' |awk -F'\'' '\'' '\''{print $2}'\'');
' logcsv.sh
echo 'echo $timestamp,'$PORT',$traffic'$PORT' >> /portlog.csv' >> logcsv.sh
echo "Add log port '$PORT' Success!"
fi
}


dlogport()
{
PORT=$1
if grep -Fwq "$PORT" logcsv.sh;then
sed -i '/\<'$PORT'\>/d' logcsv.sh
echo "Delete log port '$PORT' Success!"
else
echo "Port does not exist!"
fi
}

acron()
{
INTERVAL=$1
cwd=$(pwd)
(crontab -l ; echo "*/$INTERVAL * * * * $cwd/logcsv.sh") | crontab -
service crond restart
chkconfig crond on
echo "Crontab added successfully!"
}

dcron()
{
cwd=$(pwd)
crontab -l | grep -v '$cwd/logcsv.sh'  | crontab -
service crond restart
echo "Crontab deleted successfully!"
}


while getopts a:d:m:n:c:ps option
do
case "${option}"
in
a) 
	activity="aport"
	PORT=${OPTARG};;
d) 
	activity="dport"
	PORT=${OPTARG};;
m)
        activity="monitor"
        PORT=${OPTARG};;
n)
        activity="unmonitor"
        PORT=${OPTARG};;
c)
        activity="acron"
        INTERVAL=${OPTARG};;
s)
        activity="dcron";;
p)
	activity="checkiptable";;

esac
done

if [ $activity = "aport" ];then
aport $PORT;
elif [ $activity = "monitor" ];then
alogport $PORT;
elif [ $activity = "dport" ];then
dport $PORT;
elif [ $activity = "unmonitor" ];then
dlogport $PORT;
elif [ $activity = "acron" ];then
acron $INTERVAL;
elif [ $activity = "dcron" ];then
dcron;
elif [ $activity = "checkiptable" ];then
iptables -vnL;
else
echo "Input error!"
fi
