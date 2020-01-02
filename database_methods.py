
import sqlite3

#connect to test_db.db database
#more important while running those functions
#conn = sqlite3.connect('db/test_db.db')

#not used for now, may be usefull for admin pages
def selectAllUsers(conn):
    c = conn.cursor()
    c.execute("SELECT * FROM users")
    listOfResults=c.fetchall()
    conn.close()
    return listOfResults


#re
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

#get only job_id and job_name from the database for a specific user (for drop-down list generating)
def getUserJobsNames(loginName):
    conn = sqlite3.connect('test_db.db')
    c = conn.cursor()
    c.execute("""SELECT j.job_id, j.job_name 
                    FROM jobs j
                    JOIN users u ON j.user_created = u.user_id 
                    AND u.name = '"""+loginName+"'")
    listOfResults=c.fetchall()
    conn.close()
    return listOfResults



#jobId can be string 'string' or int :) 
#Job results -> the most complicated query in the app so far 
def getResultForJobId(jobId):
    conn = sqlite3.connect('test_db.db')
    c = conn.cursor()
    c.execute("""SELECT dep.city_name, arr.city_name,  r.date, res.time, res.price, 
                    round(res.price/dis.distance,4), datetime(res.time_created, 'unixepoch', 'localtime')
                FROM requests r
                JOIN results res ON r.request_id = res.request_id AND r.job_id = '"""+str(jobId)+"""'
                JOIN cities arr ON r.start_city = arr.city_id
                JOIN cities dep ON r.end_city = dep.city_id
                JOIN distances dis ON arr.city_id = dis.end_city AND dep.city_id = dis.start_city """)
    listOfResults=c.fetchall()
    conn.close()    
    return listOfResults



# Save (commit) the changes
#conn.commit()
