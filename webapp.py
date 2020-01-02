from bottle import Bottle, route, run, template, get, post, debug, static_file, request, redirect, response
import time
import random
import string
import logging
import logging.handlers
import sqlite3
import database_methods as dbm
import scraper_itegrate as scr

secretKey = "SDMDSIUDSFYODS&TTFS987f9ds7f8sd6DFOUFYWE&FY"
sessions = {} #stores data about current sessions - key is sessionID, value is username

@route('/login')
def login():
    mes="" #do not show any message at this point
    return template('login', message =mes, isLoggedIn=False, isAdmin=False)


@route('/login', method='POST')
@route('/logout', method='POST')
def do_login():
    loginName = request.forms.get('username', default=False)
    password = request.forms.get('password', default=False)
    sessionID = ''.join(random.choice(
        string.ascii_uppercase + string.digits) for _ in range(18))

    #checking if password is correct - connecting to the database
    conn = sqlite3.connect('db/test_db.db')
    c = conn.cursor()
    c.execute("SELECT password FROM users WHERE name = '"+loginName+"'")
    tempPass0=c.fetchone()
    tempPass=tempPass0[0]
    conn.close()

    if(tempPass==password):
        #Setting cookies for the session
        #adding to the dictionary sessions{} 
        #key is sessionID (cookie number) and value is loginName
        response.set_cookie("sessionID", sessionID, secret=secretKey)
        sessions[sessionID] = loginName
        
        #check if a user is and admin -> to redirect to admin panel
        #non-admin users are redirected to /index
        conn = sqlite3.connect('db/test_db.db')
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
    conn = sqlite3.connect('db/test_db.db')
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
    
    return template('index', message='', loginName=loginName, isLoggedIn=True, isAdmin=False)


@route('/newjob')
def newJob():
    #authentication check
    loginName = checkAuth()
    if checkIfAdmin(loginName):
        redirect('/adminpanel')

    return template('newjob', isLoggedIn=True, isAdmin=False)
    #formularz dla wyboru nowego joba


#standard version of a yourjobs page -> generating the basic view 
#custom userJobList is retrieved from database
@route('/yourjobs')
def yourJobs():
    #authentication check
    loginName = checkAuth()
    if checkIfAdmin(loginName):
        redirect('/adminpanel')
    userJobList=dbm.getUserJobs(loginName)

    return template('yourjobs', table=userJobList, isLoggedIn=True, isAdmin=False)

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

    return template('yourjobs', table=userJobList, isLoggedIn=True, isAdmin=False)

#first version of JobResults - user can choose a Job for which results will be showed
@route('/jobresults')
def jobResults():
    #authentication check
    loginName = checkAuth()
    if checkIfAdmin(loginName):
        redirect('/adminpanel')

    formList=dbm.getUserJobsNames(loginName)

    return template('jobresults', formularList=formList , showTable=False, isLoggedIn=True, isAdmin=False)

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

    #HERE should be also Excel File generated and ready for download
    #tutorial: https://xlsxwriter.readthedocs.io/tutorial03.html

    return template('jobresults', formularList=formList, showTable=showTable, 
            resultTable=resultsForJob, isLoggedIn=True, isAdmin=False)


#landing page for the admin
@route('/adminpanel')
def admin():
    loginName = checkAuth()
    if checkIfAdmin(loginName)==False:
        redirect('/login')
    #isLoggedIn = False, because it's a variable controling for standard users 
    #this is used in a html generation via template (navbar conditioning)
    return template('adminpanel', loginName=loginName, isLoggedIn=False, isAdmin=True)


#all the other admin views
#... to be filled out by Kamil


run(host='localhost', port=8060)


