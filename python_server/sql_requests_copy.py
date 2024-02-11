import mysql.connector



def sql_grade_add(sqlconn,grade,klasa):
    newcursor=sqlconn.cursor()
    sql_grade=str(grade)
    sql_klasa=str(klasa)
    #insert into klasa_1 values('',5);
    
    sql_statement="insert into klasa_"+sql_klasa+" values ('',"+sql_grade+");"
    newcursor.execute(sql_statement)
    sqlconn.commit()



def sql_get_grades(sqlconn,klasa):
    results=list

    newcursor=sqlconn.cursor()

    newcursor.execute("select grade from klasa_"+str(klasa)+";")

    results=newcursor.fetchall()


    return results



def sql_get_notes(sqlconn):

    results=list

    newcursor=sqlconn.cursor()

    newcursor.execute("select id_note,title_note,text_note from notes;")

    results=newcursor.fetchall()


    return results


def sql_update_note(sqlconn,id,title,text):

    newcursor=sqlconn.cursor()

    newcursor.execute(f"update notes set title_note= '{title}',text_note='{text}' where id_note={id};")
    sqlconn.commit()



def sql_delete_note(sqlconn,id):
    newcursor=sqlconn.cursor()

    newcursor.execute(f"DELETE FROM notes WHERE id_note = {id};")
    sqlconn.commit()

def sql_add_note(sqlconn,title):
    newcursor=sqlconn.cursor()

    newcursor.execute(f"insert into notes (`id_note`, `title_note`, `text_note`) VALUES (NULL, '{title}', '');")

    sqlconn.commit()