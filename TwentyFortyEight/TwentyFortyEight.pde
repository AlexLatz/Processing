int[][] grid = new int[4][4];
void setup() {
    size(500,500);
    startGame();
}
void draw() {
    drawGrid();
    showSquares();
}
void drawGrid(){
    for (int i = 0; i<width; i+=125) {
        for (int j = 0; j<height; j+=125) {
            fill(255);
            rect(i,j,125,125);
        }
    }
}
void showSquares() {
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
void startGame() {
    grid[3][int(random(3))] = 2;
    grid[int(random(2))][int(random(3))] = 2;
}
void moveUp() {
    for (int x = 0; x<grid.length; x++) {
        for (int y = 1; y<grid[x].length; y++) {    
            grid[x][y-1] += grid[x][y];
            grid[x][y] = 0;
        }
    }    
}
void moveDown() {
    for (int x = 0; x<grid.length; x++) {
        for (int y = 0; y<grid[x].length-1; y++) {    
            grid[x][y+1] += grid[x][y];
            grid[x][y] = 0;
        }
    }    
}
void moveLeft() {
    for (int x = 1; x<grid.length; x++) {
        for (int y = 0; y<grid[x].length; y++) {    
            grid[x-1][y] += grid[x][y];
            grid[x][y] = 0;
        }
    }    
}
void moveRight() {
    for (int x = 0; x<grid.length-1; x++) {
        for (int y = 0; y<grid[x].length; y++) {    
            grid[x+1][y] += grid[x][y];
            grid[x][y] = 0;
        }
    }    
}
void keyPressed() {
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