
from flask import Flask
from flask.ext.socketio import SocketIO
from flask.ext.assets import Environment, Bundle

app = Flask(__name__)
app.debug = True
app.template_dir = 'templates'
app.static_dir = 'static'

socketio = SocketIO(app)
assets = Environment(app)

assets.debug = True


app_css = Bundle(
    "css/bootstrap.min.css",
    "css/bootstrap-theme.min.css",
    filters="cssmin",
    output="gen/css/application.css"
)
assets.register('application-css', app_css)

app_js = Bundle(
    "js/jquery.min.js",
    "js/jquery-ui.min.js",
    "js/bootstrap.min.js",
    "js/moment.min.js",
    "js/socket.io.min.js",
    #filters="rjsmin",
    output="gen/js/application.js"
)
assets.register("application-js", app_js)

watch_js = Bundle(
    "coffee/meat.coffee",
    "coffee/redmine/models.coffee",
    "coffee/redmine/events.coffee",
    "coffee/redmine/status.coffee",
    "coffee/gitlab/models.coffee",
    "coffee/gitlab/events.coffee",
    "coffee/EventPanel.coffee",
    "coffee/SummaryPanel.coffee",
    filters=['coffeescript'], #rjsmin
    output='gen/js/watch.js'
)
assets.register("watch-js", watch_js)

watch_css = Bundle(
    "css/watch.css",
    filters='cssmin',
    output='gen/css/watch.js'
)
assets.register('watch-css', watch_css)

from meat import views

