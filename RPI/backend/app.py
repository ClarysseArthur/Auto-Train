from repositories.DataRepository import DataRepository
from Classes.AutoPilotClass import AutoPilot
from Classes.BLEClass import BLE
from Classes.LCDClass import LCD
from Classes.SERClass import SER

from flask_socketio import SocketIO, send
from flask import Flask, jsonify
from subprocess import check_output
from flask_cors import CORS

import threading
import time

#! APP CONFIG
#? FLASK
app = Flask(__name__)
app.config['SECRET_KEY'] = 'ksdjféé!è"§efg'

#! SOCKET IO CONFIG
socketio = SocketIO(app, cors_allowed_origins="*", logger=False, engineio_logger=False, ping_timeout=0.5)
CORS(app)

#?! BLUETOOTH CONFIG
ble = BLE(socketio)
get_motor_data_thread = threading.Thread(target = ble.get_motor_data)
get_motor_data_thread.start()

#! LCD CONFIG
# lcd = LCD()
# ip = check_output(['hostname', '--all-ip-addresses'])
# lcd.lcd_display_string(ip.decode(encoding = 'utf-8'), 1, 0)

#! SERIAL CONFIG
ser = SER(socketio)
serialThread = threading.Thread(target = ser.read_serial)
serialThread.start()

#! AUTOPILOT CONFIG
auto = AutoPilot(socketio, ble, ser)
autoThread = threading.Thread(target = auto.auto_pilot)
autoThread.start()

#! SOCKET IO LISTENERS
# LIGHT TOGLLE
@socketio.on('F2B_lightToggle')
def lightToggle(data):
    if data:
        ble.send_data(0b11000001)
    else:
        ble.send_data(0b11000000)

# LIGH STATUS
@socketio.on('F2B_lightStatus')
def light(data):
    ble.send_data(0b11000010)

# SPEED CHANGE
@socketio.on('F2B_speedChange')
def speed(data):
    waarde = int(data) / 100 * 63
    print (waarde)

    sendWaarde = 0b01000000 | int(waarde)
    print(sendWaarde)

    ble.send_data(sendWaarde)
        
#! APP ROUTES
# INDEX
@app.route('/')
def index():
    return 'GOT TO THE API!'

# GET ALL
@app.route('/api/v1/get_all/<delay>')
def all(delay):
    return jsonify(DataRepository.read_ritten(delay))

# MAX VERTRAGING
@app.route('/api/v1/get_vertraging/<minuten>')
def get_max_vertraging(minuten):
    return jsonify(DataRepository.read_vertraging_minuten(minuten))

@app.route('/api/v1/get_vertraging_date/<date>')
def sdfsd(date):
    return jsonify(DataRepository.read_vertraging_day(date))

# GET ALLE DATA
@app.route('/api/v1/get_dates')
def get_dates():
    return jsonify(DataRepository.read_dates())

# SORT OP DATE
@app.route('/api/v1/sort_date/<date>')
def sort_date(date):
    return jsonify(DataRepository.sort_dates(date))

@app.route('/api/v1/get_date_vertraging/<datum>/<tijd>')
def getabc(datum, tijd):
    return jsonify(DataRepository.get_date_vertraging(datum, tijd))

# SET DRIVING MODE AUTOPILOT / MANUAL
@app.route('/api/v1/mode/<mode>')
def mode_toggl(mode):
    if (mode == 'false'):
        auto.status = False
    else:
        auto.status = True

    print (auto.status)
    return jsonify({"status": auto.status})

@app.route('/api/v1/kalibreer')
def kal():
    ser.write_serial(0b00000001)
    return {'ok': '200'}

# @app.route('/api/v1/sort_all')
# def get_dates():
#     return jsonify(DataRepository.sort_dates_vertraging())

#! MAIN
if __name__ == '__main__':
    socketio.run(app, debug=False, host='0.0.0.0')