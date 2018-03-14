# ssport
Port open/close and data traffic log option for centos6  
Log data is saved in current directory as '(portnum).csv' with 2 columns: (Timestamp) and (Traffic since last log)  

Flags:

-a (portnum): Open port, add port to the monitor list.  
-d (portnum): Close port, delete port from the monitor list.  
-c (min): Start monitoring task, logs data every (min)minutes.  
-s: Stop monitoring task.  
-p: Check iptabls for port in list.  
