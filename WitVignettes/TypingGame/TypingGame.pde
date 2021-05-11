int letter = 0;
int line = 0;
String[] typing;
String[] poems = {"flea.txt", "sunrising.txt", "deathbenot.txt", "valediction.txt"};

double chars = 0;
double wpm;
int startTime;
double endTime;
boolean done = false;

double errors;
int errorPercent;
boolean errored = false;
int errorFrames = 0;

String[] response;
char grade;

color background = #f2e9e4;
color typed = #22223b;
color toType = #747c92;
color error = #c83e4d;

void setup() {
    size(1200,800);
    typing = loadStrings(poems[(int)(Math.random()*poems.length)]);
}

void draw() {
    background(background);
    if (!done) {
        fill(toType);
        textSize(38);
        text(typing[line], 200, 200);
        for (int i = line+1; i < typing.length; i++) {
            text(typing[i], 200, 250+(50*(i-(line+1))));
        }
        wpm = (chars/5)/((millis()-startTime)/60000.0);
        if (chars > 0) errorPercent = (int) ((1.0 - (errors/chars))*100);
        fill(typed);
        for (int i = line-1; i >= 0; i--) {
            text(typing[i], 200, 150+(50*(i-(line-1))));
        }
        if (errorFrames > 0) {
            fill(error);
            errorFrames--;
        }
        text(typing[line].substring(0, letter), 200, 200);
    } else {
        if (response == null) {
            if (wpm + errorPercent < 100) {
                response = new String[]{"Your command of detail is abysmal. You can excuse yourself", "from this class, this department, and this university.", "Do not think for a minute that I will tolerate anything otherwise."};
                grade = 'F';
            } else if (wpm + errorPercent < 140) {
                response = new String[]{"Donne\'s wit is... a way to see how good you really are,", "and you have practically floundered.", "What does that say about you?"};
                grade = 'D';
            } else if (wpm + errorPercent < 160) {
                response = new String[]{"How have you managed to be so overwhelmingly mediocre?", "Unlike Donne, you and your hopes and dreams",  "shall fade into insignificance."};
                grade = 'C';
            } else if (wpm + errorPercent < 180) {
                response = new String[]{"You have the seed of a perspicacious insight,", "yet you cannot bring it to light. I will not miss", "your undergraduate banality in this course."};
                grade = 'B';
            } else {
                response = new String[]{"Your command of wit is adequate for this course.", "I hope you will continue your studies of John Donne."};
                grade = 'A';
            }
        }
        textAlign(CENTER);
        for (int i = 0; i < response.length; i++) {
            text(response[i], 600, 300+(50*i));
        }
        text("Grade: " + grade, 500, 100);
    }
    textAlign(LEFT);
    fill(typed);
    text("WPM:", 10, 50);
    text((int)wpm, 25, 100);
    text("Accuracy:", 10, 150);
    text(errorPercent + "%", 25, 200);
}

void keyPressed() {
    if (letter == 0 && line == 0) startTime = millis();
    if (letter < typing[line].length()) {
        if (key == typing[line].charAt(letter)) {
            letter++; 
            chars++;
            errored = false;
        } else if (!errored) {
            errorFrames = 10;
            errors++;
            errored = true;
        } else errorFrames = 10;
    } else if (letter == typing[line].length()) {
        if (line == typing.length-1 && !done) {
            endTime = millis()-startTime;
            done = true;
        } else if (key == ENTER || key == RETURN) {
            letter = 0;
            line++;
            errored = false;
        } else if (!errored) {
            errorFrames = 10;
            errors++;
            errored = true;
        } else errorFrames = 10;
    }
}
