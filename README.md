# Student Placement and Recruitment Analytics 

MySQL 8 project containing 10 separate SQL scripts.

## Execution order
1. 01_Database_Creation.sql
2. 02_Table_Creation.sql
3. 03_Data_Insertion.sql
4. 04_Project_Operations.sql
5. 05_Basic_Queries.sql
6. 06_Join_Queries.sql
7. 07_Views.sql
8. 08_Stored_Procedures.sql
9. 09_Triggers.sql
10. 10_Transactions.sql
11. Supplementary_Execution_Transcript_Queries.sql

This file contains additional SQL commands from the MySQL execution
transcript, including database creation, table creation, data insertion,
project operations, and verification queries.

Note: This is a supplementary reference file. Do not execute it again
on an existing database because it repeats some creation and insertion
commands.

## Important notes
- Run files 01–03 once on a fresh database. Do not run the data insertion file again on a database that already contains the sample records, because duplicate-key errors may occur.
- The table definitions and sample data follow the user's MySQL execution transcript.
- The project document supplies JOINs, four views, two complete stored-procedure definitions, and three triggers.
- Basic Queries and Transactions are additional SQL examples based on the project's existing tables because those sections are not present in the supplied document.
- The document labels the first stored procedure as an IN-parameter procedure, but the SQL shown actually uses an OUT parameter. The script preserves the actual SQL definition.
