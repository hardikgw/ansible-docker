#================================================================================================================================
#================================================================================================================================

import os
import sys

#================================================================================================================================
#================================================================================================================================

def main(userID, oldPwd, newPwd):

       if userID == "demo":        
          try:
             stopMgdServers()
             rtrn = callChgOraPwd(userID, oldPwd, newPwd)
             print "Finished STEP2 with return code: " + str(rtrn)
             if rtrn == 0:
                changeDSPwd(userID, newPwd)
                #startMgdServers()
             else:
                print "ERROR changing SQL password - aborting all WLS data source changes and server restarts."
          except Exception, e:
                print "!!!ERROR: UNABLE TO CONNECT TO WLS SERVER: " + connectStr
                print e
       if userID == "some_otherid":
          print "some other drill"
       if userID == "still_otherid":
          print "still other drill"

#================================================================================================================================
#================================================================================================================================

def changeDSPwd(userID, newPWD):
#   oraString = "oracle"
   cd('Servers/AdminServer')
   edit()
   startEdit()
   cd('JDBCSystemResources')
   allDS=cmo.getJDBCSystemResources()

   for dataSource in allDS:
      dsName=dataSource.getName();
      print "----------Checking Data Source Name: " + dsName

      cd('/JDBCSystemResources/' + dsName + '/JDBCResource/' + dsName + '/JDBCDriverParams/' + dsName + '/Properties/' + dsName)
      uid = cmo.lookupProperty('user').getValue()
      cd('/JDBCSystemResources/' + dsName + '/JDBCResource/' + dsName + '/JDBCDriverParams/' + dsName)
      drvr = get("DriverName")
      print "               ***Found an Oracle Data Source"
      # Check if there is a match for user-id
      if uid == userID:
         print "               ***Matched userID " + userID + "--Changing Password & UserName for DataSource ", dsName
         cd('/JDBCSystemResources/'+dsName+'/JDBCResource/'+dsName+'/JDBCDriverParams/'+dsName)
         #print('/JDBCSystemResources/'+dsName+'/JDBCResource/'+dsName+'/JDBCDriverParams/'+dsName)
         set('Password',newPWD)
         print "               ***Username & Password has been Changed for DataSource: " + dsName
   save()
   activate()

#================================================================================================================================
#================================================================================================================================

def stopMgdServers():
    svrs = cmo.getServers()
    domainRuntime()
    returnVal = 0
    for server in svrs:
        if server.getName() != "AdminServer":
           sName = server.getName()
           cd("/ServerLifeCycleRuntimes/" + server.getName() )
           serverState = cmo.getState()
           serverConfig()
           machine = server.getMachine();
           print server.getName() + " is " + serverState + " on " + machine.getName()
           domainRuntime()
           if serverState == "RUNNING":
              try:
                 shutdown(sName,ignoreSessions="false",timeOut=30,force="false",block="true")
                 state(sName)
                 newState = cmo.getState()
                 print "Server " + server.getName() + " is " + newState + " on " + machine.getName()
              except Exception, e:
                 returnVal = -1
                 print "!!!ERROR: Unable to start server " + server.getName() + ". Please consult the server’s log file: "
                 print e
           else:
              print "Server " + server.getName() + " is NOT RUNNING"
    return returnVal


#================================================================================================================================
#================================================================================================================================

def startMgdServers():
    svrs = cmo.getServers()
    domainRuntime()
    returnVal = 0
    for server in svrs:
        if server.getName() != "AdminServer":
           cd("/ServerLifeCycleRuntimes/" + server.getName() )
           serverState = cmo.getState()
           serverConfig()
           machine = server.getMachine();
           print Server.getName() + " is " + serverState + " on " + machine.getName()
           domainRuntime()
           if serverState != "RUNNING":
              try:
                 start(server.getName(),"Server")
#                 serverState = serverStatus(server)
                 newState = cmo.getState()
                 print "Now " + server.getName() + " is " + newState + " on " + machine.getName()
              except Exception, e:
                 returnVal = -1
                 print "!!!ERROR: Unable to start server " + server.getName() + ". Please consult the server’s log file: "
                 print e
           else:
              print "Server " + server.getName() + " is ALREADY RUNNING"
    return returnVal
#================================================================================================================================
#================================================================================================================================
#================================================================================================================================

uid    = sys.argv[1]
oldPwd = sys.argv[2]
newPwd = sys.argv[3]
print "  uid="+uid+"  old="+oldPwd+"  new="+newPwd

main(uid, oldPwd, newPwd)

