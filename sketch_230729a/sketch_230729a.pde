import processing.video.*;

int sizeText = 5;
PImage img;
PGraphics pg;

String alphabet = "abcdefghigklmnopqrstuvwxyz0123456789".toUpperCase();
boolean inverted = true;

Agent[] agents ;


Capture cam;

void setup() {
  size(640, 480);
  textSize(sizeText);
  textAlign(CENTER);
  fill(0, 255, 0);

  agents = new Agent[width/sizeText];
  for (int i=0; i<agents.length; ++i) {
    agents[i] = new Agent();
    agents[i].x = (i+1) * sizeText - sizeText/2;
    agents[i].y = random(0, height/sizeText) * sizeText;
  }
  pg = createGraphics(width, height);


  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    // The camera can be initialized directly using an
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();
  }
}

void draw() {
  //background(0);

  if (cam.available()) {
    cam.read();
    if (inverted) {
      cam.loadPixels();
      for (int i=0; i<height; ++i) {
        for (int j=0; j<width; ++j) {
          int loc = i*width + j;
          cam.pixels[loc] = 255 - cam.pixels[loc];
        }
      }
      cam.updatePixels();
    }
  }

  pg.beginDraw();
  for (int i=0; i<agents.length; ++i) {
    agents[i].display();
    agents[i].step();
  }
  pg.mask(cam);
  pg.endDraw();
  image(pg, 0, 0);
}
