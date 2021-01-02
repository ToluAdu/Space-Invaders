class Wheel { 
  
PVector loc = new PVector(currentlocation.x, currentlocation.y);

float rad = 20;
  Wheel() {
    
  } 

 
    
   void display(){ //draw the food
   loc.x=currentlocation.x;
     loc.y=currentlocation.y;
    
    //pushMatrix();
  
  //translate(currentlocation.x, currentlocation.y);
  //translate(25+currentlocation.x, 340); //60
  
  //fill(0);
  
// rotate(loc.x);
  //arc(0,0,20,20,0,radians(340));
  //rotate(wheel);
  //arc(-25,8,20,20,0,radians(340));
  //fill(255,255,0);
  //popMatrix();
    
    pushMatrix();
    translate(25+currentlocation.x, 340);
    rotate(loc.x);
     shape(spacewheel,-75, -55,150,110);
     popMatrix();
    
//-----------------------------------    
    
  //pushMatrix();
  //translate(currentlocation.x, currentlocation.y);
  //translate(-25+currentlocation.x, 340); //-40
  //fill(0);
  //rotate(loc.x);
  //arc(0,0,20,20,0,radians(340));
  //rotate(wheel);
  //arc(-25,8,20,20,0,radians(340));
  //fill(255,255,0);
  //popMatrix();
  
  pushMatrix();
    translate(-25+currentlocation.x, 340);
    rotate(loc.x);
     shape(spacewheel,-75, -55,150,110);
     popMatrix();
    
    
  } 
   
  













}