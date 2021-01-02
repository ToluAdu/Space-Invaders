
class CannonBall { 
  PVector location;
  PVector velocity;
  PVector acceleration;

  // Size
  float r = 10;
  

  float topspeed = 20;
  boolean isShot;

  CannonBall(float x, float y) {
    //location = new PVector(x,y);
    location = new PVector(x,y);
    velocity = new PVector();
    acceleration = new PVector();
      isShot = false;
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
    noStroke();

    pushMatrix();
          
     translate(location.x,location.y);
    
     if(keyPressed&&isShot==false)
     {
       translate(currentlocation.x,currentlocation.y);
       location.x = currentlocation.x;
       location.y = currentlocation.y;
     }
     
      if(keypress==1&&isShot==false||keypress2==1&&isShot==false)
     {
       translate(currentlocation.x,currentlocation.y);
       location.x = currentlocation.x;
       location.y = currentlocation.y;
     }
     
  
       shape(aliencannon,-33,-37,140,100);
       
       
    //ellipse(0,0,r*2,r*2);
    popMatrix();
  }

void checkEdges(){
    
    //if (location.y>height-170){
    //  location.y = height-170;
    //}
    
     if (currentlocation.y>height-155){
      currentlocation.y = height-155;
    }
      
    
  }


    void collide(Target t) {
 //float dis = dist(ball.location.x, ball.location.y-10, t.location.x, t.location.y);
    
    for (int w = 0; w < missile.length; w++) {
    for (int i=0;i<ship.length;i++)
  {
    
    
    
    float dis = dist(missile[w].location.x, missile[w].location.y-15, ship[i].location.x+40, ship[i].location.y-35);
    float overlap = dis - missile[w].r - ship[i].radius;//calculate if they are overlapping 
     //float overlap2 = dis - ball.r - t.radius+30;//calculate if they are overlapping 
    if (overlap < -60) { //if they are overlaping
     
    println("overlap");
    bombsound = minim.loadSnippet("Bomb.mp3");
    
    bombsound.play();
      //---------------------------------
    stroke(255,0,0);
    fill(255,215,0);
   
    pushMatrix();
    translate(location.x, location.y);
    //translate(currentlocation.x, currentlocation.y);
    quadraticForm( 24 , 50 , 25);
    popMatrix();
    
    //PVector location = new PVector(50, 340);
    //ball = new CannonBall(location.x, location.y); 
    
   
    missile[w] = new CannonBall(currentlocation.x, currentlocation.y);  
    
    
   ship[i]= new Target(90,width-30,random(0,260));  //random(0+30,width-30)
   
   
   
   if(score<1000)
   {
      score = score + cannonscore;
     
   }
   else if(score>=1000)
   {
     
     
     
      //fill(0,0,139);
     //text("Wave 1 complete",240,160);
     
      //text("You helped save the earth!",150,200);
       //text("Wave 2 get ready!",240,240);
       //text("Press space to continue",170,320);
      
       //noLoop();
     // println("WAVECOMPLETE-----------------------------------------------------");
      gamecomplete=true;
 }
   
  
   ship[i].randomSpeed();

    
   
    
    
   missile[w].isShot = false;
    //---------------------------------
     
    }
  


  }
  
  
  
  
  
    }






}
  















}