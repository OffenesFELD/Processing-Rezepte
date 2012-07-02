/* How to interface with a Posital rotary encoder, like the OPTOCODE with Industrial Ethernet */

PositalRotaryEncoder encoder;

void setup() {
  encoder = new PositalRotaryEncoder(8192, "10.10.10.10", 5000); // Resolution (steps),  IP, port 
  frameRate(45);
  //noLoop();
}


void draw() {
  encoder.query();
  println( "Position: " + encoder.rawPosition()  + " steps   " + encoder.rotation() + " radians");
}


