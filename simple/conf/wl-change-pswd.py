import os

print("*** Trying to Connect.... *****")
connect('weblogic','welcome1','t3://localhost:8001')
print("*** Connected *****")
edit()
startEdit()


print ("*** Encrypt the password ***")
en = encrypt('demopw')
print "Encrypted pwd: ", en

print ("*** Changing pwd for Demo ***")
dsName = 'DS_MySQL'

print 'Changing Password for DataSource ', dsName
cd('/JDBCSystemResources/'+dsName+'/JDBCResource/'+dsName+'/JDBCDriverParams/'+dsName)
set('PasswordEncrypted',en)

save()
activate()
