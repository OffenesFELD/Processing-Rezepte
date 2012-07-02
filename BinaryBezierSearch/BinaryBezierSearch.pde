/* Does a binary search on a bezier curve, to find the x value for a given y value without actually solving the equation for the curve */

PVector p1;
PVector h1;
PVector h2;
PVector p2;

void setup() {
  size(600, 600);
  frameRate(30);

  p1 = new PVector(10, 30);
  h1 = new PVector(10, 30);

  h2 = new PVector(300, 400);
  p2 = new PVector(400, 400);
}


void draw() {
  background(23);
  stroke(255);
  noFill();
  bezier(p1.x, p1.y, h1.x, h1.y, h2.x, h2.y, p2.x, p2.y);

  // bezierPoint(a, b, c, d, t)

  float myPerc = map(mouseX, p1.x, p2.x, 0, 1);
  PVector myP = bp(p1, h1, h2, p2, myPerc);
  ellipseMode(CENTER);
  ellipse(myP.x, myP.y, 5, 5);

  for (int i = 0; i < 100000; i++) {
    PVector myP2 = bp2(p1, h1, h2, p2, mouseX);
  }
  PVector myP2 = bp2(p1, h1, h2, p2, mouseX);

  ellipseMode(CENTER);
  ellipse(myP2.x, myP2.y, 5, 5);

  stroke(255, 0, 53);
  line(mouseX, 0, mouseX, height);
}


PVector bp(PVector theP1, PVector theH1, PVector theH2, PVector theP2, float theT) {
  final float myX = bzp(theP1.x, theH1.x, theH2.x, theP2.x, theT); 
  final float myY = bzp(theP1.y, theH1.y, theH2.y, theP2.y, theT); 

  return new PVector(myX, myY);
}


PVector bp2(PVector theP1, PVector theH1, PVector theH2, PVector theP2, float theX) {
  float myTolerance = 0.01;
  int myMaxCount = 10;

  theX = constrain(theX, theP1.x, theP2.x);

  float myLower= 0;
  float myUpper = 1;
  float myT = 0.5;


  float myX = bzp(theP1.x, theH1.x, theH2.x, theP2.x, myT);
  int myCount = 0;
  while (abs (myX - theX) > myTolerance && myCount < myMaxCount) {
    if ( myX < theX) {
      myLower = myT;
    } 
    else {
      myUpper = myT;
    }

    myT = (myUpper + myLower) * 0.5;

    myX = bzp(theP1.x, theH1.x, theH2.x, theP2.x, myT);

    myCount++;
  } 

  float myY = bzp(theP1.y, theH1.y, theH2.y, theP2.y, myT);

  return new PVector(myX, myY);
}


static float bzp(float a, float b, float c, float d, float t) {
  float t1 = 1.0f - t;
  return a*t1*t1*t1 + 3*b*t*t1*t1 + 3*c*t*t*t1 + d*t*t*t;
}


