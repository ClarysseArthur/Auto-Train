from os import error
from serial import Serial

class SER:
    D1 = 0
    D2 = 0

    def __init__(self, socket):
        self.serial = Serial('/dev/ttyS0', 9600, timeout = 0.2, bytesize = 8)
        self.socketio = socket

    def read_serial(self):
        while True:
            if self.serial.in_waiting > 0:
                try:

                    data = self.serial.read(size = 2).hex()

                    D1 = "0x" + data[0:2]
                    D2 = "0x" + data[2:4]

                    self.socketio.emit('B2F_LocationUpdate1', int(D1, 16))
                    self.socketio.emit('B2F_LocationUpdate2', int(D2, 16))

                    self.D1 = int(D1, 16)
                    self.D2 = int(D2, 16)

                    # print(f'Spoor 0: {data}, {D1}, {D2}')

                except error as e:
                    print(e)

    def write_serial(self, code):
        print(code)
        print(self.serial.write(code))