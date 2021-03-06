color[] colors = {#ef476f, #ffd166, #74fbd7, #44c3ee, #8b79cd, #e9d6ec};
StringList boxText = new StringList();
Box[] boxes = new Box[6];
Simon simon;
boolean gameOver = false;
String finalText;

class Box {
    private String text;
    private color col;
    private boolean chosen, wrong;
    private int x, y;
    public Box(int num, String text, color col, boolean chosen) {
        if (num < 3) this.y = 100;
        else this.y = 400;
        if (num == 0 || num == 3) this.x = 100;
        else if (num == 1 || num == 4) this.x = 433;
        else this.x = 766;
        this.text = text;
        this.col = col;
        this.chosen = chosen;
        this.wrong = false;
    }
    public void draw() {
        strokeWeight(5);
        if (chosen) fill(col);
        else fill(255, 255, 255);
        rect(x, y, 333, 300);
        if (chosen) {
            fill(0);
            textSize(40);
            textAlign(CENTER, CENTER);
            text(text, x, y, 333, 300);
        }
    }
    public void chosen(boolean value) {
        this.chosen = value;
    }
    public boolean isChosen() {
        return this.chosen;
    }
    public void setText(String text) {
        this.text = text;
    }
}

class Simon {
    private Box[] boxes;
    private int current;
    private ArrayList<Integer> order;
    private int timeRendered;
    private boolean playback;
    private int chosen;
    private boolean wait;
    private int waitTime;
    private StringList boxText;
    String finalText;
    public Simon(Box[] boxes, StringList boxText) {
        this.boxes = boxes;
        this.current = 0;
        this.order = new ArrayList<Integer>();
        this.order.add((int)(random(6)));
        this.timeRendered = 0;
        this.playback = true;
        this.chosen = -1;
        this.wait = true;
        this.waitTime = 60;
        this.boxText = boxText;
    }
    public void draw() {
        fill(0);
        //text(waitTime + " " + timeRendered + " " + playback + " " + wait + " " + current + " " + order.get(current) + " " + chosen + " " + second(), 100, 50);
        textAlign(LEFT);
        if (order.size() > boxText.size()) {
            textSize(20);
            text("You've completed your patient interview. You can continue the bonus mode for an additional challenge or click outside of the boxes to leave now.", 100, 30, 1000, 100); 
            textSize(40);
            text("BONUS MODE", 0, 750);
        } else if (order.size() > 8){ 
            textSize(25);
            text("You've completed enough of your interview. Click outside of the boxes if you want to leave now.", 100, 30, 1000, 100);
        }
        if (this.playback && !this.wait) {
            textSize(35);
            textAlign(CENTER);
            text("PLAYING SEQUENCE", 600, 750);
            if (!boxes[order.get(current)].isChosen()) {
                boxes[order.get(current)].chosen(true);
                if (current < boxText.size()) boxes[order.get(current)].setText(boxText.get(current));
                else {
                    boxText.shuffle();
                    boxes[order.get(current)].setText(boxText.get(0));
                }
                timeRendered = 60;
            } else {
                if (timeRendered <= 0) {
                    boxes[order.get(current)].chosen(false);
                    if (current < order.size()-1) current++;
                    else {
                        order.add((int)(random(6)));
                        while (order.get(order.size()-2) == order.get(order.size()-1)) {
                            order.set(order.size()-1, (int)(random(6)));
                        }
                        playback = false;
                        this.current = 0;
                    }
                } else timeRendered--;
            }
        } else if (!this.wait && chosen >= 0) {
            if (timeRendered <= 0) {
                boxes[chosen].chosen(false);
                chosen = -1;
                if (current == order.size()-1) {
                    wait = true;
                    playback = true;
                    for (Box box : boxes) box.chosen(false);
                    current = 0;
                }
            } else timeRendered--;
        } else if (waitTime <= 0) {
            wait = false;
            waitTime = 60;
        } else if (wait) waitTime--;
        else {
            textSize(35);
            textAlign(CENTER);
            text("CHOOSE YOUR MOVE", 600, 750);
        }
        for (Box box : boxes) box.draw();
    }
    public void playerChoose(int num) {
        if (!playback) {
            if (num == order.get(current)) {
                chosen = num;
                for (Box box : boxes) box.chosen(false);
                boxes[num].chosen(true);
                if (current < boxText.size()) boxes[num].setText(boxText.get(current));
                else {
                    boxText.shuffle();
                    boxes[order.get(current)].setText(boxText.get(0));
                }
                current++;
                timeRendered = 60;
            } else {
                boxes[num].draw();
                gameOver = true;
                if (order.size() <= boxText.size()) finalText = "GAME OVER\nYou messed up your bedside manner again! Dr. Bearing is starting to catch on your insincerity, and Dr. Kelekian may never let you graduate from being a fellow at this rate.";
                else finalText = "GAME OVER\nYou completed " + order.size() + " interactions. Great job with your bedside manner! Dr. Kelekian is proud of you for taking on the extra challenge.";
            }
        }
    }
    public String getFinalText() {
        return this.finalText;
    }
}

void setup() {
    size(1200, 800);
    frameRate(60);
    boxText.append("Hello Dr. Bearing.");
    boxText.append("I'm Dr. Posner, clinical fellow working with Dr. Kelekian.");
    boxText.append("Are you ready for your medical interview?");
    boxText.append("How are you feeling today?");
    boxText.append("How is your general health?");
    boxText.append("Do you have any questions?");
    boxText.append("When did you first notice your issue?");
    boxText.append("That's all for your interview.");
    boxText.append("Thank you for helping!");
    boxText.append("I'll be checking in frequently to make sure you're OK.");
    boxText.append("If you need anything, please let me know!");
    for (int i = 0; i < 6; i++) {
        boxes[i] = new Box(i, boxText.get(i), colors[i], false);
    }
    simon = new Simon(boxes, boxText);
}

void draw() {
    textAlign(CENTER, CENTER);
    textSize(40);
    background(255, 255, 255);
    if (gameOver) {
        fill(0);
        text(simon.getFinalText() == null ? finalText : simon.getFinalText(), 0, 0, 1200, 800);
    } else {
        simon.draw();
    }
}

void mousePressed() {
    if (!simon.playback && simon.timeRendered <= 0) {
        if (mouseY < 400 && mouseY > 100) {
            if (mouseX > 100 && mouseX <= 433) {
                simon.playerChoose(0);
            } else if (mouseX > 433 && mouseX <= 766) {
                simon.playerChoose(1);
            } else if (mouseX < 1000) {
                simon.playerChoose(2);
            }
        } else if (mouseY < 700 && mouseY > 400) {
            if (mouseX > 100 && mouseX <= 433) {
                simon.playerChoose(3);
            } else if (mouseX > 433 && mouseX <= 766) {
                simon.playerChoose(4);
            } else if (mouseX < 1000) {
                simon.playerChoose(5);
            }
        } else {
            if (simon.order.size() > simon.boxText.size()) {
                finalText = "YOU WON!\nNice job remembering your clinical manner! Dr. Bearing looks reassured and Dr. Kelekian mentioned that your time as a medical fellow may be over shortly.";
                gameOver = true;
            } else if (simon.order.size() > 8) {
                finalText = "GAME OVER\nYou forgot to say goodbye and thank Dr. Bearing! Dr. Kelekian can't believe you keep messing this up. Your future as a researcher might be impossible if you cannot survive being a medical fellow.";
                gameOver = true;
            }
        }
    }
}