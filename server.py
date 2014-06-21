import argparse

if __name__=="__main__":
    from meat import app, socketio

    parser = argparse.ArgumentParser(description="MEAT - Monitor Every Awesome Thing!")
    parser.add_argument('-p','--port',help="Run the server on port (Default is 5000)",type=int)
    args = parser.parse_args()

    if args.port:
        socketio.run(app,port=args.port)
    else:
        socketio.run(app)

    