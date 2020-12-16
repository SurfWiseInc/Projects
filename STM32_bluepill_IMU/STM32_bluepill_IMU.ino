#include <Wire.h>

int16_t Gyro_X,Gyro_Y,Gyro_Z;

void setup() {
  Serial.begin(57600);
  Wire.setClock(400000);
  Wire.begin();
  delay(250);

  Wire.beginTransmission(0x68);  //Start of communication with MPU 6050
}

void loop() {
  Wire.beginTransmission(0x68);
  Wire.write(0x43);
  Wire.endTransmission();
  
  Wire.requestFrom(0x68, 6);
  Gyro_X = Wire.read()<<8 | Wire.read();
  Gyro_Y = Wire.read()<<8 | Wire.read();
  Gyro_Z = Wire.read()<<8 | Wire.read();

  Serial.print("X = ");Serial.print(Gyro_X);
  Serial.print("Y = ");Serial.print(Gyro_Y);
  Serial.print("Z = ");Serial.println(Gyro_Z); 
}
