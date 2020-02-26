int numDots = 500;
float xIncrement = 0.02, yIncrement = 0.01;
PImage img;
Dot[] dots = new Dot[numDots];
void setup() {
  size(600,400);
  img = loadImage("image.jpg");
  noStroke();
  for (int i =0; i<numDots; i++) {
    dots[i] = new Dot(random(width), random(height));
  }
}
void draw() {
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
  void move() {
    xNoise = noise(xOff)*width;
    yNoise = noise(yOff)*height;
    xOff += xIncrement;
    yOff += yIncrement;
    fill(img.get(floor(xNoise), floor(yNoise)));
    circle(xNoise, yNoise, 5);
  }
}
