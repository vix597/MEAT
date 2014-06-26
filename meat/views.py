
from flask import request, render_template
#from flask.ext.socketio import emit
from meat import app, socketio
import json
import pytz
from datetime import datetime
import calendar


@app.route('/push', methods=['POST'])
def push():
    print("PUSH!!!")
    obj = json.loads(request.data)
    obj['timestamp'] = calendar.timegm(datetime.now(pytz.utc).timetuple()) * 1000
    socketio.emit('sevent', obj, namespace='/meat')
    return '', 200

@app.route('/push.gitlab', methods=['POST'])
def push_gitlab():
    obj = json.loads(request.data)
    obj['timestamp'] = calendar.timegm(datetime.now(pytz.utc).timetuple()) * 1000
    obj['id'] = 'gitlab.push'
    socketio.emit('sevent', obj, namespace='/meat')
    return '', 200



@app.route('/')
def index():
    return render_template("watch.html")


@socketio.on('connect', namespace='/meat')
def on_connect():
    print "CONNECTION!!!!"

@socketio.on('message', namespace='/meat')
def handle_messae(message):
    print "MESSAGE: "+str(message)
