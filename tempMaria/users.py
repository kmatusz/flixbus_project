#users={
#	"admin":{
#		"name":"Tom Black", 
#		"password":"admin1", 
#		"email":"rwojciechowski@wne.uw.edu.pl",
#		"loggedIn":False,
#		"randStr":"",
#		"lastSeen":0
#		}
#} 


#user_id	name	password	admin	active	time_created
#1	adam	pass1	0	1	10.10.2019
#2	tom	pass2	0	1	10.10.2019
#3	admin	admin	1	1	10.10.2019


class User:
    def __init__(self, name, password, admin=False, active=1, time_created=):
        self.name = name
        self.password = password
        self.admin = admin


