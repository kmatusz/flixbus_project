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
    mes=""
    return template('login', message =mes, isLoggedIn=False, isAdmin=False)


@route('/login', method='POST')
@route('/logout', method='POST')
def do_login():
    loginName = request.forms.get('username', default=False)
    password = request.forms.get('password', default=False)
    sessionID = ''.join(random.choice(
        string.ascii_uppercase + string.digits) for _ in range(18))

    conn = sqlite3.connect('db/test_db.db')
    c = conn.cursor()
    c.execute("SELECT password FROM users WHERE name = '"+loginName+"'")
    tempPass0=c.fetchone()
    tempPass=tempPass0[0]
    conn.close()
    mes=""

    if(tempPass==password):
        response.set_cookie("sessionID", sessionID, secret=secretKey)
        sessions[sessionID] = loginName
        
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
    return template('login', message=mes, isLoggedIn=False, isAdmin=False)


        # if admin - redirect /admin -> selectem z bazy
        # else /index home




def checkAuth():
    sessionID = request.get_cookie("sessionID", secret=secretKey)
    if sessionID in sessions:
        return sessions[sessionID]
    else:
        return redirect('/login')
    #return True #jeśli jest sesrion id w dictionary
    #jak nie to false -> redirest do login

def checkIfAdmin(name):
    conn = sqlite3.connect('db/test_db.db')
    c = conn.cursor()
    c.execute("SELECT admin FROM users WHERE name = '"+name+"'")
    tempIfAdmin0=c.fetchone()
    tempIfAdmin=tempIfAdmin0[0]
    conn.close()
    if(tempIfAdmin==1):
        return True
    else:
        #redirect('/login')
        return False


@route('/logout')
def logOut():
    sessionID = request.get_cookie("sessionID", secret=secretKey)
    response.delete_cookie('sessionID')
    mes="Logout successful"
    return template('login', message=mes, isLoggedIn=False, isAdmin=False)


@route('/')
@route('/index')
@route('/index/')
@route('/index/<message>')
def index(message=''):
    loginName = checkAuth()
    if checkIfAdmin(loginName):
        redirect('/adminpanel')
    #loginName = 'adam0'
    messDict = {'error': "Something went wrong",
                'ok': "Everything is ok."}
    return template('index', message=messDict.get(message, ""), loginName=loginName, isLoggedIn=True, isAdmin=False)


@route('/newjob')
def newJob():
    #authentication check
    loginName = checkAuth()
    if checkIfAdmin(loginName):
        redirect('/adminpanel')

    return template('newjob', isLoggedIn=True, isAdmin=False)
    #formularz dla wyboru nowego joba
#<ul>
#  % for item in basket:
#    <li>{{item}}</li>
#  % end
#</ul>


@route('/yourjobs')
def yourJobs():
    #authentication check
    loginName = checkAuth()
    if checkIfAdmin(loginName):
        redirect('/adminpanel')
    userJobList=dbm.getUserJobs(loginName)

    return template('yourjobs', table=userJobList, isLoggedIn=True, isAdmin=False)


@route('/yourjobs', method='POST')
def yourJobs():
    #authentication check
    loginName = checkAuth()
    if checkIfAdmin(loginName):
        redirect('/adminpanel')
    userJobList=dbm.getUserJobs(loginName)
    
    #get the indexes of 
    selectedJob = request.POST.getall('checkJob')
    for i in selectedJob:
        scr.runJob(i)
    print(selectedJob)

    doRunAll=request.POST.getall('runAll')
    if(doRunAll and doRunAll[0]=='Run all'):
        tempList=[]
        for i in userJobList:
            tempList.append(i[0])
        for i in tempList:
            scr.runJob(i)

    return template('yourjobs', table=userJobList, isLoggedIn=True, isAdmin=False)


@route('/jobresults')
def jobResults():
    #authentication check
    loginName = checkAuth()
    if checkIfAdmin(loginName):
        redirect('/adminpanel')

    formList=dbm.getUserJobsNames(loginName)

    return template('jobresults', formularList=formList , showTable=False, isLoggedIn=True, isAdmin=False)

@route('/jobresults', method='POST')
def jobResults():
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
    
    
    #TO DO:
    #get a proper table with results by jobID
    #show it to the user in template file

    print(selectedJob)
    return template('jobresults', formularList=formList, showTable=showTable, resultTable=resultsForJob, isLoggedIn=True, isAdmin=False)



@route('/adminpanel')
def admin():
    loginName = checkAuth()
    if checkIfAdmin(loginName)==False:
        redirect('/login')
    return template('adminpanel', loginName=loginName, isLoggedIn=False, isAdmin=True)



run(host='localhost', port=8060)


