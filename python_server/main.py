import subprocess
from flask import Flask
from flask_restful import Api, Resource, reqparse
import sql_requests_copy as sql_requests
import psutil
import mysql.connector
import socket



def getUserIpAdress():
    hostname = socket.gethostname()
    ## getting the IP address using socket.gethostbyname() method
    ip_address = socket.gethostbyname(hostname)
    return ip_address


def check_mysqld_status():
    running = False

    for process in psutil.process_iter(['name']):
        if process.info['name'] == 'mysqld.exe':
            running = True
            break

    return running


def check_apache_status():
    running = False

    for process in psutil.process_iter(['name']):
        if process.info['name'] == 'httpd.exe':
            running = True
            break

    return running



def start_apache():
    subprocess.Popen(["C:/xampp/mapache_start.bat"], shell=True, creationflags=subprocess.CREATE_NEW_CONSOLE)
    print("apache invoked")


def start_mysql():
    subprocess.Popen(["C:/xampp/mysql_startxd.bat"], shell=True, creationflags=subprocess.CREATE_NEW_CONSOLE)
    print("mysql invoked")




if(not check_mysqld_status()):
    start_mysql()

if(not check_apache_status()):
    start_apache()




try:
    MYSQLdb=mysql.connector.connect(host="localhost",user="root",password="", database="python_dart_conn")
except Exception as error: 
    
    print(error)
    exit("Server shutting down...")

else: 
    print("Server succesfully connected to sql")


















app =Flask(__name__)
api = Api(app)

database_get_args= reqparse.RequestParser()
database_get_args.add_argument("class",type=str, help="class is required", required=True)



database_post_args=reqparse.RequestParser()

database_post_args.add_argument("class",type=int, help="class is required", required=True )
database_post_args.add_argument("grade",type=int, help="grade is required", required=True )



class HelloWorld(Resource):
    def get(self):

        args=database_get_args.parse_args()
        klasa = args['class']



        results=sql_requests.sql_get_grades(MYSQLdb,klasa)

        grade_list = [item for sublist in results for item in sublist]

        grade_strings = [str(grade) for grade in grade_list]

                    
       
        
        print({"GRADES SENT": grade_strings})
        return {"purpose": "sendingGrades","grades": grade_strings}
    





    def post(self):

        


        args=database_post_args.parse_args()
        klasa=args['class']
        ocena=args['grade']

        print(f"GRADE RECEIVED klasa: {klasa} ocena: {ocena}")
            
        try:
            sql_requests.sql_grade_add(MYSQLdb,ocena,klasa)
        
        except error:
            print(error)



        return {"data": "posted"}


api.add_resource(HelloWorld,"/grades")


if __name__=="__main__":
    from waitress import serve

    print(f"ur local ip: {getUserIpAdress()}\n")

    ip_address=input("ip: ")
    user_port=str(input("\nport(above 5000): "))

    while ip_address:
        try:  
            while True:
                serve(app,host=ip_address,port=user_port)
        except:
            print(error)
            
            continue
            
            
        
     
       
    
    #app.run(host='192.168.0.248',port=5055,debug=False)



