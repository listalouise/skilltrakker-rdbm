## Documentation for the Datamodel

> Converts a Database into a static html page

**Steps to Generate the Documentation from the database:**

If you dont have the database, please use the script [API_Skilltrakker_fk.sql](https://github.com/listalouise/skilltrakker-rdbm/blob/master/API_Skilltrakker_fk.sql)

* Download [schemaspy-6.1.0.jar](https://github.com/schemaspy/schemaspy/releases/download/v6.1.0/schemaspy-6.1.0.jar)

* Find/download the connector for your database in java, in this example we are using mysql, so will be mysql-connector-java-version

* Run the next command:


java -jar schemaspy-6.1.0.jar -t **DBEngine** -dp **ROUTE_TO_JAVA_CONECTOR** -db **DB_NAME** -host **HOST** -port **PORT** -s **DB** -u **USERNAME** -p **PASSWORD** -o **DESTINATION**


Example:

```bash
java -jar schemaspy-6.1.0.jar -t mysql -dp /usr/share/java/mysql-connector-java-8.0.21.jar -db Skilltrakker_API -host localhost -port 3306 -s Skilltrakker_API -u alexskull -p 20516686 -o /home/alexskull/htdocs/datamodelskilltrakker.local/
```
After that you gonna get an HTML site with the full Documentation.

## Recomendations

If you made changes into the DB and you wanna regenerate the HTML, delete all the files only leaving:
  * API_Skilltrakker_fk.sql
  * GenerateModel.txt
  * schemaspy-6.1.0.jar
  * Readme.md
That way the bloat is avoided, in case that some structures aren't needed anymore.
