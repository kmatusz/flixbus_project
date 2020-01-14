from bottle import Bottle, route, run, template, get, post, debug, static_file, request, redirect, response
import time
import datetime
import random
import string
import logging
import logging.handlers
import sqlite3
import database_methods as dbm
import scraper_itegrate as scr
import xlsxwriter

secretKey = "SDMDSIUDSFYODS&TTFS987f9ds7f8sd6DFOUFYWE&FY"
sessions = {} #stores data about current sessions - key is sessionID, value is username
# Indicates whether during app startup 
# previous database should be reloaded from startup scripts
DB_PATH = 'test_db.db'
SETUP_DB_FROM_SCRIPT = True #changed to false

if SETUP_DB_FROM_SCRIPT:
    dbm.setup_before_running()

@route('/login')
def login():
    mes="" #do not show any message at this point
    return template('login', message =mes, isLoggedIn=False, isAdmin=False)


@route('/login', method='POST')
@route('/logout', method='POST')
def do_login():
    loginName = request.forms.getunicode('username', default=False)
    password = request.forms.getunicode('password', default=False)
    sessionID = ''.join(random.choice(
        string.ascii_uppercase + string.digits) for _ in range(18))

    #checking if password is correct - connecting to the database
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    c.execute("SELECT password FROM users WHERE name = '"+loginName+"'")
    tempPass0=c.fetchone()
    if tempPass0 is not None:
        tempPass=tempPass0[0]
    else:
        tempPass=None
    

    conn.close()

    if(tempPass==password):
        #Setting cookies for the session
        #adding to the dictionary sessions{} 
        #key is sessionID (cookie number) and value is loginName
        response.set_cookie("sessionID", sessionID, secret=secretKey)
        sessions[sessionID] = loginName
        
        #check if a user is and admin -> to redirect to admin panel
        #non-admin users are redirected to /index
        conn = sqlite3.connect(DB_PATH)
        c = conn.cursor()
        c.execute("SELECT admin FROM users WHERE name = '"+loginName+"'")
        tempIfAdmin0=c.fetchone()
        tempIfAdmin=tempIfAdmin0[0]
        conn.close()
        if(tempIfAdmin==1):
            redirect('/adminpanel')
            return True
        else:
            redirect('/index')
            return True
    return template('login', message='', isLoggedIn=False, isAdmin=False)

#defining the function for Authorization check 
#this uses cookies set at the login phase
#if sessionID and loginName check, than authorization is granted
#if not -> redirecting to /login page
def checkAuth():
    sessionID = request.get_cookie("sessionID", secret=secretKey)
    if sessionID in sessions:
        return sessions[sessionID]
    else:
        return redirect('/login')

#defining function for admin check
#not only login is necessery to get to the admin pages, but also the admin rights
def checkIfAdmin(name):
    #check the user info in the database
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    c.execute("SELECT admin FROM users WHERE name = '"+name+"'")
    tempIfAdmin0=c.fetchone()
    tempIfAdmin=tempIfAdmin0[0]
    conn.close()
    #security check for admin rights
    if(tempIfAdmin==1):
        return True
    else:
        return False

#page logout, with message about the logout success 
#returns the same template that login does, but with a pop up message
@route('/logout')
def logOut():
    sessionID = request.get_cookie("sessionID", secret=secretKey)
    response.delete_cookie('sessionID')
    mes="Logout successful"
    return template('login', message=mes, isLoggedIn=False, isAdmin=False)

#landing page for users
@route('/')
@route('/index')
@route('/index/')
@route('/index/<message>')
def index():
    loginName = checkAuth()
    if checkIfAdmin(loginName):
        redirect('/adminpanel')
    
    return template('index', message='', loginName=loginName, isLoggedIn=True, isAdmin=checkIfAdmin(loginName))


