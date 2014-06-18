
from flask import Flask
from flask.ext.socketio import SocketIO

app = Flask(__name__)
app.debug = True
app.template_dir = 'templates'
app.static_dir = 'static'

socketio = SocketIO(app)

from meat import views

