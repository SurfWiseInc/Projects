class KiteModel
{
int E;      //Ratio of Cl/Cd
int L;      // Lenght of lines [  m  ]
float vw;        // Speed of wind   [ m/s ]
float Theta;     // Theta angle of the kite
float ThetaDot;  // Speed of rate of Theta angle [ rad/s ]

KiteModel(int CoefRatio, int LinesLenght, float WindSpeed)
{
  E = CoefRatio;
  L = LinesLenght;
  vw = WindSpeed;
}
float calcVa(float vw, float Theta , int E){
 return vw * E * cos(Theta);
}

  float calcTheta0(float Ksi, int E){
      float Theta0 = atan(E*cos(Ksi));
      return Theta0;}
  
  //va = apparent speed , L = lenght of lines
float calcThetaDot(float Ksi, float Theta, float va, int L){
    return (va/L) * ((cos(Ksi)) - (tan(Theta)/E));
    }
  
 float calcDeflection(float g, float va , float delta) // g - proportionality factor, delta - deflection on a kite
 {
   float Ksi_dot = g * va * delta;
   return Ksi_dot;
 }
 
}
