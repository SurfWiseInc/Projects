//program presents turn rate law of surf kite simulation 

//for succesful run off app it is necessary to import grafica library via ProcessingIDE - Sketch > Import library > grafica
import grafica.*;

float vw = 10; // [m/s] - speed of wind
int   L = 100; //  [m]  - lenght of tether between kite and pilot
int   E = 5;   // C_L/C_D - lif to drag coeff ratio

KiteModel kiteModel = new KiteModel(E , L , vw);

void setup() {
  size(950, 700);
  background(150);
  // Prepare the points for the plot
  int arTheta_dot = 160; // ar=array
  int arTheta = 160;
  int arKsi = 160;
  int arVa = 160;
  
  GPointsArray reTheta_dot = new GPointsArray(arTheta_dot); //re=result
  GPointsArray reTheta = new GPointsArray(arTheta);
  GPointsArray reKsi = new GPointsArray(arKsi); 
  GPointsArray reVa = new GPointsArray(arVa);
   
int   t = 0;
float Ksi = 0;
float va;
float theta_dot;

float theta = kiteModel.calcTheta0(Ksi,E); //atan(E*cos(Ksi));

  while (t<160){
   
  va = kiteModel.calcVa(vw, theta, E);   //vw * E * cos(theta);
  
  theta_dot = kiteModel.calcThetaDot(Ksi,theta,va,L);  //(va/L) * ((cos(Ksi)) - (tan(theta)/E));
  theta = theta + theta_dot;
    
    //add results to vectors
    reTheta_dot.add(t,degrees(theta_dot));
    reTheta.add(t, degrees(theta));
    reKsi.add(t, degrees(Ksi));
    reVa.add(t,va);
    
   
    
    if (t>60) Ksi=radians(50);
    
    if (t>120)Ksi=radians(86);
    
     t++;
 
    println("t=  " , t , "Ksi= " , degrees(Ksi));
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
   
  // Set the plot title and the axis labels
  plot1.setTitleText("Theta_dot");
  plot1.getXAxis().setAxisLabelText("t");
  plot1.getYAxis().setAxisLabelText("degree/s");
  
  plot2.setTitleText("Theta");
  plot2.getXAxis().setAxisLabelText("t");
  plot2.getYAxis().setAxisLabelText("degree");

  plot3.setTitleText("va");
  plot3.getXAxis().setAxisLabelText("t");
  plot3.getYAxis().setAxisLabelText("m/s");
  
  plot4.setTitleText("Ksi");
  plot4.getXAxis().setAxisLabelText("t");
  plot4.getYAxis().setAxisLabelText("degree");
  // Add the points
  plot1.setPoints(reTheta_dot);
  plot2.setPoints(reTheta);
  plot3.setPoints(reVa);
  plot4.setPoints(reKsi);
  // Draw graphs!
  plot1.defaultDraw();
  plot2.defaultDraw();
  plot3.defaultDraw();
  plot4.defaultDraw();
}
