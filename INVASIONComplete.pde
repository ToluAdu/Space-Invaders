import de.voidplus.leapmotion.*;
import processing.serial.*;
import ddf.minim.*;
import cc.arduino.*;


Minim minim;
AudioSnippet song;
AudioSnippet bombsound;
AudioSnippet laser;
Arduino arduino;

int upPin = 8;
int downPin = 9;

PImage img;
float angle = -PI/4;
PVector location = new PVector(45, 330); 
PVector currentlocation = new PVector(0, 0);
PVector locationEn = new PVector(200, 220);
PVector move = new PVector(5, 0);
boolean shot = false;
int f=0;
int score=0;
float health= 100;
float shield= 100;
float healthbar= 380;
float shieldbar= 380;
PFont font;
String[] fontList = PFont.list();
//------------------------------
PShape pausebutton;
PShape startscreen;
PShape shipgraphic;
PShape aliennuke;
PShape aliencannon;
PShape cannonarm;
PShape tankbody;
PShape spacewheel;
PShape backg;
PShape alienshield;
PShape musicon;
PShape musicoff;

PShape howtoplay;
PImage howtoplay2;
//------------------------------

boolean gamecomplete = false;
boolean powerused= false;
int powercounter=0;
boolean powerstart=false;
boolean gamedone= false;



//int stage=1;
 int stage=0;
int shipnumber=5; //5
int missilenumber=10;
int cannonforce=12;
int dropspeed=1;
int cannonscore = 20; //10
int knobPin = 0;//canon


Target[] ship = new Target[shipnumber];
Enemybomb[] nuke = new Enemybomb[ship.length];
CannonBall[] missile = new CannonBall[missilenumber];
Target enemy;
Wheel tyre;
Enemybomb enbomb;
Powerup power;

int m=0;

LeapMotion leap;
int i=0;
int keypress;
int keypress2;
int knobVal;
Serial myPort;
Serial myPort2;



void setup() {
  size(740, 500);
  
   leap = new LeapMotion(this).allowGestures(); 
  minim = new Minim(this);
  
song = minim.loadSnippet("theme.mp3");
bombsound = minim.loadSnippet("Bomb.mp3");

laser = minim.loadSnippet("Lasergun.mp3");
song.loop(0);
  
  
 //stage = 1;
  stage = 0;
  
  power = new Powerup(random(0+40,width-40),330); 
  
  
  //----------------------------------------------
 
  
  arduino = new Arduino(this, Arduino.list()[1], 57600);
   
    arduino.pinMode(upPin, Arduino.INPUT);
    
    arduino.pinMode(downPin, Arduino.INPUT);
     
    arduino.pinMode(knobPin, Arduino.INPUT);
  
  
  
  
  
  
  
  
  
  //------------------------------------------------
  
  font = createFont("BankGothic MD BT",16,true);
     fill(255,0,255);
  textSize(30);
  textFont(font,30);
  
  //-------------------------------------
  pausebutton = loadShape("pauseblue.svg");
   startscreen = loadShape("screen.svg");
 shipgraphic = loadShape("ShipEn.svg");
  aliennuke = loadShape("Enemy Bomb.svg");
  aliencannon = loadShape("ball.svg");
  cannonarm = loadShape("Cannon.svg");
   tankbody= loadShape("Tank.svg");
   spacewheel= loadShape("wheels.svg");
     backg= loadShape("GameBrocky.svg");
     alienshield= loadShape("shield.svg");
       musicon= loadShape("on.svg");
           musicoff= loadShape("off.svg");
           howtoplay= loadShape("howto.svg");
           howtoplay2= loadImage("bg.jpg");
 //------------------------------------------ 

   for (int f=0; f<missile.length; f++)
  {
    missile[f] = new CannonBall( location.x, location.y);
  }
  
  
  currentlocation.x = location.x;
  currentlocation.y= location.y;
   

  for (int i=0;i<ship.length;i++)
  {
    
    ship[i] = new Target(90,width-30,random(0,260)); //width-30 random(0,260)
    //ship[i] = new Target(90,200,200); //target practice
    nuke[i] = new Enemybomb(locationEn.x, location.y= ship[i].location.y);
    ship[i].randomSpeed();
    
  }
      
  
  tyre = new Wheel();
 
  // arduino = new Arduino(this, Arduino.list()[1], 57600);
 //arduino.pinMode(downPin, Arduino.INPUT);
// arduino.pinMode(knobPin, Arduino.INPUT);
  
  //img = loadImage("bg.jpg");
  
 
}







