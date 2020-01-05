
import sqlite3
import time
import datetime
import xlsxwriter
from setup_db import DB
import os

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

    query = ''' 
    SELECT 
        dep.city_name as departure_city,
        arr.city_name as arrival_city,
        strftime("%d.%m.%Y", res.departure_datetime) as departure_date,
        strftime("%H:%M", res.departure_datetime) as departure_time,
        strftime("%H:%M", res.arrival_datetime) as arrival_time,
        res.price as price,
        round(res.price/dis.distance,4) as price_per_km,
        res.fully_booked as fully_booked, 
        strftime("%d.%m.%Y (%H:%M)", res.time_created) as date_obtained
                FROM requests r
                JOIN results res ON r.request_id = res.request_id AND r.job_id = ?
                JOIN cities arr ON r.start_city = arr.city_id
                JOIN cities dep ON r.end_city = dep.city_id
                JOIN distances dis ON arr.city_id = dis.end_city AND dep.city_id = dis.start_city 
    '''

    c.execute(query, (jobId,))
    listOfResults=c.fetchall()
    conn.close()    
    return listOfResults

def prepareExcel(resultList):
    # Some sample data.
    #data = ('Foo', 'Bar', 'Baz')
    header = ('Departure city', 'Arrival city', 'Departure date', 
        'Departure time', 'Arrival time', 'Price', 'Price per km', 'Fully booked' 'Date obtained')

    workbook = xlsxwriter.Workbook('./resultFile/result.xlsx')
    worksheet = workbook.add_worksheet()

    worksheet.write_row('A1', header)

    for i in range(len(resultList)):
        row=i+1
        worksheet.write_row(row, 0, resultList[i])  
    workbook.close()

    return True

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
                VALUES ('"""+str(userId)+"', datetime('"+timeCreated+"'), '"+jobName+"')")
    conn.commit()
    conn.close()

    return True

#get jobId for a given jobName
def getJobIdByJobName(jobName):
    conn = sqlite3.connect('test_db.db')
    c = conn.cursor()  
    c.execute("SELECT job_id FROM jobs WHERE job_name='"+jobName+"'")
    jobIdList=c.fetchone()
    conn.close()
    jobId=jobIdList[0]
    return jobId

#everything in a string format as an entry
#only cities: start end can be int
def requestFromJob(jobName, startCity, endCity, startDate, endDate):
    #getting the job_id
    jobId = getJobIdByJobName(jobName)
    
    #date management
    start = datetime.datetime.strptime(startDate, '%Y-%m-%d')
    end = datetime.datetime.strptime(endDate, '%Y-%m-%d')
    step = datetime.timedelta(days=1)

    #getting a list with possible dates for a loop
    timeList=[]
    while start <= end:
        timeList.append(str(start.date()))
        start += step

    conn = sqlite3.connect('test_db.db')
    c = conn.cursor()  

    for i in range(len(timeList)):
        c.execute("""INSERT INTO requests (job_id, start_city, end_city, date)
            VALUES (' """+str(jobId)+" ', '"+str(startCity)+"', '"+str(endCity)+"', date('"+timeList[i]+"'))")
    
    conn.commit()
    conn.close()
    
    return True


def setup_before_running(path_to_db = "test_db.db"):

    if os.path.exists(path_to_db):
        # Clear database completely if needed (remove file)
        os.remove(path_to_db)

    db = DB(path_to_db)

    db.run_setup_scripts()

# Save (commit) the changes
#conn.commit()
