/* The old-school CPU way to do particles with additive blending */

import processing.opengl.*;
import javax.media.opengl.*;

PGraphicsOpenGL pgl;
GL gl;

ArrayList<Particle> particles;

PImage GLOW_TEXTURE;


void setup(){
    size(600, 600, OPENGL);

    hint(ENABLE_OPENGL_4X_SMOOTH);

    GLOW_TEXTURE = loadImage("glow.png"); // only load the texture once


    pgl = (PGraphicsOpenGL)g;
    gl = pgl.gl;

    /* Turn on sync on vblank */
    gl.setSwapInterval(1);


    particles = new ArrayList<Particle>();

    for(int i = 0; i < 300; i++) {
        particles.add(new Particle());
    }
}


void draw(){

    background(0);

    translate(width/2, height/2);

    /* Enable additive blending */
    pgl.beginGL();
    
    gl.glDepthMask(false);    // do not write to the depth buffer
    
    gl.glEnable(GL.GL_BLEND);
    gl.glBlendFunc(GL.GL_ONE, GL.GL_ONE);
  
    pgl.endGL();


    /* Draw shiny stuff */
    fill(255, 0, 0);
    for (Particle myParticle:particles) {
        myParticle.update();
        myParticle.draw();
    }

    /* Disable additibe blending */
    pgl.beginGL();

    gl.glDepthMask(true);
    gl.glBlendFunc(GL.GL_SRC_ALPHA, GL.GL_ONE_MINUS_SRC_ALPHA);

    pgl.endGL();
}

