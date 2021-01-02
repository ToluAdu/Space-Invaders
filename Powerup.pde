
class Powerup { 
  PVector location;
  PVector velocity;
  PVector acceleration;
  int hascollided=0;

  // Size
  float r = 10;
  
  float topspeed = 20;
  boolean isHit;

  Powerup(float x, float y) {
    //location = new PVector(x,y);
    location = new PVector(x,y);
    velocity = new PVector();
    acceleration = new PVector();
     
  } 


  
  void display() { 
   int e = int(random(0,200));// 
   //int e = 7; 
    fill(0,0,255);
    if(e==7||powerstart==true)
    {
    
   powerstart=true;
    
    if (powerused==false&&powercounter==0)
    {
    noStroke();
    //ellipse(location.x,location.y,30,30);
       shape(alienshield,location.x-104,location.y-70,270,200);
    }
    
    }
    
    if(e==76)
    {
      powerstart=false;
      power.location.x = random(0+40,width-40);
    }
    
    
  }




    void collide(Wheel tank) {
    
    
   if(powerused==false&&powercounter==0&&powerstart==true)
   {
  
    float dis = dist(power.location.x, power.location.y, tank.loc.x+5, tank.loc.y);
    float overlap = dis - power.r - tank.rad;//calculate if they are overlapping 
     //float overlap2 = dis - ball.r - t.radius+30;//calculate if they are overlapping 
    if (overlap < 0 && overlap >-4) { //if they are overlaping
     
    println("POWERUP ACTIVATED");
    powerused=true;
    
     
     
    
     
    }
  
   }

  if(powerused==true)
  {
    fill(0,0,255);
     rect(220,height-95, shieldbar, 20);//shield
     text("Shield:     ",width-650,height-80);
     text(int(shield),width-125,height-80); 
    
  }
  
  
  
  
 
}
  















}