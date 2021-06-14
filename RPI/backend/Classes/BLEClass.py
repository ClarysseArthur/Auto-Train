from bluedot.btcomm import BluetoothClient 
from flask_socketio import SocketIO, send
import time

class BLE:
    def __init__(self, socketio, device = 'train'):
        self.device = device
        self.client = BluetoothClient("Train", self.data_received, 1, 'hci0', None)
        self.socketio = socketio

    def data_received(self, data):
        hex_string = "0x" + data.hex()
        waarde = int(hex_string, 16)

        if (waarde >> 6) == 2:
            meetWaarde = waarde & 0b00111111
            self.socketio.emit('B2F_WaardeMotorUpdate', meetWaarde)
            # print(meetWaarde)

        elif waarde >> 6 == 1:
            pass

        elif waarde >> 1 == 97:
            print('TESTTEST')
            if waarde & 0b00000001:
                self.socketio.emit('B2F_lightStatus', True)
            else:
                self.socketio.emit('B2F_lightStatus', False)

    def get_motor_data(self):
        while True:
            self.client.send(0b10000000.to_bytes(1, byteorder ='big'))
            time.sleep(0.5)

    def send_data(self, data):
        print(f'SEND DATA: {data}')
        self.client.send(data.to_bytes(1, byteorder ='big')) 