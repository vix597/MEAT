
from flask import request, render_template
#from flask.ext.socketio import emit
from meat import app, socketio
import json

@app.route('/push', methods=['POST'])
def push():
    print "data:", request.data
    obj = json.loads(request.data)
    print "push:", obj
    socketio.emit('sevent', obj, namespace='/meat')
    return '', 200


@app.route('/')
def index():
    return render_template("watch.html")

@socketio.on('connect', namespace='/meat')
def on_connect():
    print "CONNECTION!!!!"
