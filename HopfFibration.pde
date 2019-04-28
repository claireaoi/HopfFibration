

//HOPF FIBRATION of 
//for 3-SPHERE (in 4D), projected in 3D
//by Claire Glanois

//INITIALISATION Parameters
float mySaveScale = 300/72;//slightly bigger than A2
int rotx=0; 
int rotz=0;
float offset=0;
int increment;
int radius=2;
float angle1=PI/3; 
float angle2=PI/10;  
float angle3=PI/4; 
float angle4=random(-PI, PI); 
float angle5=random(-PI, PI); 
float angle6=random(-PI, PI);
float pscale1=0.8; float pscale2=1.6; float pscale3=1.8; float pscale4=1; float pscale5=3; float pscale6=2;
int scl = 60; 
int w = 2000; 
int h = 1600; 
float min1=0; float max1=PI; 
float min2=0; float max2=PI; 
float min3=0; float max3=PI;
float min4=random(-PI, PI); 
float max4=min4+random(PI/3, TWO_PI);
float min5=random(-PI, PI); 
float max5=min5+random(PI/4, TWO_PI);
float min6=random(-PI, PI); 
float max6=min6+random(PI/3, TWO_PI);
float mid1=0; float mid2=0; float mid3=0;
color colorback=color(255, 255, 255);
boolean colored=false;
boolean addlayer=false;
boolean record=false;
int col=250;
float angleX= random( PI, -PI);
float angleY= random( PI, -PI);
float angleZ=  random( PI, -PI);
float speedmax=0.2; //max angular speed 
float speedmaxa=0.01; 
float speedmaxb=0.05; 
//Sign for speed.
int signx=-1;int signy=+1; int signz=-1;
int sign1a=-1;int sign1b=+1; int sign2a=+1;
int sign2b=+1; int sign3a=-1;int sign3b=+1; 
float speedX=signx*random(0, +speedmax);//speed max
float speedY=signy*random(0, +speedmax);
float speedZ=signz*random(0, +speedmax);
float speed1a= sign1a*random(0, +speedmaxa);//speed for change in angle 
float speed1b= sign1b*random(0, +speedmaxb);//speed for change in min and max.
float speed2a= sign2a*random(0, +speedmaxa);
float speed2b= sign2b*random(0, +speedmaxb);
float speed3a= sign3a*random(0, +speedmaxa);
float speed3b= sign3b*random(0, +speedmaxb);
float zoom=0;
int npc1=300; int npc2=800; int npc3=500;
int npf1=1600; int npf2=400; int npf3=500;


//INTERACTION: 
//w>for alternate white-black background
//x for alternate color background


void setup() {
  size (1200, 1200, P3D);//
  //size (2384, 1648, P3D);//Size A1 .  
  //pg.createGraphics (1920, 1080);//Case HD would have to use...
  // smooth();
  background(0);
  frameRate(5); //Quite slow as it is
}

void draw() {

  myDrawing(this.g);

  //If want to add other parts in the BACKGROUND
  //pushMatrix();
  //translate(0,0,-600);
  //rotateZ(rotz*PI/10);//comment for sending the right coordinates
  //rotateX(rotx*PI/10);//comment for sending the right coordinates
  //drawArcFibration(this.g, min4, max4, 100, angle4, 1000, false, 4, 1500);
  //drawArcFibration(this.g, min5, max5, 100, angle5, 100, false, 5, 2000);
  //drawArcFibration(this.g, min6, max6, 1000, angle6, 100, false, 6, 2500);
  //popMatrix();

  if (record) {
    saveFrame("HopfFibrs"+frameCount+".tga");
  }
}


//Draw the fibration

void myDrawing(PGraphics pg) {
  pg.background(0);
  pg.translate(width/2, height/2, -200);
  pg.rotateX(-PI/2);
  //pg.rotateX(map(mouseX, -width/2, width/2, -PI, PI));
  pg.rotateY(map(mouseY, -height/2, height/2, -PI, PI));
  pg.stroke(200);
  pg.translate(0, 0, -zoom);


  //angle3=map(mouseX, -width/2, width/2, 9*PI/10, PI);
  //float angle1=PI/3; float angle2=PI/10;  float angle3=PI/4; 
  //np1 is nb point on arc circle, np2 is nb point in fiber f^1(p)
  //drawArcFibration(pg, min1, max1, 300, angle1, 1600, false, 1, 600);
  //drawArcFibration(pg, min2, max2, 800, angle2, 400, false, 2, 600);
  //drawArcFibration(pg, min3, max3, 500, angle3, 500, true, 3,600);


  //Arc 1, the inner one
  drawArcFibration(pg, min1, max1, npc1, angle1, npf1, false, 1, 600);
  //Arc 2, the outer one
  drawArcFibration(pg, min2, max2, npc2, angle2, npf2, false, 2, 600);
  //Arc 3, in the middle
  drawArcFibration(pg, min3, max3, npc3, angle3, npf3, true, 3, 600);
}

//Drawing for one arc- circle

