/*
 Name:		TreinSecties.ino
 Created:	5/24/2021 10:54:16 PM
 Author:	Arthur Clarysse
*/


// 54 - 66
int switchPoints[] = { 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500 };
//int switchPoints[] = { 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200 };
int knop = 12;

#define slagboomSensor A13

#define IN11 22
#define IN12 23
#define IN13 24
#define IN14 25

#define IN21 26
#define IN22 27
#define IN23 28
#define IN24 29


void setup() {
	Serial1.begin(9600);
	Serial.begin(9600);

	for (int x = 2; x < 15; x++) {
		pinMode(x, OUTPUT);
	}

	pinMode(IN11, OUTPUT);
	pinMode(IN12, OUTPUT);
	pinMode(IN13, OUTPUT);
	pinMode(IN14, OUTPUT);

	pinMode(IN21, OUTPUT);
	pinMode(IN22, OUTPUT);
	pinMode(IN23, OUTPUT);
	pinMode(IN24, OUTPUT);

	configBreakpoint();
}

void loop() {
	byte mask = 0b00000001;
	byte data[2] = { 0b00000000, 0b00000000 };

	for (int x = 54; x < 63; x++) {
		//Serial.println(analogRead(x));
		if (analogRead(x) > switchPoints[x - 54]){
			data[0] ^= mask;

		}
		else {
		}

		mask <<= 1;

	}

	mask = 0b00000001;

	for (int x = 62; x < 67; x++) {
		if (analogRead(x) > switchPoints[x - 54]) {
			data[1] ^= mask;

		}
		else {
		}

		mask <<= 1;
	}

	mask = 0b00000001;

	for (int x = 2; x < 15; x++) {
		digitalWrite(x, LOW);
	}

	for (int x = 0; x < 8; x++) {
		if (data[0] & mask << x) {
			digitalWrite(x + 2, HIGH);
		}
	}

	mask = 0b00000001;

	for (int x = 0; x < 8; x++) {
		if (data[1] & mask << x) {
			digitalWrite(x + 8 + 2, HIGH);
		}
	}

	/*if (analogRead(slagboomSensor) < 20) {
		Serial.println("SLAGBOOM");
		draaiStepper(125, "R");
		delay(1000);
		draaiStepper(125, "L");
	}*/

	if (data[0] & 0b01000000) {
		Serial.println("SLAGBOOM");
		draaiStepper(125, "R");
		delay(1000);
		draaiStepper(125, "L");
	}

	if (Serial1.available() > 0) {
		configBreakpoint();
	}

	Serial1.write(data, 2);
	Serial.println(data[0]);
	Serial.println(data[1]);
	Serial.println();

	delay(200);
}

void configBreakpoint() { // function to configure when it's "Dark" or "Light"
	int lightPoint[13] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
	int darkPoint[13] = { 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500 };

	for (int i = 0; i < 13; i++) {
		digitalWrite(i + 2, HIGH);
		delay(1000);
		digitalWrite(i + 2, LOW);
		delay(500);
		digitalWrite(i + 2, HIGH);
		delay(1000);
		digitalWrite(i + 2, LOW);
		delay(500);
		digitalWrite(i + 2, HIGH);
		delay(500);
		digitalWrite(i + 2, LOW);
		delay(500);
		digitalWrite(i + 2, HIGH);
		delay(500);

		lightPoint[i] = analogRead(i);
		digitalWrite(i + 2, LOW);
	}

	Serial.println("\nVOLGENDE\n");

	for (int i = 0; i < 13; i++) {
		digitalWrite(i + 2, HIGH);
		delay(1000);
		digitalWrite(i + 2, LOW);
		delay(500);
		digitalWrite(i + 2, HIGH);
		delay(1000);
		digitalWrite(i + 2, LOW);
		delay(500);
		digitalWrite(i + 2, HIGH);
		delay(500);
		digitalWrite(i + 2, LOW);
		delay(500);
		digitalWrite(i + 2, HIGH);
		delay(500);

		darkPoint[i] = analogRead(i);
		digitalWrite(i + 2, LOW);
	}

	for (int i = 0; i <= 13; i++) {
		int diff = darkPoint[i] - lightPoint[i];

		switchPoints[i] = lightPoint[i] + ((diff / 3) * 2);
	}
}

