/* Save every nth frame */

int EVERY_NTH_FRAME = 10;

void setup() {
  size(500, 300);
}

void draw() {
  background(60);

  translate(width/2, height/2);
  rotate( second() / 60.0 * TWO_PI); 
  stroke(255);
  line(0, 0, height/2, 0);

  if (frameCount % EVERY_NTH_FRAME == 0) {
    int  savedFrameNumber = frameCount / EVERY_NTH_FRAME;
    String filename = "frame-" + nf(savedFrameNumber, 4, 0) + ".png";
    saveFrame(filename);
  }
}