@route('/newjob')
def newJob():
    #authentication check
    loginName = checkAuth()
    if checkIfAdmin(loginName):
        redirect('/adminpanel') #admin is redirected to a dedicated pages for him

    #change this to -> all cities
    citiesList=dbm.getCityNames()
    
    mes='' #default message -> empty
    #if new job run correctly -> message success
    #if date wrong -> message date, etc.

    return template('newjob', message=mes, cityList=citiesList, isLoggedIn=True, isAdmin=checkIfAdmin(loginName))
    #formularz dla wyboru nowego joba

@route('/newjob', method='POST')
def newJobP():
    #authentication check
    loginName = checkAuth()
    if checkIfAdmin(loginName):
        redirect('/adminpanel')

    #change this to -> all cities
    citiesList=dbm.getCityNames()

    #setting the current date
    curTime = datetime.datetime.now()

    #getting data from the formular
    jobName = request.forms.getunicode('JobNameDefine', default=False) #allowing for special letters in utf8
    depCity = request.forms.get('DepCity', default=False)
    arrCity = request.forms.get('ArrCity', default=False)
    dateFromStr = request.forms.get('DepFrom', default=False) 
    dateToStr = request.forms.get('DepTo', default=False)

    if(jobName==''):
        mes = "Job name cannot be empty!"
        return template('newjob', message=mes, cityList=citiesList, isLoggedIn=True, isAdmin=checkIfAdmin(loginName))

    if(depCity=='' or arrCity==''):
        mes = "Cities of arrival and departure need to be set."
        return template('newjob', message=mes, cityList=citiesList, isLoggedIn=True, isAdmin=checkIfAdmin(loginName))

    if(depCity==arrCity):
        mes = "Cities of arrival and departure must differ."
        return template('newjob', message=mes, cityList=citiesList, isLoggedIn=True, isAdmin=checkIfAdmin(loginName))

    if( (dateFromStr=='') or (dateToStr=='')):
        mes = "The date interval needs to be specified."
        return template('newjob', message=mes, cityList=citiesList, isLoggedIn=True, isAdmin=checkIfAdmin(loginName))

    #date as a str - need to convert
    dateFrom = datetime.datetime.strptime(dateFromStr, '%Y-%m-%d').date()
    dateTo = datetime.datetime.strptime(dateToStr, '%Y-%m-%d').date()

    if(dateFrom<=curTime.date()):
        mes="You can only define a new search job for future dates! Remember about setting the right date interval."
        return template('newjob', message=mes, cityList=citiesList, isLoggedIn=True, isAdmin=checkIfAdmin(loginName))

    if(dateFrom>dateTo):
        mes="Set valid departure date interval!"
        return template('newjob', message=mes, cityList=citiesList, isLoggedIn=True, isAdmin=checkIfAdmin(loginName))
        
    #validation done

    #generate new record in jobs table
    dbm.pushJobToDb(loginName, jobName)

    #generate corresponding records in requests table for a given jobName
    dbm.requestFromJob(jobName, depCity, arrCity, dateFromStr, dateToStr)

    #preparing for scrapper work - get the job_id from database
    jobForScrapper=dbm.getJobIdByJobName(jobName)
    #run scrapper
    scr.runJob(jobForScrapper)

    return template('newjob', message="ok", cityList=citiesList, isLoggedIn=True, isAdmin=checkIfAdmin(loginName))


#standard version of a yourjobs page -> generating the basic view 
#custom userJobList is retrieved from database
@route('/yourjobs')
def yourJobs():
    #authentication check
    loginName = checkAuth()
    if checkIfAdmin(loginName):
        redirect('/adminpanel')
    print("aaaa")
    userJobList=dbm.getUserJobs(loginName)

    return template('yourjobs', table=userJobList, isLoggedIn=True, isAdmin=checkIfAdmin(loginName))

