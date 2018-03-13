createfile()
{
cat > logcsv.sh << EOF
#!/bin/sh

datetime=\$(date '+%Y-%m-%d %H:%M:%S');
/sbin/iptables -Z
EOF

chmod +x logcsv.sh
}


amonitport()
{
PORT=$1;
if grep -Fwq "$PORT" logcsv.sh;then
echo "Port Already Exists!"
else
sed -i '4i\
traffic'$PORT'=$(/sbin/iptables -n -v -L -t filter -x|grep -i '\''spt:'$PORT''\'' |awk -F'\'' '\'' '\'''\''{print $2}'\'');
' logcsv.sh
echo 'echo $datetime,$traffic'$PORT' >> /'$PORT'.csv' >> logcsv.sh
echo "Add log port '$PORT' Success!"
fi
}


if [ ! -f "logcsv.sh" ];
then createfile;
fi;
amonitport $1
