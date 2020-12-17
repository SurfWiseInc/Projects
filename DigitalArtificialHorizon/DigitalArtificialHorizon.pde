// Program displays orientation of IMU MPU6050 connected to ArduinoUNO
// Orientation is displayed via Digital Artificial Horizon and orientation of airplane model in 3D space

//Comments indicate instruction what needs to be commented
//whether we read data from MPU6050 or mouse position input
//It reads data from mouse position by default

import processing.serial.*;
import processing.opengl.*;
import toxi.geom.*;
import toxi.processing.*;

Serial port;  
PShape s;
PImage bg;
PImage ADI;

char[] teapotPacket = new char[14]; 
int serialCount = 0;                 
int synced = 0;
int interval = 0;

float[] q = new float[4];
Quaternion quat = new Quaternion(1, 0, 0, 0);

float[] gravity = new float[3];
float[] euler = new float[3];
float[] ypr = new float[3];

void setup() {
    
    size(1500, 800, P3D);
    frameRate(100);
      
 bg = loadImage("SKY3.png");
  s = loadShape("Airplane_Model.obj");
 ADI = loadImage("ADI.jpg");
// wat = loadImage("wat3.png"); 
 background(0);
  s.scale(0.10);
  s.rotateX(radians(90));
  s.rotateY(radians(180));
    // setup lights and antialiasing
    lights();
    smooth(8);

/*UNCOMMENT BELOW ONLY IF YOU ARE READING VALUES FROM MPU6050

    // display serial port list for debugging/clarity
    println(Serial.list());
    
    // get a specific serial port (use EITHER this OR the first-available code above)
   String portName = "/dev/tty.usbmodem14201";
    
    // open the serial port
    port = new Serial(this, portName, 115200);
    
    // send single character to trigger DMP init/start
    // (expected by MPU6050_DMP6 example Arduino sketch)
    port.write('r');
 */
}

void draw() {
 // UNCOMMENT MPUINIT(); ONLY IF YOU READ VALUES FROM MPU6050
 // MPUinit();
 
  //IF WE READ FROM MPU6050    
        //float newY = map(ypr[1]*180/PI,-90,90,-150,150);
        //float newX = map(ypr[2]*180/PI,-180,180,0,300);    
  //IF WE READ MOUSE POSSITION
        float newY = map(mouseY,0,height,-150,150);
        float newX = map(mouseX,0,width,-180,180);

   pushMatrix();
     translate(150,150);
     rotate(radians(-newX));
     imageMode(CENTER);
     image(ADI,0,newY,600,600);
   popMatrix();
  
   updateADI();
   drawADIframe();
 
 imageMode(CORNER);
 image(bg,0,0);

 // UNCOMMENT IMUInput(); ONLY IF YOU READ VALUES FROM MPU6050

 //IMUInput();
 
 //instead of data from MPU6050, for test purpuse we can control 
 //the orienation of airplane and ADI indication by position of the mouse
 //we need to comment mouseInput() line if we read data from MPU6050
 //if we place cursour in the center of the window we have orientation with pitch = 0 ; roll = 0;
mouseInput();

}

void mouseInput(){
 pushMatrix();
    translate(width / 2, height / 2, 500);
    float newYr = map(mouseY,0,height, 90,-90);
    float newXr = map(mouseX,0,width,-180,180);
    //rotateY(newX);
    rotateX(radians(newYr));
    rotateZ(radians(newXr));   
     shape(s,0,0);
 popMatrix();
}

void IMUInput(){
  
  // translate everything to the middle of the viewport
    pushMatrix();
    translate(width / 2, height / 2,500);
    //println("euler: ", euler[0],euler[1],euler[2]);
   
    // toxiclibs direct angle/axis rotation from quaternion (NO gimbal lock!)
    // (axis order [1, 3, 2] and inversion [-1, +1, +1] is a consequence of
    // different coordinate system orientation assumptions between Processing
    
    float[] axis = quat.toAxisAngle();
    //println("Axis :" + axis[0] + " " + axis[1] + "  " + axis[2] + " " + axis[3] );
    rotate(axis[0], -axis[1], axis[3], axis[2]);
    shape(s,0,0); 
}

void MPUinit(){
   if (millis() - interval > 1000) {
        // resend single character to trigger DMP init/start
        // in case the MPU is halted/reset while applet is running
        port.write('r');
        interval = millis();
   }
}
