PORT=$1
if grep -Fwq "$PORT" logcsv.sh;then
sed -i '/\<'$PORT'\>/d' logcsv.sh
echo "Delete log port '$PORT' Success!"
else
echo "Port does not exist!"
fi