void draaiStepper(int aantal, String richting) {
	int start = 0;
	int test = aantal * 8;
	int ronde = 0;


	for (int i = 0; i < test; i++) {

		// LINKS
		if (richting == "L") {
			if (start == 0) {
				ronde = 8;
				start = 1;
			}

			ronde--;
			if (ronde == 0) {
				ronde = 7;
			}
		}

		//RECHTS
		else if (richting == "R") {
			if (start == 0) {
				ronde = 0;
				start = 1;
			}

			ronde++;

			if (ronde == 8) {
				ronde = 0;
			}
		}


		switch (ronde) {
		case 0:
			digitalWrite(IN11, HIGH);
			digitalWrite(IN12, LOW);
			digitalWrite(IN13, LOW);
			digitalWrite(IN14, LOW);

			digitalWrite(IN21, LOW);
			digitalWrite(IN22, LOW);
			digitalWrite(IN23, LOW);
			digitalWrite(IN24, HIGH);
			break;
		case 1:
			digitalWrite(IN11, HIGH);
			digitalWrite(IN12, HIGH);
			digitalWrite(IN13, LOW);
			digitalWrite(IN14, LOW);

			digitalWrite(IN21, LOW);
			digitalWrite(IN22, LOW);
			digitalWrite(IN23, HIGH);
			digitalWrite(IN24, HIGH);
			break;
		case 2:
			digitalWrite(IN11, LOW);
			digitalWrite(IN12, HIGH);
			digitalWrite(IN13, LOW);
			digitalWrite(IN14, LOW);

			digitalWrite(IN21, LOW);
			digitalWrite(IN22, LOW);
			digitalWrite(IN23, HIGH);
			digitalWrite(IN24, LOW);
			break;
		case 3:
			digitalWrite(IN11, LOW);
			digitalWrite(IN12, HIGH);
			digitalWrite(IN13, HIGH);
			digitalWrite(IN14, LOW);

			digitalWrite(IN21, LOW);
			digitalWrite(IN22, HIGH);
			digitalWrite(IN23, HIGH);
			digitalWrite(IN24, LOW);
			break;
		case 4:
			digitalWrite(IN11, LOW);
			digitalWrite(IN12, LOW);
			digitalWrite(IN13, HIGH);
			digitalWrite(IN14, LOW);

			digitalWrite(IN21, LOW);
			digitalWrite(IN22, HIGH);
			digitalWrite(IN23, LOW);
			digitalWrite(IN24, LOW);
			break;
		case 5:
			digitalWrite(IN11, LOW);
			digitalWrite(IN12, LOW);
			digitalWrite(IN13, HIGH);
			digitalWrite(IN14, HIGH);

			digitalWrite(IN21, HIGH);
			digitalWrite(IN22, HIGH);
			digitalWrite(IN23, LOW);
			digitalWrite(IN24, LOW);
			break;
		case 6:
			digitalWrite(IN11, LOW);
			digitalWrite(IN12, LOW);
			digitalWrite(IN13, LOW);
			digitalWrite(IN14, HIGH);

			digitalWrite(IN21, HIGH);
			digitalWrite(IN22, LOW);
			digitalWrite(IN23, LOW);
			digitalWrite(IN24, LOW);
			break;
		case 7:
			digitalWrite(IN11, HIGH);
			digitalWrite(IN12, LOW);
			digitalWrite(IN13, LOW);
			digitalWrite(IN14, HIGH);

			digitalWrite(IN21, HIGH);
			digitalWrite(IN22, LOW);
			digitalWrite(IN23, LOW);
			digitalWrite(IN24, HIGH);
			break;
		}

		//if (Serial.available() > 0) {
		//	if (lees() == 1) {
		//		break;
		//	}
		//}

		delayMicroseconds(1000);
	}
}