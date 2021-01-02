
class Enemybomb { 
  PVector location;
  PVector velocity;
  PVector acceleration;

  // Size
  float r = 10;
  int h=0;
  
  float topspeed = 20;


  Enemybomb(float x, float y) {
    //location = new PVector(x,y);
    location = new PVector(x,y);
    velocity = new PVector();
    acceleration = new PVector();
  } 

  void update() { 
    velocity.add(acceleration);
    velocity.limit(topspeed);
    //location.add(velocity);
     location.add(velocity);
    acceleration.mult(0);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }
  
  void display() { 
    
     for (int i=0;i<ship.length;i++)
     {
       
    
    
    noStroke();
    pushMatrix();
    
     translate(ship[i].location.x+20,nuke[i].location.y+30);
     
     
    fill(255,0,0);
    //ellipse(0,0,r*2,r*2);
    shape(aliennuke,-135,-100,270,200);
    popMatrix();
     }
    
    
  }
  
  
  
  
  void drop()
  {
   
    for (int i=0;i<ship.length;i++)
    {
      
    if(ship[i].location.x< currentlocation.x +130 )  //&& !(ship[i].location.x< currentlocation.x -100) //+100
    {
     
     
     
          nuke[i].location.y = nuke[i].location.y+ dropspeed; //1
     
      
    
    }
    else
  {
    nuke[i].location.y = ship[i].location.y;
    
  }
  
    }
  
  
  
    
    
  }
 
   

void checkEdges(){
    
    //if (location.y>height-170){
    //  location.y = height-170;
    //}
    
    
    
    for (int i=0;i<ship.length;i++)
    {
    //height-170
     if (nuke[i].location.y>height-190){
     nuke[i].location.y = height-165;
     
     stroke(255,0,0);
    fill(255,215,0);
  
     pushMatrix();
  //Bomb Animation
    translate(ship[i].location.x+25, nuke[i].location.y);
    nuke[i].location.x=ship[i].location.x;
    quadraticForm( 24 , 50 , 25);
    popMatrix();
     
     
     
     
     
     
     
      nuke[i] = new Enemybomb(ship[i].location.x, nuke[i].location.y= ship[i].location.y); 
      nuke[i].location.x=ship[i].location.x;
    }
    
    }
      
   
  }
  
  

  
  
  


    void collide(Wheel t) {
       
       
    for (int i=0;i<ship.length;i++)
    {
      
      
      
 //float dis = dist(ball.location.x, ball.location.y-10, t.location.x, t.location.y);
    float dis = dist(ship[i].location.x, nuke[i].location.y, currentlocation.x, currentlocation.y);
    float overlap = dis - nuke[i].r - t.rad;//calculate if they are overlapping 
     //float overlap2 = dis - ball.r - t.radius+30;//calculate if they are overlapping 
    if (overlap < 20) { //if they are overlaping
     
     h++;
    println("tank hit"+ h);
    if(health>0)
    {
      if(powerused==false)
      {
    health = health - 0.3; //0.2 0.76
     healthbar = healthbar - 1.14;
      }
     
     if(powerused==true)
     {
       shield = shield - 0.3;
     shieldbar = shieldbar - 1.14;
    if(shield<1)
    {
      powerused=false;
      powercounter=1;
    }
       
     }
     
    }
    
      //---------------------------------
    stroke(255,0,0);
    fill(255,215,0);
   
    pushMatrix();
    translate(currentlocation.x, currentlocation.y);
    //translate(currentlocation.x, currentlocation.y);
    quadraticForm( 24 , 50 , 25);
    popMatrix();
    
    //PVector location = new PVector(50, 340);
    //ball = new CannonBall(location.x, location.y); 
    
   strokeWeight(1);
     
    //---------------------------------
     
    }
    
    
    
    
    }
    
      
   
    
    
  }
  













}