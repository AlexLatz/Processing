PImage houseImg, sun, lawn, door, window;
void setup() {
  size(600,400);
  houseImg = loadImage("house.jpg");
  sun = loadImage("sun.png");
  lawn = loadImage("lawn.jpg");
  door = loadImage("door.png");
  window = loadImage("window.png");
}
void draw() {
  createOutside();
  buildHouse();
  buildRoof();
}
void createOutside() {
  background(0,0,255);
  image(lawn, 0, 360);
  image(sun, 0,0);
}
void buildHouse() {
  image(houseImg,120,200); 
  image(window, 160, 220);
  image(window, 340, 220);
  image(door, 220, 280);
}
void buildRoof() {
  triangle(120, 200, 480, 200, 300, 0);
}
