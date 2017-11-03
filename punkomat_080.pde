int cir = 1000;
int points = 50;

int f = 500;

float distance = 0.0;
float speed = 1;
float objStep = 150;
float angle;

float meshDistortion = 0.05;

PVector[][] circles = new PVector[cir][points];
int[][] randoms = new int[cir][points];
PVector[][] distortion = new PVector[cir][points];
float[] val = {8.23636, 19.09091, 31.75455, 78.79091, 87.83636};

void setup() {
  size(1280,720, P3D);
  //frameRate(10);
  calculateDistortion();
  calculateRandom();

}

void draw() {
   background(255);
   //frameRate(1);
   translate(width/2, height/2);
   rotateZ(frameCount*0.005);
   points();
    changeRandom();
   drawCircle();
   //saveFrame ("img/img####.jpg");
}

void points() {
  if(frameCount % 25 == 0) {
    int rand = (int) random(1, val.length);
    angle = val[rand];
  }
  
  println(angle);
  
  for(int j = 0; j < cir; j++) {
    for(int i = 0; i < points; i++) {
       circles[j][i] = new PVector();
       circles[j][i].x = cos(angle*i*TWO_PI) * f;
       circles[j][i].y = sin(angle*i*TWO_PI) * f;
       circles[j][i].z = j*-100;
     }
  }
}

void calculateDistortion() {
  for(int j = 0; j < cir-1; j++) {
    for(int i = 0; i < points-1; i++) { 
      distortion[j][i] = new PVector();
      distortion[j][i].x = meshDistortion * random(-1, 1);
      distortion[j][i].y = meshDistortion * random(-10, 10);
      distortion[j][i].z = meshDistortion * random(-9, 9);
    }
  }
 }
 
 void calculateRandom() {
  for (int j = 0; j < cir-1; j++) {
    for (int i = 0; i < points-1; i++) { 
      if(i < 1 && i > 80) {
        randoms[j][i] = (int) random(0, 1);
      } else {
        randoms[j][i] = (int) random(0, 2);
      }
    }
  }
}

void changeRandom() {
  for(int i = 0; i < 500; i++) {
    int randX = (int)random(0, cir-1);
    int randY = (int)random(0, points-1);
    if(randoms[randX][randY] == 0) {
      randoms[randX][randY] = 1;
    } else {
       randoms[randX][randY] = 0;
    }
  }
}


void drawCircle() {
  for(float depth = 0; depth > -1500; depth -= objStep){
    float move = depth + distance;
    translate(0, 0, move);
  }
  distance += speed;
  
  for(int j = 0; j < cir-1; j++) {
      beginShape(QUAD_STRIP);
      fill(0);
      stroke(255);
      strokeWeight(0.6);
      for(int i = 0; i < points-1; i++) {
        if(randoms[j][i]==0) {
          vertex(circles[j][i].x + distortion[j][i].x, circles[j][i].y + distortion[j][i].y, circles[j][i].z + distortion[j][i].z);
          vertex(circles[j+1][i].x + distortion[j][i].x, circles[j+1][i].y + distortion[j][i].y, circles[j+1][i].z + distortion[j][i].z);
        }  
    }
      endShape();
    }
    
      for(int j = 0; j < cir-1; j++) {
      beginShape(QUAD_STRIP);
      //noFill();
      stroke(255);
      strokeWeight(0.6);
      for(int i = 0; i < points-1; i++) {
        //if(randoms[j][i]==0) {
          vertex(circles[j][i].x + distortion[j][i].x, circles[j][i].y + distortion[j][i].y, circles[j][i].z + distortion[j][i].z);
          vertex(circles[j+1][i].x + distortion[j][i].x, circles[j+1][i].y + distortion[j][i].y, circles[j+1][i].z + distortion[j][i].z);
        //}  
    }
      endShape();
    }
}