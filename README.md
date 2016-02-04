### Liquibase ###

#### Liquibase installation and configuration ####

1. Download liquibase from [Liquibase download page](https://github.com/liquibase/liquibase/releases/download/liquibase-parent-3.4.2/liquibase-3.4.2-bin.zip) .

2. Extract `liquibase-3.4.2-bin.zip` into your working directory.

3. Add full path of `your_working_dir/liquibase-3.4.2-bin` path to PATH environment variable.  
  
  In Ubuntu 14.04,include liquibase path to PATH environment variable as follows:
    $vim ~/.bashrc
    open and add `export PATH="your_working_dir/liquibase-3.4.2-bin:$PATH"` at the end of file and save this file with pressing :wq and ENTER.

    $source ~/.bashrc

  In Windows systems,add `your_working_dir/liquibase-3.4.2-bin` to the system path.

4. Run `liquibase` at your terminal or command promt.If it outputs something help command then you have successfully configured liquibase.

#### Project Structure ####


        database/
        ├── changelog
        |   ├── db.changelog-master.xml
        |   └── db.changelog-1.0.xml
        |   ├── db.changelog-1.1xml
        |   └── db.changelog-1.2.xml
        |   └── db.changelog-2.0.xml
        |
        ├── scripts
        |       |__handle_exception.sql  
        ├── lib
        |   ├── postgresql.jar
        |   └── mysql.jar     
        └── README.md


Project hierarchy contains following folders with their significance:  

  1. changelog:  
        This folder maintains all database schema versioning with respective incremental changes.
        `db.changelog-master.xml` includes all changelog versions.

  2. scripts:  
        Sometimes Liquibase can not handle complex SQL scripts related to specific database.Those SQL scripts are loaded in respective changelog version.
        Example `Stored Procedure,Views,Triggers`.

  3. lib:  
        This folder has database drivers which required to maintain JDBC connections at the time of schema migration.

                          
#### Liquibase commands ####

Please follow the [Liquibase commandline help](http://www.liquibase.org/documentation/command_line.html).

#### PostgreSQL schema migration ####

1. Clone this [repositoty](https://github.com/sharadvishe/liquibase.git) into your workspace.
  `git clone https://github.com/sharadvishe/liquibase.git`

2. Go to folder liquibase/database.
    `cd liquibase/database`

3. Execute below command to migrate/rollback changelog versions which are in the folder `changelog`:
    1. To migrate all changelog versions,run below command:  
        `$liquibase --driver=org.postgresql.Driver --classpath=lib/postgresql.jar --changeLogFile=changelog/db.changelog-master.xml --url="jdbc:postgresql://[host]:[port]/[database]" --username=[username] --password=[password] migrate`

    2. To migrate number of changelog versions,run below command:  
        `$liquibase --driver=org.postgresql.Driver --classpath=lib/postgresql.jar --changeLogFile=changelog/db.changelog-master.xml --url="jdbc:postgresql://[host]:[port]/[database]" --username=[username] --password=[password] updateCount          number`

    3. To rollback last number of changelog versions,run below command:  
        `$liquibase --driver=org.postgresql.Driver --classpath=lib/postgresql.jar --changeLogFile=changelog/db.changelog-master.xml --url="jdbc:postgresql://[host]:[port]/[database]" --username=[username] --password=[password] rollbackCount number`

    **Where,**  
        **host**    : PostgreSQL server ip address  
        **port**    : PostgreSQL server port  
        **username**: PostgreSQL server username  
        **password**: PostgreSQL server password  
        **database**: Target PostgreSQL database on which all schema will be maintained.        
