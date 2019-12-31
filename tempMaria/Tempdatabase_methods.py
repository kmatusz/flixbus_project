import sqlite3

#connect to testdb2.db database
conn = sqlite3.connect('test_db.db')

c = conn.cursor()


import sqlite3

#connect to test_db.db database
#more important while running those functions
conn = sqlite3.connect('db/test_db.db')

def selectAllUsers(conn):
    c = conn.cursor()
    c.execute("SELECT * FROM users")
    listOfResults=c.fetchall()
    return listOfResults

def getUserId(loginName):
    conn = sqlite3.connect('test_db.db')
    c = conn.cursor()
    c.execute("SELECT * FROM users")



def getUserJobs(loginName):
    conn = sqlite3.connect('test_db.db')
    c = conn.cursor()
    c.execute("""SELECT j.job_name, j.time_created, j.last_run 
                    FROM jobs j
                    JOIN users u ON j.user_created = u.user_id 
                    AND u.name = '"""+loginName+"'")
    listOfResults=c.fetchall()




def select_all_tasks(conn):
    
    c.execute("Select * FROM users")
    printAll(c.fetchall())
 
    rows = cur.fetchall()
 
    for row in rows:
        print(row)


c.execute("Select * from student")
print("\nPresent all data in student table:")
printAll(c.fetchall())

c.execute("Select * from specialisation")
print("\nPresent all data in specialisation table:")
printAll(c.fetchall())

print("\nPresent student and chosen specialisation:")
c.execute("SELECT e.name,e.surname,d.name FROM student e join specialisation d")


#get all results,assign them to the list,fetchall() returns empty list if no results
listOfResults=c.fetchall()
for item in listOfResults:
    print(type(item[0]))
    print(type(item[1]))
    print(item)


# Save (commit) the changes
conn.commit()

# We close the connection and free all resources
conn.close()


#close the connection and free all resources
conn.close()