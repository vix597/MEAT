import socket
import json

message1 = {
    'id':'redmine.issue.create',
    'issue_id':1444,
    'issue_title':'GO FUCK YOUR FACE'
}

data = json.dumps(message1)

try:
    s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    s.connect(('localhost',5000))
    s.send(data.encode())
except Exception as e:
    print("WaaaHHHH!!!: ",str(e))


