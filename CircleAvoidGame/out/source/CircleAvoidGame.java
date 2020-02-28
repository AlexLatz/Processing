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

public class CircleAvoidGame extends PApplet {

int numCircles = 30;
boolean gameOver;
ArrayList<FallingCircle> circles = new ArrayList<FallingCircle>();
ArrayList<FallingCircle> toRemove = new ArrayList<FallingCircle>();
public void setup() {
    
    colorMode(HSB);
    gameOver = false;
    noStroke();
    for (int i = 0; i<numCircles; i++) {
        circles.add(new FallingCircle());
    }
}
public void draw() {
    fill(0, 50);
    rect(0,0,500,500);
    fill(0,0,255);
    circle(mouseX, 450, 20);
    moveCircles();
    collision();
}
public void collision() {
    for (FallingCircle circle : circles) {
        if (dist(circle.pos.x, circle.pos.y, mouseX, 450) < 25) {
            gameOver = true;
        }
    }
    if (gameOver) {
        circles.clear();
        toRemove.clear();
        setup();
    }
}
public void moveCircles() {
    for (FallingCircle circle : circles) {
        if (circle.pos.y>500) {
            toRemove.add(circle);
        } else {
            circle.move();
        }
    }
    for (int i = 0; i<toRemove.size(); i++) {
        circles.add(new FallingCircle());
    }
    circles.removeAll(toRemove);
    toRemove.clear();
}
class FallingCircle {
    PVector pos;
    int col;
    int fallSpeed;
    FallingCircle() {
        this.pos = new PVector(random(450)+25,-100);
        this.col = color(random(255),255,255);
        this.fallSpeed = PApplet.parseInt(random(9))+1;
    }
    public void move() {
        this.pos.y += this.fallSpeed;
        fill(this.col);
        circle(this.pos.x,this.pos.y,20);
    }
}
  public void settings() {  size(500,500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CircleAvoidGame" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