#this page allows for retrieving the user's action on a webpage
#pressing the button activates the function connected to scrapper
@route('/yourjobs', method='POST')
def yourJobsP():
    #authentication check
    loginName = checkAuth()
    if checkIfAdmin(loginName):
        redirect('/adminpanel')

    userJobList=dbm.getUserJobs(loginName)
    
    #get the indexes of jobs chosen by a user
    selectedJob = request.POST.getall('checkJob')
    for i in selectedJob:
        scr.runJob(i)

    #action started by button to run all the user's jobs
    doRunAll=request.POST.getall('runAll')
    if(doRunAll and doRunAll[0]=='Run all'):
        tempList=[]
        for i in userJobList:
            tempList.append(i[0])
        for i in tempList:
            scr.runJob(i)

    return template('yourjobs', table=userJobList, isLoggedIn=True, isAdmin=checkIfAdmin(loginName))

#first version of JobResults - user can choose a Job for which results will be showed
@route('/jobresults')
def jobResults():
    #authentication check
    loginName = checkAuth()
    if checkIfAdmin(loginName):
        redirect('/adminpanel')

    formList=dbm.getUserJobsNames(loginName)

    return template('jobresults', formularList=formList , showTable=False, isLoggedIn=True, isAdmin=checkIfAdmin(loginName))

#this allows for generating the result table for chosen Job (form submitted)
@route('/jobresults', method='POST')
def jobResultsP():
    #authentication check
    loginName = checkAuth()
    if checkIfAdmin(loginName):
        redirect('/adminpanel')

    formList=dbm.getUserJobsNames(loginName)

    selectedJob = request.POST.getall('jobChoosing')
    #if a job is selected: shows the table with results
    if(selectedJob):
        showTable=True
        resultsForJob = dbm.getResultForJobId(selectedJob[0])
        dbm.prepareExcel(resultsForJob)

    return template('jobresults', formularList=formList, showTable=showTable, 
            resultTable=resultsForJob, loginName=loginName, isLoggedIn=True, isAdmin=checkIfAdmin(loginName))


#filepath is static - bottle doesn't support file generation in the spot (in working memory)
#this problem is ommited by using more static solution
@route('/download')
def download():
    #only for logged in users
    loginName = checkAuth()
    if checkIfAdmin(loginName):
        redirect('/adminpanel')

    #path relative to working directory
    return static_file(filename='result.xlsx', root='./resultFile', download=True)

@route('/adminpanel')
def adminpanel():
    # authentication check
    loginName = checkAuth()
    if not checkIfAdmin(loginName):
        redirect('/login')

    tables_list = [
    "execution_logs",
    "inserts_logs",
    "jobs",
    "requests",
    "users"]

    return template('adminpanel', 
        loginName = loginName,
        tables_list=tables_list, 
        showTable=False, 
        isLoggedIn=False, #admin is not a normal user 
        isAdmin=True)
#     #isLoggedIn = False, because it's a variable controling for standard users 
#     #this is used in a html generation via template (navbar conditioning)

@route('/adminpanel', method='POST')
def adminpanelP():
    # authentication check
    loginName = checkAuth()
    if not checkIfAdmin(loginName):
        redirect('/login')

    tables_list = [
    "execution_logs",
    "inserts_logs",
    "jobs",
    "requests",
    "users"]

    selected_table = request.POST.getall('admin_table_choosing')
    # if a job is selected: shows the table with results
    if(selected_table):

        # selected_table = dbm.getResultForJobId(selectedJob[0])
        selected_table_header, selected_table_content = dbm.getFullTable(selected_table[0])
        # dbm.prepareExcel(resultsForJob)

    # HERE should be also Excel File generated and ready for download
    # tutorial: https://xlsxwriter.readthedocs.io/tutorial03.html
    return template('adminpanel', 
        tables_list=tables_list, 
        selected_table_header = selected_table_header,
        selected_table_content = selected_table_content,
        showTable=True, 
        loginName=loginName,
        isLoggedIn=False, #admin is not a normal user 
        isAdmin=True)

run(host='localhost', port=8060)


