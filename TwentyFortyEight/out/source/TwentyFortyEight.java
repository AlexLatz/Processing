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

public class TwentyFortyEight extends PApplet {

int[][] grid = new int[4][4];
public void setup() {
    
    startGame();
}
public void draw() {
    drawGrid();
    showSquares();
}
public void drawGrid(){
    for (int i = 0; i<width; i+=125) {
        for (int j = 0; j<height; j+=125) {
            fill(255);
            rect(i,j,125,125);
        }
    }
}
public void showSquares() {
    for (int x = 0; x<grid.length; x++) {
        for (int y = 0; y<grid[x].length; y++) {
            if (grid[x][y]>0) {
              fill(0);
              textSize(20);
                text(grid[x][y], 60+(125*x), 65+(125*y));
            }
        }
    }
}
public void startGame() {
    grid[3][PApplet.parseInt(random(3))] = 2;
    grid[PApplet.parseInt(random(2))][PApplet.parseInt(random(3))] = 2;
}
public void moveUp() {
    for (int x = 0; x<grid.length; x++) {
        for (int y = 1; y<grid[x].length; y++) {    
            if (grid[x][y-1]>0) {
                grid[x][y-1] += grid[x][y];
            } else if (grid[x][y-2]>0) {
                grid[x][y-2]+=grid[x][y];
            } else if (grid[x][y-3]>0) {
                grid[x][y-3]+=grid[x][y];
            }
            grid[x][y]=0;
        }
    }    
}
public void moveDown() {
    for (int x = 0; x<grid.length; x++) {
        for (int y = 0; y<grid[x].length-1; y++) {    
            grid[x][y+1] += grid[x][y];
            grid[x][y] = 0;
        }
    }    
}
public void moveLeft() {
    for (int x = 1; x<grid.length; x++) {
        for (int y = 0; y<grid[x].length; y++) {    
            grid[x-1][y] += grid[x][y];
            grid[x][y] = 0;
        }
    }    
}
public void moveRight() {
    for (int x = 0; x<grid.length-1; x++) {
        for (int y = 0; y<grid[x].length; y++) {    
            grid[x+1][y] += grid[x][y];
            grid[x][y] = 0;
        }
    }    
}
public void keyPressed() {
    if (keyCode==UP) {
        moveUp();
    } else if (keyCode==LEFT) {
        moveLeft();
    } else if (keyCode==RIGHT) {
        moveRight();
    } else if (keyCode==DOWN) {
        moveDown();
    }

}
  public void settings() {  size(500,500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "TwentyFortyEight" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