void draw() {
  
    //-------------------------------------------
    //************************ try this
   
     keypress = arduino.digitalRead(upPin);
    keypress2 = arduino.digitalRead(downPin);
   
    
    
      
    //keypress = myPort.read();

    println(keypress); //print keypress to the debug window
    if (keypress == 1){ //ASCII code for 'U'
 
    keyPressed();
     
   
 
    } else if (keypress2 == 1){//39 //ASCII code for 'D'
  
    keyPressed();
 
   }
   //myPort.clear();//clear the port of all data

  
  //-----------------------------------------------------------
 
  

  
  background(255); 
  noStroke();
 //image(img, 0, 0);
   
     
   shape(backg,0,0,740,500);
   shape(pausebutton,width-40,20,20,20);
   
   if(m==0)
   {
   shape(musicon,width-40,50,20,20);
   }
   else
   {
      shape(musicoff,width-40,50,20,20);
   }
   
   //startgame();
   //gamecheck();
   //pausebutton();
 power.display();
 power.collide(tyre);
   
   
   //screenTest();
   fill(255,255,255);
   textSize(30);
  textFont(font,30);
  text("Score: "+score,width-250,height-130); 
  
  
  fill(255,0,0);
   text("Health:     ",width-650,height-50); 
 text(int(health),width-125,height-50); 
 
 //healthbar
 
 rect(220,height-65, healthbar, 20);
 if(stage!=0)
 {
 for (int i=0;i<ship.length;i++)
  {
    
    ship[i].display();
    nuke[i].display();

 nuke[i].drop();
  nuke[i].checkEdges();
    nuke[i].collide(tyre);
    
      ship[i].moveTarget();
  }
 
 }
 
   tyre.display();
   fill(0,100,0);
   //-----------------------------------------------------------------------
   
   
      
   if(mousePressed==true&&stage!=0&&gamedone==false)
   {
     
  
   if(missile[f].isShot == false)
   {
     laser = minim.loadSnippet("Lasergun.mp3");
    laser.play();
  
   println(f, missile[f].isShot);
   shootanimate();
  
   shot = true;
   missile[f].isShot = true;
   PVector force = PVector.fromAngle(angle);
   force.mult(cannonforce); //wave1=12
   missile[f].applyForce(force);
 
   f++;
   if (f>missilenumber-1)
   {
    f=0;
   }
  
   }
  
   mousePressed=false;
   }
   
   
   
   
   
   
   
   
   
   
   
   
   //---------------------------------------------------------------------------
   
     
    for (int i = 0; i < missile.length; i++) {

    PVector gravity = new PVector(0, 0.2);
    if (missile[i].isShot) {
      missile[i].checkEdges();
      missile[i].applyForce(gravity);
      missile[i].update();
      bomb();

      missile[i].collide(enemy);
    }

  

}
   
  fill(0);
  
  for (int i = 0; i < missile.length; i++) {
  
    missile[i].display();
  
}

   
//------------------------------------------------------------------------   
// int knobVal = arduino.analogRead(knobPin);
//int keypress = arduino.digitalRead(downPin);
//calculate the angle of the cannon based on mouseY position
  
 
  int knobVal = arduino.analogRead(knobPin);
  
  
  restrictTank();
  
  //tank creation
  //angle= map(mouseY, 0, 960, -PI/2, PI/2); //knobVal 1023 //0,960,250
  
  angle= map(knobVal, 0, 1023,  PI/2, -PI/2); //knobVal 1023 //0,960,250
  
  pushMatrix();
  translate(currentlocation.x, currentlocation.y);
  rotate(angle);
  //rect(0, -5, 50, 10);//draw the cannon
  //rotate(angle-PI/2);
  
  popMatrix();
//--------------------

  pushMatrix();
  translate(currentlocation.x, currentlocation.y);
 // triangle(-50,15,0,-20,70,15);
  shape(tankbody,-60, -60,170,100);
  popMatrix();
  //-------------------
  
  pushMatrix();
  translate(currentlocation.x, currentlocation.y);
  rotate(angle+radians(270));
  shape(cannonarm,-75, -25,150,110);
  
  
  popMatrix();


//------------------------------------------------------------------------
 startinvaders();
startgame();
   gamecheck();
   pausebutton();
   music();

  //------------------------------------------------------------------

}


void mousePressed() {
  
  if (stage!=0)
  {
  
  if(missile[f].isShot == false)
  {
  
   laser = minim.loadSnippet("Lasergun.mp3");
    laser.play();
  println(f, missile[f].isShot);
  shootanimate();
  
  shot = true;
   missile[f].isShot = true;
  PVector force = PVector.fromAngle(angle);
  force.mult(cannonforce); //wave1=12
  missile[f].applyForce(force);
 
  f++;
  if (f>missilenumber-1)
  {
    f=0;
  }
  
  }
  
  }
  
}



void screenTest()
{
  stroke(0);
 line(0, height-155, width, height-155);
};

