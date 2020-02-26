import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class DrawingWithDots extends PApplet {

int numDots = 500;
float xIncrement = 0.02f, yIncrement = 0.01f;
PImage img;
Dot[] dots = new Dot[numDots];
public void setup() {
  
  img = loadImage("image.jpg");
  noStroke();
  for (int i =0; i<numDots; i++) {
    dots[i] = new Dot(random(width), random(height));
  }
}
public void draw() {
  for (Dot dot : dots) {
    dot.move();
  }
}
class Dot {
  float xNoise,yNoise,xOff,yOff;
  Dot (float xOff, float yOff) {
    xNoise = 0;
    yNoise = 0;
    this.xOff = xOff;
    this.yOff = yOff;
  }
  public void move() {
    xNoise = noise(xOff)*width;
    yNoise = noise(yOff)*height;
    xOff += xIncrement;
    yOff += yIncrement;
    fill(img.get(floor(xNoise), floor(yNoise)));
    circle(xNoise, yNoise, 5);
  }
}
  public void settings() {  size(600,400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "DrawingWithDots" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
