import os

newPassword = sys.argv[1]

print("*** Trying to Connect.... *****")
connect('weblogic','welcome1','t3://localhost:8001')
print("*** Connected *****")
shutdown('DockerServer','Server')
start('DockerServer','Server')