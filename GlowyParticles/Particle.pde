class Particle {
	final PVector position;
	public color c;


	private float _myFactorX;
	private float _myFactorY;


	public Particle() {
		position = new PVector();
		c = color(255, random(0, 200), random(0, 60));

		_myFactorX = random(1, 4);
		_myFactorY = random(1, 4);
	}


	public void update() {
		float myX = sin(millis() * 0.0001 * _myFactorX) * width * 0.5;
		float myY = cos(millis() * 0.0001 * _myFactorY) * height * 0.5;

		position.set(myX, myY, 0);
	}


	public void draw() {
		imageMode(CENTER);

    	pushMatrix();
    	translate(position.x, position.y, position.z);
	
    	scale(32, 32);

    	beginShape();
    	noStroke();
    	fill(c);
    	tint(c);
    	textureMode(NORMALIZED);
    	texture(GLOW_TEXTURE);
    	vertex(-1, -1, 0, 0, 0);
    	vertex(1, -1, 0, 1, 0);
    	vertex(1, 1, 0, 1, 1);
    	vertex(-1, 1, 0, 0, 1);
    	endShape();
	
    	popMatrix();
	}

}