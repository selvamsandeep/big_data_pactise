sqoop import \
    --connect jdbc:mysql://ms.itversity.com:3306/retail_db \
    --username retail_user \
    --password itversity \
    --table categories 

hadoop fs -cat categories/part-m-00000

sqoop import \
    --connect jdbc:mysql://ms.itversity.com:3306/retail_db \
    --username retail_user \
    --password itversity \
    --table categories \
    --target-dir categories_target \
    --m 1 
hadoop fs -cat categories_target/part-m-00000

sqoop import \
    --connect jdbc:mysql://ms.itversity.com:3306/retail_db \
    --username retail_user \
    --password itversity \
    --table categories \
    --warehouse-dir categories_worehouse \
    --m 1
    
    