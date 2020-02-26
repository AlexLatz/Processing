void setup() {
	size(640,640);
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
void drawPawn(int x, int y, int c) {
  fill(c);
  rect(10+x*80,70+y*80,60,10);
  rect(30+x*80,30+y*80,25,40);
  ellipse(42.5+x*80,20+y*80,40,40);
}
void draw() {
}