void drawArcFibration(PGraphics pg, float smin, float smax, float ns, float t, float nphi, boolean drawArc, int mod, int scale) {

  float x, y, z, x_, y_, z_; 
  //Moving on an arc circle ('Horizontal' at height z=cos(t), of radius abs(sin(t))) on S2 (radius 1): 

  for (float s=smin; s <= smax; s += TWO_PI/ns) { //Horizontal circle on point on sphere s2: vary phi and vary s.
    // Here are the point coordinates:
    float w1= cos(s) * sin(t);
    float w2= sin(s) * sin(t);
    float w3= cos(t);

    if (drawArc) {
      pg.point(scale * w1, scale * w2, scale * w3);
    }
    
    //Then associate to this point P, its fiber (Circle of points on S3 (4D)), which we project back in 3D (stereographic projection).
    
    for (float phi=0; phi <= TWO_PI; phi += TWO_PI/nphi) {
      float theta=atan(-w1/w2)-phi;
      float alpha=sqrt((1+w3)/2);
      float beta=sqrt((1-w3)/2);
      float w= alpha * cos(theta);
      x_=alpha * sin(theta+TWO_PI/nphi); 
      y_=beta * cos(phi-TWO_PI/nphi); 
      z_= beta * sin(phi-TWO_PI/nphi);
      x= alpha * sin(theta);
      y= beta * cos(phi);
      z= beta * sin(phi);
      float r=acos(w)/PI;
      float mult=scale*r/(sqrt(1-w*w)); //scale factor
      col=255;
      
      //Different modes to render it visually. (Whatever).
      if (mod==1) {
        //stroke(250-(random(1)*50),234-(sin(s)*50),209-(random(s)*70),250-abs(sin(s))*200);
        pg.stroke(col, col, col, 180-abs(sin(s)*sin(phi))*70);
        //pg.strokeWeight(pscale1*abs(sin(s-phi)));
        pg.strokeWeight(pscale1);
      } else if (mod==2) {
        //stroke(250-(random(1)*50),234-(sin(s)*50),209-(sin(s)*70),250-abs(sin(s)*sin(phi))*150);
        pg.stroke(col, col, col, 250-abs(sin(s)*sin(phi))*100);
        pg.strokeWeight(pscale2*abs(sin(s+phi)));
      } else if (mod==3) {
        //stroke(250-(random(1)*50),234-(random(s)+50),209-(sin(s)*70), 250-abs(cos(phi))*200);
        pg.stroke(col, col, col, 200-abs(sin(s-phi))*100);
        pg.strokeWeight(pscale3*abs(cos(s)));
        //pg.strokeWeight(pscale3*abs(cos(s+phi)));
      } else if (mod==5) {//more attenuated, for background
        pg.stroke(200+50*sin(phi), 200+50*sin(phi), 200+50*sin(phi), abs(sin(s))*100);
        pg.strokeWeight(pscale5*abs(cos(s-phi)));
      } else if (mod==4) {
        pg.stroke(200+50*sin(s-phi), 200+50*sin(s-phi), 200+50*sin(s-phi), abs(cos(phi))*100);
        pg.strokeWeight(pscale4*abs(sin(s+phi)));
      } else {
        pg.stroke(200+50*sin(s), 200+50*sin(s), 200+50*sin(s), abs(cos(phi))*100);
        pg.strokeWeight(pscale4*abs(cos(s+phi)));
      }
      
      pg.point(mult*x, mult*y, mult*z);
    }
  }
}


//Mouse Interactions: Reinitialise new figures

void mousePressed() {
  npc1=floor(random(300, 400));  
  npc2=floor(random(800, 1200)); 
  npc3=floor(random(400, 600));
  npf1=floor(random(1500, 1800)); 
  npf2=floor(random(180, 420)); 
  npf3=floor(random(400, 600));

  //For the smaller figure
  angle1=random(PI/2+PI/6, 2*PI/3);
  min1=random(-PI/4, PI/4);
  max1=min1+random(3*PI/4, 4*PI/3);
  //max1= min1+random(PI/3,3*PI/2);

  //For the outer figure
  angle2=random(0, 0.05); 
  min2=random(1, PI);
  max2=min2+PI+random(0, PI/3);
  mid2=(min2+max2)/2;
  //max2=min2+random(PI,PI+PI/3);

  //For the middle figure
  angle3=random(PI/5, PI/3); 
  min3=random(0, PI/4);
  max3=2*mid2-min3;

  sign1a=2*floor(random(0, 2))-1;
  sign1b=2*floor(random(0, 2))-1;
  sign2a=2*floor(random(0, 2))-1;
  sign2b=sign1b;
  sign3a=2*floor(random(0, 2))-1;
  sign3b=sign1b;
}

//Keyboard Interactions: change the min, max of the angle of the circle arch, change the number of points that will draw, etc.

void keyPressed() {
  if (keyCode==UP) {
    rotz++;
  }
  if (keyCode==DOWN) {
    rotx++;
  }
  
  //Save it
  if (key == 's') {
    println("SAVING to test.png");
    PGraphics pg = createGraphics(int(width*mySaveScale), int(height*mySaveScale), P3D);
    pg.beginDraw();
    pg.scale(mySaveScale);
    myDrawing(pg);
    //tga faster store, tiff else
    pg.save("HopfFibr"+frameCount+".tiff");
    pg.endDraw();
  }

//Record it (video)
  if (key=='r') {
    record=!record;
  }
  if (key=='z') {//zoom in
    zoom+=100;
  }
  if (key=='a') {//zoom out
    zoom+=-100;
  }
  
  if (key=='c') {
    addlayer=true;
  }
  
  if (key=='x') {
    colored=!colored;
  }
  
  if (key=='v') { //change size
    pscale1=floor(10*random(1, 3))/10; 
    pscale2=floor(10*random(2, 5))/10; 
    pscale3=floor(10*random(1, 5))/10;
  }
  
  if (key=='b') { //change angle arch
    min4=random(-PI, PI);
    max4=min4+random(PI/4, TWO_PI);
    min5=random(-PI, PI);
    max5=min5+random(PI/4, TWO_PI);
    min6=random(-PI, PI);
    max6=min6+random(PI/4, TWO_PI);
    angle4=random(0, PI);
    angle5=random(0, PI); 
    angle6=random(-PI/4, -TWO_PI); 
    pscale5=floor(10*random(1, 5))/10;
    pscale6=floor(10*random(1, 5))/10;
    pscale4=floor(10*random(1, 5))/10;
  }
}
