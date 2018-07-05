# ssport
Port open/close and data traffic log option for centos 6.   
ONLY TESTED UNDER CENTOS 6! OTHER OS NOT GUARANTEED!  
Automatically creates a script 'logcsv.sh' which functions as traffic logger. Cronjob can call this scipt to log data. Manually running it is also possible.  
Log data is saved in '/portlog.csv' with 3 columns: (Timestamp in Unix format), port and (Traffic since last log in bytes)  

Flags: (One flag at a time)

-a (portnum): Open port  
-d (portnum): Close port  
-m (portnum): Add port to the monitor list.  
-n (portnum): Delete port from the monitor list.  
-c (min): Start monitoring task, logs data every (min)minutes.  
-s: Stop monitoring task.  
-l: Check iptables for opened port in list.  
-h: Show help message.

# push2google.py
Fill in the script url into the file and run by 'python push2google.py'. Cronjob recommended. Maximum row limited to 200000 
Rename the target sheet to 'Raw', In google sheets paste the script:
```JavaScript
function appendLines(worksheet, csvData) {
  var ss = SpreadsheetApp.openById("ONLINE.FILE.ID.CODE");
  var sheet = ss.getSheetByName(worksheet);

  var rows = Utilities.parseCsv(csvData);

  for ( var i = 0; i < rows.length; i++ ) {
    sheet.appendRow(rows[i]);
  }
}

function trimOldData(){
  var ss = SpreadsheetApp.openById("ONLINE.FILE.ID.CODE");
  var sheet = ss.getSheetByName('Raw');
  if (sheet.getLastRow()>=200000) {sheet.deleteRows(2, 1000);}
}

function doPost(e){
  var contents = e.postData.contents;
  var sheetName = e.parameter['sheet'];
  
  appendLines(sheetName, contents);
  var params = JSON.stringify(e);
  return ContentService.createTextOutput(params);
}
```
