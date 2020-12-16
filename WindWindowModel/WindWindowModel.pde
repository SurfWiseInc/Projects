import toxi.math.*;
import toxi.math.conversion.*;
import toxi.math.waves.*;
import toxi.physics3d.*;
import toxi.physics3d.behaviors.*;
import toxi.physics3d.constraints.*;

import peasy.*;
import toxi.geom.*;
import toxi.processing.*;
import processing.serial.*;


PeasyCam cam;
PVector[][] globe;
int total= 100;
//PVector P1,P2,P3,P4;
Particle p0,p1,p2,p3,p4,p5;
Vec3D P0,P1,P2,P3,P4,P5,s1,s2,s3,s4,s5;

  PVector S1;
  
  int cols, rows;
int scl = 400;
int w = 10000;
int h = 10000;

float[][] terrain;

VerletPhysics3D physics;
float g = 9.81;

void setup(){
  size(1440,900,P3D);
   cam=new PeasyCam(this,-300,300,0,1600);
   
   physics = new VerletPhysics3D();
   physics.addBehavior(new GravityBehavior3D(new Vec3D(0,g,5)));
  // physics.addBehavior(new ConstantForceBehavior( force))
    colorMode(HSB);
    globe= new PVector[1440][900];
    cam.setRotations(0, PI, PI);
  
  //P1 = new PVector(0,100,50);
  //point(P1.x,P1.y,P1.z);
  //P2 = new PVector(0,190,90);
  //point(P2.x,P2.y,P2.z);
 P0 = new Vec3D(0,0,0);
 P1 = new Vec3D(0,100,50);
 P2 = new Vec3D(0,200,100);
 P3 = new Vec3D(0,300,150);
 P4 = new Vec3D(0,400,200);
 P5 = new Vec3D(0,500,250);
 
 
 p0 = new Particle(P0);
 p1 = new Particle(P1);
 p2 = new Particle(P2);
 p3 = new Particle(P3);
 p4 = new Particle(P4);
 p5 = new Particle(P5);
 
 
 s1 = P1;
 s2 = P2.sub(P1); 
 s3 = P3.sub(P2);
 s4 = P4.sub(P3); 
 s5 = P5.sub(P4);
 
  //p0 = new Particle(0,0,0);
  //p1 = new Particle(0,100,50);
  //p2 = new Particle(0,195,95);
  //p3 = new Particle(0,490,190);
  
  
  p0.lock();
  
  float k = 0.99;
  
  VerletSpring3D spring01=new VerletSpring3D(p0,p1,100,k);
  VerletSpring3D spring12=new VerletSpring3D(p1,p2,100,k);
  VerletSpring3D spring23=new VerletSpring3D(p2,p3,100,k);
  VerletSpring3D spring34=new VerletSpring3D(p3,p4,100,k);
  VerletSpring3D spring45=new VerletSpring3D(p4,p5,100,k);
  
  physics.addParticle(p0);
  physics.addParticle(p1);
  physics.addParticle(p2);
  physics.addParticle(p3);
  physics.addParticle(p4);
  physics.addParticle(p5);
  
  physics.addSpring(spring01);
  physics.addSpring(spring12);
  physics.addSpring(spring23);
  physics.addSpring(spring34);
  physics.addSpring(spring45);
  //p3.addForce(new Vec3D(0,-g,0));
  //p3.addForce(new Vec3D(0,10,0));
   //physics.addBehavior(new ConstantForceBehavior( force))

  //p1.printCoordinates();
  //S1= P1.sub(P2);
  
  
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];
  
}

