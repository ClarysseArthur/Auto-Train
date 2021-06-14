/*
 Name:		Trein.ino
 Created:	6/1/2021 10:16:50 AM
 Author:	Athur Clarysse
*/

// 5V | GND | Afstand | AfstandLED | Voorlicht | VoorlichtKnop | Motor

#include "BluetoothSerial.h"

#define afstandSenor 34
#define currentSensor 35
#define lichtKnop 33

#define afstandLED 32
#define voorLichten 25

int PWM_FREQUENCY = 1000;	// this variable is used to define the time period 
int PWM_CHANNEL = 0;		// this variable is used to select the channel number
int PWM_RESOUTION = 8;		// this will define the resolution of the signal which is 8 in this case
int GPIOPIN = 26;			// GPIO to which we want to attach this channel signal
int dutyCycle = 127;		// it will define the width of signal or also the one time

bool voorlichtStatus = false;

BluetoothSerial SerialBT;

// the setup function runs once when you press reset or power the board
void setup() {
	pinMode(afstandLED, OUTPUT);
	pinMode(voorLichten, OUTPUT);

	pinMode(afstandSenor, INPUT);
	pinMode(currentSensor, INPUT);

	pinMode(lichtKnop, INPUT_PULLUP);

	Serial.begin(115200);

	SerialBT.begin("Train");
	Serial.println("The device started, now you can pair it with bluetooth!");

	ledcSetup(PWM_CHANNEL, PWM_FREQUENCY, PWM_RESOUTION);
	ledcAttachPin(GPIOPIN, PWM_CHANNEL);

	// 0 = 100%
	// 255 = 0%

	ledcWrite(PWM_CHANNEL, 0);
}

// the loop function runs over and over again until power down or reset
void loop() {
	if (SerialBT.available()) {
		byte Waarde = SerialBT.read();

		Serial.println(Waarde);

		if (Waarde >> 6 == 3) {
			Serial.println("Set lights");

			if (Waarde & 0b00000010) {
				if (!voorlichtStatus) {
					SerialBT.write(0b11000011);
				}
				else {
					SerialBT.write(0b11000010);
				}
			}

			else if (Waarde & 0b00000001) {
				toggle_lights(true);
			}

			else {
				toggle_lights(false);
			}
		}

		else if (Waarde >> 6 == 2) {
			float motorWaarde = analogRead(currentSensor);
			byte send = 0b10000000;

			send |= int(((motorWaarde / 4096) * 64));

			Serial.println("Motor: " + String(motorWaarde) + " " + String(send) + " " + String(((motorWaarde / 4096) * 64)));
			SerialBT.write(send);
			Serial.println("Waarde CURRENT");
		}

		else if (Waarde >> 6 == 1) {
			Serial.println("Set Motor");

			float motorSpeed = Waarde & 0b00111111;

			Serial.println(motorSpeed);

			ledcWrite(PWM_CHANNEL, int((motorSpeed / 64) * 255));
		}
	}

	Serial.println(analogRead(afstandSenor));

	if (analogRead(afstandSenor) > 3000) {
		delay(25);
		if (analogRead(afstandSenor) > 3000) {
			digitalWrite(afstandLED, HIGH);
			ledcWrite(PWM_CHANNEL, 0);
			delay(1000);

			do {

			} while (analogRead(afstandSenor) > 3000);

			ledcWrite(PWM_CHANNEL, 160);
		}	
	}
	else {
		digitalWrite(afstandLED, LOW);
	}

	if (digitalRead(lichtKnop) == LOW) {
		if (voorlichtStatus) {
			SerialBT.write(0b11000011);
			toggle_lights(true);
		}
		else {
			SerialBT.write(0b11000010);
			toggle_lights(false);
		}

		delay(200);
	}
}

void toggle_lights(boolean status) {
	if (status) {
		digitalWrite(voorLichten, HIGH);
		voorlichtStatus = false;
	}
	else {
		digitalWrite(voorLichten, LOW);
		voorlichtStatus = true;
	}
}
