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

public class Chessboard extends PApplet {

public void setup() {
	
	for(int i = 0; i<width; i+=80) {
		for (int j = 0; j<height; j+=80) {
			if (((j+i)/80)%2==0) {
				fill(139,69,19);
			} else {
				fill(222,184,135);
			}
			rect(i,j,80,80);
		}
	} 
  for (int i = 0; i<8; i++) {
    drawPawn(i,1,0);
    drawPawn(i,6,255);
  }
}
public void drawPawn(int x, int y, int c) {
  fill(c);
  rect(10+x*80,70+y*80,60,10);
  rect(30+x*80,30+y*80,25,40);
  ellipse(42.5f+x*80,20+y*80,40,40);
}
public void draw() {
}
  public void settings() { 	size(640,640); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Chessboard" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
