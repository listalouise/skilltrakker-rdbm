*Steps to Generate the Documentation from the database:*

If you dont have the database, please use the script "API_Skilltrakker_fk.sql"

1) Download schemaspy-6.1.0.jar

2) Find/download the connector for your database in java, in this example we are using mysql, so will be mysql-connector-java-version

3) Run the next command:

java -jar schemaspy-6.1.0.jar -t mysql -dp ROUTE_TO_JAVA_CONECTOR -db DB_NAME -host HOST -port PORT -s DB -u USERNAME -p PASSWORD -o DESTINATION

Example:

java -jar schemaspy-6.1.0.jar -t mysql -dp /usr/share/java/mysql-connector-java-8.0.21.jar -db Skilltrakker_API -host localhost -port 3306 -s Skilltrakker_API -u alexskull -p 20516686 -o /home/alexskull/htdocs/datamodelskilltrakker.local/
