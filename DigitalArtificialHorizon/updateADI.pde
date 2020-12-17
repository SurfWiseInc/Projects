void updateADI()
{
  // This is the function containing everything that has to
  // do with the moving parts of the artificial horizon
  
  //IF YOU READ VALUE FROM MOUSE POSITION
        float newY = map(mouseY,0,height, 0,300);
 //IF YOU READ VALUE FROM MPU6050
       //float newY = map(-ypr[1]*180/PI,-90,90,0,300);
 

  // non tilting lines
strokeWeight(2);
  pushMatrix();
  translate(150,150);
  //rotate(euler[2]);
  popMatrix();
  
  // This is here so you can easily change the width of the gap
  // between the white lines
  int gap = 13;
  line(115, newY+6*gap, 185, newY+6*gap);
  line(140, newY+5*gap, 160, newY+5*gap);
  line(120, newY+4*gap, 180, newY+4*gap);
  line(140, newY+3*gap, 160, newY+3*gap);
  line(125, newY+2*gap, 175, newY+2*gap);
  line(140, newY+1*gap, 160, newY+1*gap);
  line(140, newY-1*gap, 160, newY-1*gap);
  line(125, newY-2*gap, 175, newY-2*gap);
  line(140, newY-3*gap, 160, newY-3*gap);
  line(120, newY-4*gap, 180, newY-4*gap);
  line(140, newY-5*gap, 160, newY-5*gap);
  line(115, newY-6*gap, 185, newY-6*gap); 
  
   
}