void draw(){
  
  physics.update();
  
 colorMode(HSB);
   createWindWindow();
   createTerrain();
   //line(0,0,0,p1.x,p1.y,p1.z);
  //line(0,0,0,P1.x,P1.y,P1.z);
  
  stroke(0);
  strokeWeight(5);
  line(p0.x, p0.y, p0.z, p1.x, p1.y, p1.z);
  line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
  line(p2.x, p2.y, p2.z, p3.x, p3.y, p3.z);
  line(p3.x, p3.y, p3.z, p4.x, p4.y, p4.z);
  line(p4.x, p4.y, p4.z, p5.x, p5.y, p5.z);
  
  
  //stroke(0);
  //line(P0.x,P0.y,P0.z, s1.x,s1.y,s1.z);//  s1.x, p0.y, p0.z, p1.x, p1.y, p1.z);
  //line(s1.x,s1.y,s1.z,s2.x,s2.y,s2.z);
  //line(s2.x,s2.y,s2.z,s3.x,s3.y,s3.z);
  
  p0.display();
  p1.display();
  p2.display();
  p3.display();
  p4.display();
  p5.display();
  
  //line(P1.x,P1.y,P1.z,P2.x,P2.y,P2.z);
  
  colorMode(RGB);
  stroke(20);
  
  fill(0, 255, 201);

  //translate(width/2, height/2+50);
  rotateX(PI/2);
  translate(-w/2, -h/2);
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
      //rect(x*scl, y*scl, scl, scl);
    }
    endShape();
  }
  
  float x = map(mouseX,0,1440,-10,10);
  float y = map(mouseY,0,900,-10,100);
  //physics.addBehavior(new ForceBehavior(new Vec3D(0,y,x)));
  physics.addBehavior(new GravityBehavior3D(new Vec3D(0,g,x)));
  //line(0,0,0,P1.x,P1.y,P1.z);
  
  //line(P1.x,P1.y,P1.z,P2.x,P2.y,P2.z);
}

void createWindWindow(){
    background(0);
    noStroke();
    lights();
    stroke(255);
    strokeWeight(5);
    point(0,0,0);
    noStroke();
    
   float r = 900;                       //r -radius of wind window
  for (int i = 0; i < total+1; i++) {
    float lat = map(i, 0, total, 0, PI/2);
      for (int j = 0; j < total+1; j++) {
        float lon = map(j, 0, total, 0, TWO_PI/2);
        float x = r * sin(lat) * cos(lon);
        float y = r * sin(lat) * sin(lon);
        float z = r * cos(lat);
        globe[i][j] = new PVector(x, y, z);
        //print(i+" col ;"+j+" row ; Coordinates x y z:  "+x+"  "+y+"  "+z+"\n");
      }
    }

  for (int i = 0; i < total; i++) {
      float hu = map(i, 0, total, 0, 65);
      fill(hu  % 255, 255, 255);
      tint(255, 0);
      //fill(255);
      beginShape(TRIANGLE_STRIP);
      tint(255, 127);
    for (int j = 0; j < total+1; j++) {
        PVector v1 = globe[i][j];
        vertex(v1.x, v1.y, v1.z);
        PVector v2 = globe[i+1][j];
        vertex(v2.x, v2.y, v2.z);
        //stroke(255);
        //point(v1.x, v1.y, v1.z);
    }
    endShape();
  }
  stroke(255);
  strokeWeight(2);
      /*float lx=map(mouseY,0,width,0,total+1);
      float ly=map(mouseX,0,height,0,total+1);
      PVector v1 = globe[(int)lx][(int)ly];
      line(0,0,0,v1.x, v1.y, v1.z);
      strokeWeight(10);*/
      //point(v1.x, v1.y, v1.z);
      //PVector v2 = globe[i+1][j];
      //vertex(v2.x, v2.y, v2.z);
      //float rot_speed_Y=map(ypr[1],-PI,PI,-0.15,0.15);
    }
    
    void createTerrain(){
   for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = 0;//map(noise(xoff, yoff), 0, 1, -100, 100);
     
    }
  }}
    
    void drawReferenceLines(){
       strokeWeight(2);
       //X reference line Green!
       stroke(#00ff00);
       line(0,0,0,200,0,0);
     
     stroke(#ff0000);
     line(0,0,0,0,200,0);
     
     stroke(#0000ff);
     line(0,0,0,0,0,200);
     
    //shape(kite,0,0);
     popMatrix();}
