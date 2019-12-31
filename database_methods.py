
import sqlite3

#connect to test_db.db database
#more important while running those functions
#conn = sqlite3.connect('db/test_db.db')

def selectAllUsers(conn):
    c = conn.cursor()
    c.execute("SELECT * FROM users")
    listOfResults=c.fetchall()
    conn.close()
    return listOfResults



def getUserJobs(loginName):
    conn = sqlite3.connect('test_db.db')
    c = conn.cursor()
    c.execute("""SELECT j.job_id, j.job_name, j.time_created, j.last_run 
                    FROM jobs j
                    JOIN users u ON j.user_created = u.user_id 
                    AND u.name = '"""+loginName+"'")
    listOfResults=c.fetchall()
    conn.close()
    return listOfResults





# Save (commit) the changes
#conn.commit()
