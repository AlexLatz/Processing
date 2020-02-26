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

public class RainbowDots extends PApplet {

int numDots = 100;
float xincrement = 0.01f;
float yincrement = 0.02f;
Dot[] dots = new Dot[numDots];
public void setup() {
  
  background(0);
  noStroke();
  for (int i=0; i<numDots; i++) {
    dots[i] = new Dot(random(width), random(height));
  }
}
public void draw() {
  fill(0, 10);
  rect(0, 0, width, height);
  for (Dot dot : dots) {
    dot.move();
  }
}
class Dot {
  float xNoise, yNoise, xOff, yOff;
  int[] dotColor = new int[3];
  boolean reverse;
  Dot(float xOff, float yOff) {
    xNoise = 0;
    yNoise = 0;
    reverse = false;
    for (int i = 0; i<3; i++) dotColor[i] = floor(random(255));
    this.xOff = xOff;
    this.yOff = yOff;
  }
  public void move() {
    xNoise = noise(xOff)*width;
    xOff += xincrement;
    yNoise = noise(yOff)*height;
    yOff += yincrement;
    for (int i =0; i<3; i++) {
      if (reverse) dotColor[i] -= random(2);
      if (!reverse) dotColor[i] += random(2);
      if (dotColor[i]>255) reverse = true;
      if (dotColor[i]<0) reverse = false;
    }
    fill(color(dotColor[0], dotColor[1], dotColor[2]));
    circle(xNoise, yNoise, 20);
  }
}
  public void settings() {  size(640, 360); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "RainbowDots" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
