int letter = 0;
int line = 0;
double chars = 0;
double wpm;
int startTime = millis();
String[] typing;
double endTime;
boolean done = false;
void setup() {
    size(1200,800);
    typing = loadStrings("flea.txt");
}
void draw() {
    background(255, 255, 255);
    fill(100, 75);
    textSize(38);
    text(typing[line], 200, 200);
    for (int i = line+1; i < typing.length; i++) {
        text(typing[i], 200, 250+(50*(i-(line+1))));
    }
    if (!done) wpm = (chars/5)/((millis()-startTime)/60000.0);
    fill(0, 0, 0);
    text("WPM:", 10, 50);
    text((int)wpm, 25, 100);
    for (int i = line-1; i >= 0; i--) {
        text(typing[i], 200, 150+(50*(i-(line-1))));
    }
    text(typing[line].substring(0, letter), 200, 200);
}
void keyPressed() {
    if (letter < typing[line].length()) {
        if (key == typing[line].charAt(letter)) {
            letter++; 
            chars++;
        }
    } else if (letter == typing[line].length()) {
        if (line == typing.length-1 && !done) {
            endTime = millis()-startTime;
            done = true;
        } else if (key == ENTER || key == RETURN) {
            letter = 0;
            line++;
        }
    }
}
