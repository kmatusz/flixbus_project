
import sqlite3
import time

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


#function for generating drop down list in template with user's jobs
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


#for a dropdown lists with defined city names -> in NewJob view
def getCityNames():
    conn = sqlite3.connect('test_db.db')
    c = conn.cursor()  
    c.execute("SELECT city_id, city_name FROM cities")

    listOfResults=c.fetchall()
    conn.close()
    return listOfResults

def pushJobToDb(loginName, jobName):
    #user created id
    conn = sqlite3.connect('test_db.db')
    c = conn.cursor()  
    c.execute("SELECT user_id FROM users WHERE name='"+loginName+"'")
    idList=c.fetchone()
    conn.close()
    userId=idList[0]

    #time created 
    timeCreated=time.strftime("%Y-%m-%d %H:%M:%S") #ready for datetime() command in sqlite3

    #creating new Job in the database
    conn = sqlite3.connect('test_db.db')
    c = conn.cursor()  
    c.execute("""INSERT INTO jobs (user_created, time_created, job_name)
                VALUES ('"""+str(userId)+"', datetime('"+timeCreated+")', '"+jobName+"')")
    conn.commit()
    conn.close()

    return True
    

#everything in a string format as an entry
def requestFromJob(jobName, start, end, startDate, endDate):
    #getting the job_id
    conn = sqlite3.connect('test_db.db')
    c = conn.cursor()  
    c.execute("SELECT job_id FROM jobs WHERE job_name='"+jobName+"'")
    jobIdList=c.fetchone()
    conn.close()
    jobId=jobIdList[0]
    
    #getting the job_id



    #date management
    start = datetime.datetime.strptime(date1, '%Y-%m-%d')
    end = datetime.datetime.strptime(date2, '%Y-%m-%d')
    step = datetime.timedelta(days=1)

    timeList=[]

    while start <= end:
        timeList.append(str(start.date()))
        start += step


# Save (commit) the changes
#conn.commit()
