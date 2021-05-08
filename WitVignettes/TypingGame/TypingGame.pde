int letter = 0;
int line = 0;
double chars = 0;
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
    textSize(42);
    text(typing[line], 100, 200);
    for (int i = line+1; i < typing.length; i++) {
        text(typing[i], 100, 250+(50*(i-(line+1))));
    }

    fill(0, 0, 0);
    for (int i = line-1; i >= 0; i--) {
        text(typing[i], 100, 150+(50*(i-(line-1))));
    }
    text(typing[line].substring(0, letter), 100, 200);
    if (done) {
        text("WPM: " + (chars/5)/(endTime/60000.0), 0, 100);
    }
}
void keyPressed() {
    if (letter < typing[line].length()) {
        if (key == typing[line].charAt(letter)) letter++; 
    } else if (letter == typing[line].length()) {
        if (line == typing.length-1 && !done) {
            endTime = millis()-startTime;
            done = true;
        } else if (key == ENTER || key == RETURN) {
            chars += letter;
            letter = 0;
            line++;
        }
    }
}
