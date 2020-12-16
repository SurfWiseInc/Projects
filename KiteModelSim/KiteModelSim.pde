import grafica.*;
//
float vw = 10; //m/s
int   L = 100; //m
int   E = 5;   //C_L/C_D

KiteModel kiteModel = new KiteModel(E , L , vw);

void setup() {
  size(1000, 1050);
  background(150);

  // Prepare the points for the plot
  int arTheta_dot = 160; // ar=array
  int arTheta = 160;
  int arKsi = 160;
  int arVa = 160;
  
  GPointsArray reTheta_dot = new GPointsArray(arTheta_dot); //re=result
  GPointsArray reTheta = new GPointsArray(arTheta);
  GPointsArray reKsi = new GPointsArray(arKsi); //re=result
  GPointsArray reVa = new GPointsArray(arVa);
   
int   t = 0;

float Ksi = 0;//mouseX; //

float va;
float theta_dot;

float theta = kiteModel.calcTheta0(Ksi,E); //atan(E*cos(Ksi));
//float degTheta = degrees(theta);
int i=0;
  while (t<160){
   
  va = kiteModel.calcVa(vw, theta, E);   //vw * E * cos(theta);
  
  theta_dot = kiteModel.calcThetaDot(Ksi,theta,va,L);  //(va/L) * ((cos(Ksi)) - (tan(theta)/E));
  theta = theta + theta_dot;
    
    //add results to vectors
    reTheta_dot.add(t,degrees(theta_dot));
    reTheta.add(t, degrees(theta));
    reKsi.add(t, degrees(Ksi));
    reVa.add(t,va);
    
    t++;
    
    Ksi=radians(t);
    if (t>60){
     
    Ksi=radians(60-i++);}
    if (t>120)
    Ksi=0;
    //if (t>30) {Ksi=radians(70);}
    //if (t>80) {Ksi=radians(83);}
    println("t=  " , t , "Ksi= " , degrees(Ksi));
    
  //println("t: ", t, "Theta_dot: ", theta_dot, "  Theta: ", degrees(theta));
  }
  
  // Create a new plot and set its position on the screen
  GPlot plot1 = new GPlot(this);
  plot1.setPos(25, 25);
    GPlot plot2 = new GPlot(this);
  plot2.setPos(25, 325);
  GPlot plot3 = new GPlot(this);
   plot3.setPos(450,25);
   GPlot plot4 = new GPlot(this);
   plot4.setPos(450,325);
   
  // or all in one go
  // GPlot plot = new GPlot(this, 25, 25);

  // Set the plot title and the axis labels
  plot1.setTitleText("Theta_dot");
  plot1.getXAxis().setAxisLabelText("t");
  plot1.getYAxis().setAxisLabelText("degree/s");
  
   // Set the plot title and the axis labels
  plot2.setTitleText("Theta");
  plot2.getXAxis().setAxisLabelText("t");
  plot2.getYAxis().setAxisLabelText("degree");

  plot3.setTitleText("va");
  plot3.getXAxis().setAxisLabelText("t");
  plot3.getYAxis().setAxisLabelText("m/s");
  
   // Set the plot title and the axis labels
  plot4.setTitleText("Ksi");
  plot4.getXAxis().setAxisLabelText("t");
  plot4.getYAxis().setAxisLabelText("degree");
  // Add the points
  plot1.setPoints(reTheta_dot);
  plot2.setPoints(reTheta);
  plot3.setPoints(reVa);
  plot4.setPoints(reKsi);
  // Draw it!
  plot1.defaultDraw();
  plot2.defaultDraw();
  plot3.defaultDraw();
  plot4.defaultDraw();
}
