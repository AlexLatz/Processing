double cookies;
PImage cookie;
PVector cookieSize, cookieVelocity;
void setup() {
  size(600,400);
  cookie = loadImage("cookie.png");
  cookieSize = new PVector(0,0);
  cookieVelocity = new PVector(0,0);
}
void draw() {
  background(31,255,249);
  fill(0);
  textSize(24);
  text("Cookies: " + cookies, 0, 25);
  image(cookie, 225, 125);
}
void mouseClicked() {
  if (mouseX<375 && mouseX>225 && mouseY>125 && mouseY<275) {
    cookies++;
    cookieVelocity.x+=5;
    cookieVelocity.y+=5;
  }
}
