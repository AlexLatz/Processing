color[] colors = {#ef476f, #ffd166, #74fbd7, #44c3ee, #8b79cd, #e9d6ec};
StringList boxText = new StringList();
Box[] boxes = new Box[6];
Simon simon;
boolean gameOver = false;

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
        if (wrong) fill(#ff0000);
        else if (chosen) fill(col);
        else fill(255, 255, 255);
        rect(x, y, 333, 300);
        if (chosen) {
            fill(0);
            text(text, x, y, 333, 300);
        }
    }
    public void choose() {
        this.chosen = !this.chosen;
    }
    public void wrong() {
        this.wrong = !this.wrong;
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
        textAlign(CENTER, CENTER);
        if (this.playback && !this.wait) {
            if (!boxes[order.get(current)].isChosen()) {
                boxes[order.get(current)].choose();
                if (current < boxText.size()) boxes[order.get(current)].setText(boxText.get(current));
                else boxes[order.get(current)].setText("How are you feeling today?");
                timeRendered = 60;
            } else {
                if (timeRendered <= 0) {
                    boxes[order.get(current)].choose();
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
                boxes[chosen].choose();
                chosen = -1;
                if (current == order.size()-1) {
                    wait = true;
                    playback = true;
                    current = 0;
                }
            } else timeRendered--;
        } else if (waitTime <= 0) {
            wait = false;
            waitTime = 60;
        } else if (wait) waitTime--;
        for (Box box : boxes) box.draw();
    }
    public void playerChoose(int num) {
        if (!playback) {
            if (num == order.get(current)) {
                chosen = num;
                boxes[num].choose();
                if (current < boxText.size()) boxes[num].setText(boxText.get(current));
                else boxes[order.get(current)].setText("How are you feeling today?");
                current++;
                timeRendered = 60;
            } else {
                boxes[num].wrong();
                boxes[num].draw();
                gameOver = true;
                finalText = "GAME OVER\nYou messed up your bedside manner again! Dr. Bearing is starting to catch on your insincerity. She looks lonely as she realizes that you don't actually take the time to care about what she's going through."; 
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
        text(simon.getFinalText(), 0, 0, 1200, 800);
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
        }
    }
}