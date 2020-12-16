/*
class Particle extends PVector
{
   float x; 
   float y; 
   float z; 
  Particle(PVector p){
   x=p.x; 
   y=p.y; 
   z=p.z; 
  }
  void printCoordinates(){
  print("x= ",x," y= ",y," z= ",z);}
}  */

class Particle extends VerletParticle3D {

  Particle(float x,float y,float z){
    super(x,y,z);
  }
  
  
  Particle(Vec3D loc) {
    super(loc);
  }
    void display() {
    fill(127);
    stroke(255);
    strokeWeight(2);
    line(0,0,0,x,y,z);
   // ellipse(x,y,32,32);
  }
}
