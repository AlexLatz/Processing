import processing.sound.*;
SoundFile file;
Amplitude amp;
AudioIn in;
float volume;
void setup() {
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
  size(600,400);
  noStroke();
}
void draw() {
  volume=amp.analyze()+1;
  rect(50,100,50,round(10*volume));
}
