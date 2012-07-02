/* Print the current sketch graphics to the default system printer */

import java.awt.print.*;

PrinterJob printJob;  

float dinA4Width = mmToInches(210);
float dinA4Height = mmToInches(297);
float dinA4Margin = mmToInches(4);

PImage kittenImage;

void setup() {
  size(202, 289);  // Same aspect ratio as printable area

  kittenImage = loadImage("kitten.png");
}


void draw() {
  background(51);

  noStroke();
  fill(255, 0, 255);
  rect(0, 0, width * 0.5, height * 0.5);

  image(kittenImage, 0, height * 0.5); 

  noFill();
  stroke(255);
  ellipseMode(CENTER);
  ellipse(width * 0.5, height * 0.5, width, width);

  line(0, 0, width, height);
  line(width, 0, 0, height);
}


void keyPressed() {
  if (key == 'p' || key == 'P') {
    printStage();
  }
}


/* Called by the main code to start a new print job. 
 Probably doesn't need to be threaded. 
 I am afraid that the sketch image won't be what you want to print if the print function would be invoked later...
 */
void printStage() {
  printJob = PrinterJob.getPrinterJob();      // Get a job on the default system printer...
  printJob.setJobName("A postcard from Processing");
  handlePrint();
}



void handlePrint() {

  printJob.setPrintable(new Printable() {
    public int print (java.awt.Graphics pg, PageFormat f, int pageIndex) {

      Paper paperDinA4 = f.getPaper();
      paperDinA4.setSize(dinA4Width, dinA4Height);
      paperDinA4.setImageableArea(dinA4Margin, -dinA4Margin, dinA4Width - dinA4Margin * 2, dinA4Height - dinA4Margin * 2);
      f.setPaper(paperDinA4);

      println("Paper size: " + nf(inchesToMm(f.getWidth()), 0, 2) + "mm x " +  nf(inchesToMm(f.getHeight()), 0, 2) + " mm");
      println("Printable area size: " + nf(inchesToMm(f.getImageableWidth()), 0, 2) + "mm x " +  nf(inchesToMm(f.getImageableHeight()), 0, 2) + " mm");
      println("Printable area top-left: " + nf(inchesToMm(f.getImageableX()), 0, 2) + "mm x " +  nf(inchesToMm(f.getImageableY()), 0, 2) + " mm");


      /* Only one page */
      if(pageIndex == 0) {
        int bitmapScale = 4;
        println("Generating print data for sketch " + width + " x " + height + " px -> " + g.image.getWidth(null) * bitmapScale + " x " + g.image.getHeight(null) * bitmapScale + " px");
        Image thisImage = g.image.getScaledInstance(g.image.getWidth(null) * bitmapScale, g.image.getHeight(null) * bitmapScale, g.image.SCALE_REPLICATE);

        /*  Draws the sketch image onto the page. Squeeeeezes it into the printable area. 
         So it is a good idea to make the sketch the same aspect ratio as your printable area...
         To be honest, this behaves a bit weird... */
        pg.drawImage(thisImage, pg.getClipBounds().x, -pg.getClipBounds().y, pg.getClipBounds().width, pg.getClipBounds().height + pg.getClipBounds().y * 2, null);

        return Printable.PAGE_EXISTS;
      }
      else {
        return NO_SUCH_PAGE;
      }
    }
  }
  );

  try {
    println("Preparing printing...");
    printJob.print();
    println("Print job sent...");
  } 
  catch (PrinterException e) {
    println("Error: Printing failed. Reason: " + e.toString());
  }
}


float mmToInches(double mm) {
  float inches = (float)(mm / 25.4 * 72);
  return inches;
}


float inchesToMm(double inches) {
  float mm = (float)(inches * 25.4 / 72.0);
  return mm;
}
