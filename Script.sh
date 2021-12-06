#!/bin/bash
#Script to Discover the size of DB 
export HISTFILESIZE=1
export HISTSIZE=4
unset HISTFILE
if [ "X$1" == "X" -o "X$2" == "X" ]; then
    echo "Usage: $0 <product> and the <client>   "
    exit 255
fi
PRODUCT=$1
CLIENT=$2

src_db_name=$(grep DB /www/$PRODUCT/$CLIENT/include/config.inc | grep -v "HOST\|USER\|PASS" |grep -v "\/\/" | cut -f2  -d "," | cut -f1 -d ")"  )
src_db_server=$(grep DB_HOST /www/$PRODUCT/$CLIENT/include/config.inc | grep -v "|USER\|PASS" |grep -v "\/\/" | cut -f2  -d "," | cut -f1 -d ")")
src_db_hostname=$(cat /www/INFRA/settings.php | grep $src_db_server | awk '{print $2}' | cut -f1 -d ")" |  tr -d "'")

checkdb=$(mysql -h $src_db_hostname -u <user> -p <password> -se " SELECT table_schema \"DB Name\", ROUND( SUM(data_length + index_length) / 1024 / 1024 / 1024,  1 ) \"DB Size in GB\" FROM information_schema.tables where table_schema = $src_db_name GROUP BY table_schema;")

echo "$checkdb GB"
