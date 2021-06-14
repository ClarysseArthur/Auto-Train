from .DataClass import DataRepository
from .BLEClass import BLE


from datetime import datetime, timedelta
import time

class AutoPilot:
    status = True

    def __init__(self, socketio, bluetooth, serial):
        self.socketio = socketio
        self.ble = bluetooth
        self.ser = serial
        self.db = DataRepository()

    def start_driving(self, speed = 40):
        sendWaarde = 0b01000000 | int(speed)
        self.ble.send_data(sendWaarde)

    def stop_driving(self):
        sendWaarde = 0b01000000 | int(0)
        self.ble.send_data(sendWaarde)

    def auto_pilot(self, race_time = 5, stop_time = 1):
        test = False
        id = 0

        while True:
            if self.status:
                if test == False:
                    self.start_driving()
                    test = True

                    now = datetime.now()
                    start = now.strftime("%Y-%m-%d %H:%M:%S")
                    self.verwacht = datetime.strptime(start, "%Y-%m-%d %H:%M:%S") + timedelta(seconds = 13)

                    id = self.db.insert_rit_start(start, self.verwacht)
                    time.sleep(3)

                print(self.ser.D1 & 0b00000001)

                if int(self.ser.D1) & 0b00000001:
                    time.sleep(0.5)
                    self.stop_driving()

                    if self.verwacht <= datetime.now():
                        self.db.insert_rit_stop_delay(datetime.now().strftime("%Y-%m-%d %H:%M:%S"), 1, id)
                    else:
                        self.db.insert_rit_stop(datetime.now().strftime("%Y-%m-%d %H:%M:%S"), id)

                    time.sleep(2)
                    test = False

                time.sleep(0.5)

            else:
                test = False