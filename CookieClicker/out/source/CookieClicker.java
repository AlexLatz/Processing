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

public class CookieClicker extends PApplet {

double cookies;
PImage cookie;
PVector cookieSize, cookieVelocity;
public void setup() {
  
  cookie = loadImage("cookie.png");
  cookieSize = new PVector(0,0);
  cookieVelocity = new PVector(0,0);
}
public void draw() {
  background(31,255,249);
  fill(0);
  textSize(24);
  text("Cookies: " + cookies, 0, 25);
  image(cookie, 225, 125);
}
public void mouseClicked() {
  if (mouseX<375 && mouseX>225 && mouseY>125 && mouseY<275) {
    cookies++;
    cookieVelocity.x+=5;
    cookieVelocity.y+=5;
  }
}
  public void settings() {  size(600,400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CookieClicker" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
