#!/bin/bash
set -e  
DBU=${DBU:-greg}
DBPW=${DBPW:-didong12}

if [[ ! -d ${DATA_DIR}/mysql ]];then
   echo "mariadb not install,please contact IT "
 
   #initializing mariadb 
    echo "=========Mariadb  init  start ================"
    mysql_install_db  --user=mysql  --ldata=${DATA_DIR}
    echo "=========Mariadb  init  finish ==============="
    #start mariadb 

    /usr/bin/mysqld_safe --user=mysql  > /dev/null  2>&1 &
   flag=1
   while [[ $flag -ne 0 ]];do
          sleep 10
          mysql  -u root  -e  "status"  > /dev/null  2>&1
          if [ $? -eq 0 ];then 
                 flag=0
         fi 
done

    #create localhost and admin user  
       mysql -u root -e "create user '${DBU}'@'%' identified by '${DBPW}' "
       mysql -u root -e "CREATE USER '$DBU'@'localhost' IDENTIFIED BY '$DBPW'"
       mysql -u root -e "CREATE USER '$DBU'@'127.0.0.1' IDENTIFIED BY '$DBPW'" 
       mysql -u root -e "grant all privileges on *.* to '${DBU}'@'%'  with grant option "
       mysql -u root -e "flush privileges"



    #shutdown mariadb for  supervisor
       mysqladmin  -u root    shutdown

     
else 
   if [[ -e ${DATA_DIR}/mysql.sock ]];then
       rm -rf ${DATA_DIR}/mysql.sock 
   fi
fi 




   
