#!/bin/bash
set  -e

if  [[  -e /scripts/first ]];then
     bash /scripts/firstrun_maria.sh >/dev/null  2>&1 
     rm -rf /scripts/first 
     
else
     if [[ -e $DATA_DIR/mysql.sock ]];then 
          rm -rf  $DATA_DIR/mysql.sock 
     fi

fi   
exec  /usr/bin/mysqld_safe 

