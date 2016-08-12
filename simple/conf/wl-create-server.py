import os

serverName = sys.argv[1]

print("*** Trying to Connect.... *****")
connect('weblogic','welcome1','t3://localhost:8001')
print("*** Connected *****")
edit()
startEdit()
cd('/')
cmo.createServer(serverName)
cd('/Servers/' + serverName)
cmo.setListenAddress("localhost")
cmo.setListenPort(7001)
activate()