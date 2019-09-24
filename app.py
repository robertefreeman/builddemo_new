from flask import Flask
from redis import Redis
import socket

app = Flask(__name__)
redis = Redis(host='redis', port=6379)

@app.route('/')
def hello():
    count = redis.incr('hits')
    hostname = socket.gethostname()
    verbiage = "Hello World!! I have been seen " + str(count) + " times, served by Countainer: " + hostname
    # return 'HELLO World! I have been seen {} times.\n'.format(count)
    return verbiage

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
