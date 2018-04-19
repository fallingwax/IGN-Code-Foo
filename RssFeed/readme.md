IGN-CodeFoo-RssFeed-
RSS Feed Pull

Files:
rssPull.php
config/config.php
ign-content-db-333186af.sql

RssFeed.php is where all the work is being done. The program is grabbing the contents of the RSS Feed into a simple XML Element, parsing through it and storing the data using prepared statements into the MySQL database.

The file "ign-content-db-333186af.sql" is an export of the database that can be used to stored the data from the RSS Feed. The MySql database contains two tables called RssFeedContent and Thumbnails. Both of the tables contain there own Primary Keys for indexing and a Forgein Key on the GUID from the Rss Feed itself. There is function generated to create a random 24 character alphanumeric ID and triggers for each table to ensure that no duplicate ID is used.

The config.php contains four variables for storing the username, password, server name or IP, and the database name. This file on a production server would be hidden from the end user most likely behind an .htaccess file.

Once the databse is created and the config is populated with the correct credentials you only need to run the rssPull.php twice. The first time will grab the data for RssFeedContent and the second will grab the thumbnails due to the Foreign key constraints.   