void bomb()
{
  
  
  for (int i = 0; i < missile.length; i++) {
  if (missile[i].location.y> 330 || missile[i].location.y<0-50 || missile[i].location.x>width+350)
  {
    stroke(255, 0, 0);
    fill(255, 215, 0);
   
    pushMatrix();
    //Bomb Animation
    translate(missile[i].location.x, missile[i].location.y);
    quadraticForm( 24, 50, 25);
    popMatrix();

  
    missile[i] = new CannonBall(currentlocation.x, currentlocation.y);
    shot = false;
    missile[i].isShot = false;
  }
  }
  
  
  
  
 
};

void keyPressed() {
  //add force based on key pressed
  
  println("left control");
    
      
    if (keypress2==1) { //39
      //wave=1=6.5
      currentlocation.x=currentlocation.x-6.5;
      //wheel--;
      tyre.loc.x=tyre.loc.x+6.5;
      
    }
    
    if (keypress==1) {
      currentlocation.x=currentlocation.x+6.5;
      // wheel++;
       tyre.loc.x=tyre.loc.x-6.5;
    }
   
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  if(gamedone!=true&&stage!=0)
  {
  if(key == 32)
    {
      loop();
    }
  }
  
  
    if(gamedone ==true)
  {
  if(key == 114)
    { 
    
      print("restart");
      
       angle = -PI/4;
location = new PVector(45, 330); 
 currentlocation = new PVector(0, 0);
 locationEn = new PVector(200, 220);
 move = new PVector(5, 0);
 shot = false;
 f=0;
 score=0;
 health= 100;
 shield= 100;
 healthbar= 380;
 shieldbar= 380;
 
  gamecomplete = false;
powerused= false;
 powercounter=0;
 powerstart=false;
 gamedone= false;



//int stage=1;
  stage=0;
 shipnumber=5; //5
 missilenumber=10;
 cannonforce=12;
 dropspeed=1;
 cannonscore = 10; //10

//setup(); //------------------------------------------------------------------------------------------------------------------------------------------------------------------

stage = 0;
  
  power = new Powerup(random(0+40,width-40),330); 
  
 for (int f=0; f<missile.length; f++)
  {
    missile[f] = new CannonBall( location.x, location.y);
  }
  
  
  currentlocation.x = location.x;
  currentlocation.y= location.y;
   

  for (int i=0;i<ship.length;i++)
  {
    
    ship[i] = new Target(90,width-30,random(0,260)); //width-30 random(0,260)
    //ship[i] = new Target(90,200,200); //target practice
    nuke[i] = new Enemybomb(locationEn.x, location.y= ship[i].location.y);
    ship[i].randomSpeed();
    
  }
      
  
  tyre = new Wheel();
//-----------------------------------------------------------------------
      
      
       redraw();
     
     
      loop();
      
      
      
      
    }
  }
  
  if (key == CODED) {
    
    
    
    
    if (keyCode == LEFT) {
      //wave=1=6.5
      currentlocation.x=currentlocation.x-6.5;
      //wheel--;
      tyre.loc.x=tyre.loc.x+6.5;
      
    }
    
    if (keyCode == RIGHT) {
      currentlocation.x=currentlocation.x+6.5;
      // wheel++;
       tyre.loc.x=tyre.loc.x-6.5;
    }
    
  }
}


  void restrictTank()
  {
    if (currentlocation.x<0)
    
    {
      currentlocation.x=0;
     
    }
    
    else if (currentlocation.x>width)
    
    {
     
     
      currentlocation.x=width;
    }
  }
  
  
  void shootanimate()
  {
    
  
int radius = 10; //store the radius of 50 ripples
int counter = 35;//keep track of how many ripples have been created
int trans =100;

    
   
    
     //stroke(255,0,0);
    //fill(255,215,0);
   noFill();
   stroke(0,191,255);
   strokeWeight(3);
     pushMatrix();
  //Bomb Animation
 
  
    translate(currentlocation.x, currentlocation.y);
    rotate(angle+0.5);
    //triangle(60,-50,40,-20,80,-10);
  //ellipse(50, -25, 55, 55);
  //-------------------------------------------
  
  for (int i = 0; i< counter; i ++){ //loop through all 50 ripples
 //trans[counter]=255;//set the starting transparency value
 noFill();
 stroke(0,191,255,trans--);
 ellipse(50, -25, radius++, radius++);//draw the ripple

 
 }
  
  
  
  //-----------------------------------------------
  
  
    
    popMatrix();
    
    
  }
  
  
  void gamecheck()
  
  
  {
    if(health<1)
    {
      fill(255,255,255);
      text("GAME OVER",280,height/3);
      text("You didn't destroy enough aliens!",100,height/2);
       text("Press 'R' to continue",200,height-200);
       noLoop();
      println("gameover-----------------------------------------------------");
      gamecomplete=true; 
      gamedone=true;
      
      
      
    }
    
    
  }
  
 
  
  
  
  
  
  
  
  void pausebutton()
  {
    
   // stroke(153);
    //line(width-40, 40, width-20, 40);
    if (mousePressed){
     
      if (mouseX>=width-40 && mouseX<width-20 && mouseY >=20 && mouseY <=40)
 {
   
   noLoop();
   fill(255);
   text("Press space to continue",160,205);
 }

  }
    
  }
  
  
  
  void music()
  {
   
   // stroke(153);
    //line(width-40, 40, width-20, 40);
    if (mousePressed){
     
      if (mouseX>=width-40 && mouseX<width-20 && mouseY >=50 && mouseY <=70)
 {
   
   println("music off");
  //minim.stop();
  shape(musicoff,width-40,50,20,20);

  m++;
  if(m>1)
  {
    m=0;
  }
  if(m==1)
  {
      song.pause();
    
  }
    if(m==0)
  {
      song.loop();
    
  }
 }
 
 
 
 
 
 
 
 

  }
    
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  void startinvaders()
  {
    if(stage==0)
  {
     shape(startscreen,0,0,740,500);
     //fill(255);
     //rect(300,300,117,30);
     //fill(255,0,0);
     //rect(280,350,187,30);
     
     
    
     
      if(mousePressed)
     {
       
       if (mouseX>=300 && mouseX<417 && mouseY >=300 && mouseY <=330)
       {
       
         println("start***********");
         stage=1;
            shape(backg,0,0,740,500);
       }
       
       if (mouseX>=280 && mouseX<467 && mouseY >=350 && mouseY <=380)
       {
         
         println("How to play***********");
         shape(howtoplay,0,0,740,500);
          //image(howtoplay2,0,0,740,500);
        
         
       }
       
      
     }
     
 }
    
    
  }
  
  
  
  
  
 void startgame()
 {
   
 
   
   if(stage==1)
   {
     fill(255);
      text("Wave 1",320,height/3);
      fill(0, 51, 204);
      text("Get ready the aliens are already here!",50,height/2);
      fill(255,255,0);
            text("Press space to continue",170,320);
            missilenumber=6;
            cannonscore=20;
      noLoop();
     if(keyPressed==true)
     {
       stage=2;//2
       loop();
      
     }
   }
  
   if(gamecomplete==true && stage==2)
   {
     score=0;
   fill(255);
      text("Wave 2",320,height/3);
      fill(0, 51, 204);
      text("Get ready there are more aliens this time!",5,height/2);
      fill(255,255,0);
            text("Press space to continue",170,320);
            shipnumber=7;
            missilenumber=7;
            cannonforce=20;
            dropspeed=2;
            cannonscore=10;//10
            
            powerstart=false;
         powercounter=0;
         powerused=false;
         
      noLoop();
      
     if(keyPressed==true&&keyCode==32)
     {
         health=100;
         healthbar=380;
         
         shield=100;
         shieldbar=380;
         
         
       gamecomplete=false;
       stage=3;
      
       loop();
     }
   }
   
   
   if(gamecomplete==true && stage==3)
   {
     score=0;
   fill(255);
      text("Wave 3",320,height/3);
        fill(0, 51, 204);
      text("SAVE THE EARTH!!!",210,height/2);
      fill(255,255,0);
            text("Press space to continue",170,320);
            
            shipnumber=10;
 missilenumber=10;
 cannonforce=40;//40
    dropspeed=4;
    cannonscore=5;
    
    
    powerstart=false;
         powercounter=0;
         powerused=false;
      
      noLoop();
     
     if(keyPressed==true&&keyCode==32)
     {
       health=100;
       healthbar=380;
       
       shield=100;
         shieldbar=380;
         
       gamecomplete=false;
       stage=4;
      
       loop();
     }
   
 
 }
 
 
 
 
    if(gamecomplete==true && stage==4)
   {
//score=0;
    
     fill(255);
     textSize(25);
      text("You destroyed enough aliens to save the earth",40,height/3);
       textSize(30);
      text("You're a Hero!",270,height/2);
      
            text("GAME COMPLETE",240,300);
            
      noLoop();
     
  
 
 }
 
 
 }
 
 
 void leapOnKeyTapGesture(KeyTapGesture g){
  int     id               = g.getId();
  Finger  finger           = g.getFinger();
  PVector position         = g.getPosition();
  PVector direction        = g.getDirection();
  long    duration         = g.getDuration();
  float   durationSeconds  = g.getDurationInSeconds();
  //println("KeyTapGesture: " + id);

  mousePressed=true;
  
  
  //("KeyTapGesture: " + id);
}
 
 
 
 