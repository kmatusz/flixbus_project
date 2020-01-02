#NOT IMPORTANT, TEMPORARY FILE ONLY

from bottle import route, run, template

name="Maria"

@route('/hello/<name>')
def index(name):
    #return template('<b>Hello {{name}}</b>!', name=name)
    loginName = 'mamy'
    messDict = {'error': "Something went wrong",
                'ok': "Everything is ok."}
    return template('index', message=messDict.get(name, ""), loginName=loginName)

@route('/login')
def login():
    return '''
        <form action="/login" method="post">
            Username: <input name="username" type="text" />
            Password: <input name="password" type="password" />
            <input value="Login" type="submit" />
        </form>
    '''

@route('/login', method='POST')
def do_login():
    username = request.forms.get('username')
    password = request.forms.get('password')
    if check_login(username, password):
        return "<p>Your login information was correct.</p>"
    else:
        return "<p>Login failed.</p>"

#do wykorzystania dla złej autentykacji
@route('/restricted')
def restricted():
    abort(401, "Sorry, access denied.")

run(host='localhost', port=8050)



from bottle import route, run, template


@app.route('/login')
@app.route('/login/')
@app.route('/login', method='POST')
def login():
    loginName = request.forms.get('login_name', default=False)
    password = request.forms.get('password', default=False)
    randStr = ''.join(random.choice(
        string.ascii_uppercase + string.digits) for _ in range(18))
    log.info(str(loginName) + ' ' + request.method + ' ' +
             request.url + ' ' + request.environ.get('REMOTE_ADDR'))
    if (loginName in users) and users[loginName]["password"] == password:
        response.set_cookie("user", loginName, secret=secretKey)
        response.set_cookie("randStr", randStr, secret=secretKey)
        users[loginName]["loggedIn"] = True
        users[loginName]["randStr"] = randStr
        users[loginName]["lastSeen"] = time.time()

        redirect('/index')
        return True
    else:
        return template('login')
    return template('login')

