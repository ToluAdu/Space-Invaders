void quadraticForm(int limbs, float controlRadius, float limbRadius) {
 float theta = 0;
 beginShape();
 float cx = 0; //control x
 float cy = 0;//control y
 float ax = 0;//anchor point x
 float ay = 0;//anchor point y
 float rot = TWO_PI/(limbs*2); //rotation
 //quadColor = 

 for (int i=0; i<=limbs; i++) {
   
   cx = cos(theta)*controlRadius;
 cy = sin(theta)*controlRadius;
 theta += rot;
 ax = cos(theta)*limbRadius;
 ay = sin(theta)*limbRadius;

 if (i==0) {
 // initial vertex required for quadraticVertex()
 vertex(ax, ay);
 }

 else {
 quadraticVertex(cx, cy, ax, ay);
 }
 theta += rot;
 }

 endShape();
 
} 