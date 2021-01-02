class Target{
  PVector location;
  PVector velocity;
  PVector acceleration;
  color mycolor;
  float radius;

  boolean isDead; //has it been eaten (or is it dead?)
  int limb;//how many limbs of the quadratic shape - this is for design task 3
  
  void update(){
    //change location , i.e. move the object. In the Food object, we move the food by changing the
    //velocity directly, instead of applying forces to it
    location.add(velocity); 
  }

  void display(){ //draw the food
    noStroke();
    //fill(mycolor);    
    pushMatrix();
    translate(location.x, location.y);
    
    //change the ellipse code to draw a quadratic shape. this is for design task 3
    //ellipse(0,0, mass, mass);
    shape(shipgraphic,-80,-102,200,200);
    
    //--------------------
    //fill(0,191,255);
    //rect(0,0,20,20);
    //fill(128,128,128);
    //triangle(-20,20,10,0,70,20);
    //fill(0);
    //triangle(40,19,80,-1,70,19);
    //-------------------------------
    popMatrix();
  }
  
  
  
    Target(float r,float x, float y){ //constructor, initialise properties/variables
    location = new PVector(x,y);
    //acceleration = new PVector(0,0);
    radius = r;
    
    
   //mycolor = color(random(0,200), random(0,150), random(0,150), random(20,100));//random colour
    //isDead = false; //set isDead to false. the food object is just created, so it is not yet dead(eaten)
    //velocity = new PVector (random(-2,2), random(-2,2));//assign a random velocity
    //limb = int(random(3,25));
 
}

int []shipSpeed = new int[ship.length];

void moveTarget()
{
   
   
   
   for (int i=0;i<ship.length;i++)
  {
   
 location.x = location.x - shipSpeed[i];
  
  if(ship[i].location.x<0)
  {
    
    ship[i] = new Target(90,width-30,random(0,260));  //random(0+30,width-30)
    ship[i].randomSpeed();
    
  }

  
  }


}


void randomSpeed()
{
  for (int i=0;i<ship.length;i++)
  {
   shipSpeed[i]= int(random(1,3));
  }
   
    //shipSpeed[0]= int(random(1,3));
    //  shipSpeed[1]= int(random(1,3));
    //    shipSpeed[2]= int(random(1,3));
    //      shipSpeed[3]= int(random(1,3));
    //        shipSpeed[4]= int(random(1,3));
           
    
  
  
  
}








}