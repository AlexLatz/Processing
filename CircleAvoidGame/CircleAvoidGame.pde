int numCircles = 30;
boolean gameOver;
ArrayList<FallingCircle> circles = new ArrayList<FallingCircle>();
ArrayList<FallingCircle> toRemove = new ArrayList<FallingCircle>();
void setup() {
    size(500,500);
    colorMode(HSB);
    gameOver = false;
    noStroke();
    for (int i = 0; i<numCircles; i++) {
        circles.add(new FallingCircle());
    }
}
void draw() {
    fill(0, 50);
    rect(0,0,500,500);
    fill(0,0,255);
    circle(mouseX, 450, 20);
    moveCircles();
    collision();
}
void collision() {
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
void moveCircles() {
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
    color col;
    int fallSpeed;
    FallingCircle() {
        this.pos = new PVector(random(450)+25,-100);
        this.col = color(random(255),255,255);
        this.fallSpeed = int(random(9))+1;
    }
    void move() {
        this.pos.y += this.fallSpeed;
        fill(this.col);
        circle(this.pos.x,this.pos.y,20);
    }
}