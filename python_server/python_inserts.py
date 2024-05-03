import subprocess
import sql_requests_copy as sql_requests
import psutil
import mysql.connector
import socket
import random





MYSQLdb=mysql.connector.connect(host="localhost",user="root",password="", database="python_dart_conn")


def getrandomint(a,b):
    return random.randint(a,b)



def add_5th_grader():
    add_1st_grade()
    add_2nd_grade()
    add_3rd_grade()
    add_4th_grade()
    add_5th_grade()



def add_1st_grade():
    grade_to_add=int(getrandomint(1,7))

    cursor= MYSQLdb.cursor()

    stmt=f"insert into klasa_1 values('','{grade_to_add}');"

    cursor.execute(stmt)
    MYSQLdb.commit()


def add_2nd_grade():
    grade_to_add=int(getrandomint(2,8))

    cursor= MYSQLdb.cursor()

    stmt=f"insert into klasa_2 values('','{grade_to_add}');"

    cursor.execute(stmt)
    MYSQLdb.commit()



def add_3rd_grade():
    grade_to_add=int(getrandomint(3,9))

    cursor= MYSQLdb.cursor()

    stmt=f"insert into klasa_3 values('','{grade_to_add}');"

    cursor.execute(stmt)
    MYSQLdb.commit()


def add_4th_grade():
    grade_to_add=int(getrandomint(5,10))

    cursor= MYSQLdb.cursor()

    stmt=f"insert into klasa_4 values('','{grade_to_add}');"

    cursor.execute(stmt)
    MYSQLdb.commit()



def add_5th_grade():
    grade_to_add=int(getrandomint(1,10))

    cursor= MYSQLdb.cursor()

    stmt=f"insert into klasa_5 values('','{grade_to_add}');"

    cursor.execute(stmt)
    MYSQLdb.commit()




n=input("how many grades to add?")



for x in range(int(n)):
    add_5th_grader()
    

print(f"{n} gradaes added")

