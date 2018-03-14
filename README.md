# ssport
Port open/close and data traffic log option for centos 6.   
ONLY TESTED UNDER CENTOS 6! OTHER OS NOT GUARANTEED!  
Automatically creates a script 'logcsv.sh' which functions as traffic logger. Crontab can call this scipt to log data. Manually running it is also possible.  
Log data is saved in current directory as '(portnum).csv' with 2 columns: (Timestamp) and (Traffic since last log)  

Flags:

-a (portnum): Open port, add port to the monitor list.  
-d (portnum): Close port, delete port from the monitor list.  
-c (min): Start monitoring task, logs data every (min)minutes.  
-s: Stop monitoring task.  
-p: Check iptabls for port in list.  
