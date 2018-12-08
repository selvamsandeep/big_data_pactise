sqoop version 

sqoop help

mysql -u retail_user -h ms.itveristy.com -p

sqoop list-databases \
    --connect jdbc:mysql://ms.itversity.com:3306 \
    --username retail_user \
    --password itversity

sqoop help list-tables

sqoop list-tables \
    --connect jdbc:mysql://ms.itversity.com:3306/retail_db \
    --username retail_user \
    --password itversity     

sqoop eval \
    --connect "jdbc:mysql://ms.itversity.com:3306/retail_db" \
    --username retail_user \
    --password itversity \
    --query "select * from orders limit 10" 

 sqoop eval \
    --connect "jdbc:mysql://ms.itversity.com:3306/retail_db" \
    --username retail_user \
    --password itversity \
    --query "describe orders"   

sqoop eval -get -> sqoop import ->sqoop eval -log

sqoop import \
    --connect "jdbc:mysql://ms.itversity.com:3306/retail_db" \
    --username retail_user \
    --password itversity \
    --table orders \
    --target-dir /user/selvamsand/sqoop_import/orders


hadoop fs -ls /user/selvamsand/sqoop_import/orders

sqoop import \
    --connect "jdbc:mysql://ms.itversity.com:3306/retail_db" \
    --username retail_user \
    --password itversity \
    --table order_items \
    --warehouse-dir /user/selvamsand/sqoop_import 


 sqoop eval \
    --connect "jdbc:mysql://ms.itversity.com:3306/retail_db" \
    --username retail_user \
    --password itversity \
    --query "select min(order_item_id), max(order_item_id) from \
    order_items"


 sqoop import \
    --connect "jdbc:mysql://ms.itversity.com:3306/retail_db" \
    --username retail_user \
    --password itversity \
    --table orders \
    --target-dir /user/selvamsand/sqoop_import/orders \
    --delete-target-dir



sqoop import  \
    --connect "jdbc:mysql://ms.itversity.com:3306/retail_db"  \
    --username retail_user \
    --password itversity \
    --table order_items_nopk \
    --target-dir /user/selvamsand/sqoop_import/order_item_nopk \
    --split-by order_item_order_id

sqoop import \
    --connect "jdbc:mysql://ms.itversity.com:3306/retail_db" \
    --username retail_user \
    --password itversity \
    --table orders \
    --target-dir /user/selvamsand/sqoop_import/orders \
    --delete-target-dir \
    --compress \
    --compression-codec  org.apache.hadoop.io.compress.SnappyCodec \
    --as-avrodatafile

sqoop import \
    --connect "jdbc:mysql://ms.itversity.com:3306/retail_db" \
    --username retail_user \
    --password itversity \
    --table  orders \
    --target-dir /user/selvamsand/sqoop_import/orders \
    --delete-target-dir \
    --compress \
    --compression-codec org.apache.hadoop.io.compress.GzipCodec \
    --as-textfile

sqoop import \
    --connect "jdbc:mysql://ms.itversity.com:3306/retail_db" \
    --username retail_user \
    --password itversity \
    --target-dir /user/selvamsand/sqoop_import/order_complete \
    --query "select * from orders where \$CONDITIONS and order_date like '2013%'" \
    --split-by order_id \
    --delete-target-dir


sqoop import \
    --connect "jdbc:mysql://ms.itversity.com:3306/retail_db" \
    --username retail_user \
    --password itversity \
    --table orders \
    --target-dir /user/selvamsand/sqoop_import/order_13  \
    --where "order_date like '2013%'" \
    --delete-target-dir

sqoop import \
    --connect "jdbc:mysql://ms.itversity.com:3306/retail_db" \
    --username retail_user \
    --password itversity \
    --target-dir /user/selvamsand/sqoop_import/order_complete \
    --query "select * from orders where \$CONDITIONS and order_date like '2013%'" \
    --split-by order_id \
    --delete-target-dir \
    --fields-terminated-by '\t'

hadoop fs -ls  /user/selvamsand/sqoop_import/order_complete

hadoop fs -cat  /user/selvamsand/sqoop_import/order_complete/part-m-00000 | tail

#hive import

sqoop import \
    --connect "jdbc:mysql://ms.itversity.com:3306/retail_db" \
    --username retail_user \
    --password itversity \
    --table order_items \
    --hive-import \
    --hive-database selva_sqoop_import \
    --m 2
1:08


