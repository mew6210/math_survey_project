###Math survey project

##Server

Python-based, uses Flask to host the http server.
Uses 'Waitress' to make the flask server production-ready.

Supports 2 requests, post and get.
Database to which it connects is a simple apache sql db server, that is hosted on the same machine as the http server is. 
If u want to use it on ur machine, u will have to change the name of the table that it refers to, and make additional .exe files that run apache and sql.
Server detects if apache or mysql is not running, and starts them with those newly made .exe files.



#Get
User provides the number of a class, from which they want to get grades.



#Post
User provides the number of a class, and a grade that they want to add to that class.



##Client
App made in flutter, u provide ip address and port of the http server. If u want server and app to run on LAN and WAN then u will have to think about port-forwarding in ur router.
After inputing ip and a port, first tab uses get request to gather the grades from a given class, and displays it in some nice graphs, using a great fl_chart library.
Second tab on the other hand uses post request to input grades to a given class.
