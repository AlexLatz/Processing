PImage carImg,cactus;
float cactusDist, gravity = 0.5, difficulty = 8;
boolean cactusAlive, up, gameOver;
Car car;
float score;
class Car {
  PVector position;
  PVector velocity;
  float jumpSpeed;
}
void setup() {
  carImg = loadImage("car.png");
  cactus = loadImage("cactus.png");
  cactusDist = 1100;
  cactusAlive = true;
  up = false;
  size(1200,800);
  car = new Car();
  car.position = new PVector(0, 640);
  car.velocity = new PVector(0, 0);
  car.jumpSpeed = 20;
}
void draw() {
  background(135,206,235);
  fill(245,242,151);
  rect(0,750,1200,50);
  image(cactus, cactusDist, 580);
  fill(0);
  textSize(32);
  text("Score: " + floor(score), 1000, 30);
  if (cactusDist<350 && car.position.y>520) gameOver = true;
  if (!gameOver) {
    updateCar();
    updateCactus();
    score+=0.01;
    difficulty += 0.01;
  } else {
    text("Game Over", 500, 400);
    if (up) {
      score = 0;
      difficulty = 8;
      cactusDist = 1300;
      gameOver = false;
    }
  } 
}
void updateCar() {
  if (car.position.y < 640) car.velocity.y += gravity;
  else car.velocity.y = 0; 
  if (car.position.y >= 640 && up) car.velocity.y = -car.jumpSpeed;
  car.position.add(car.velocity);
  translate(car.position.x, car.position.y);
  image(carImg, 0, 0);
}
void updateCactus() {
  if (cactusDist<-100) cactusAlive = false;
  if (!cactusAlive) {
    cactusDist = 1200;
    cactusAlive = true;
  }
  cactusDist-=difficulty;
}
void keyPressed() {
  if (keyCode == UP) up = true;
}
void keyReleased() {
  if (keyCode == UP) up = false;
}
