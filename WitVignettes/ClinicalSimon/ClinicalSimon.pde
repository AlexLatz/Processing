color[] colors = {#ef476f, #ffd166, #74fbd7, #44c3ee, #8b79cd, #e9d6ec};
StringList boxText = new StringList();
Box[] boxes = new Box[6];
boolean playback = true;
int current = 0;
ArrayList<Integer> order = new ArrayList<Integer>();

class Box {
    private String text;
    private color col;
    private boolean chosen;
    private int x, y;
    private int timeRendered;
    public Box(int num, String text, color col, boolean chosen) {
        if (num < 3) this.y = 100;
        else this.y = 400;
        if (num == 0 || num == 3) this.x = 100;
        else if (num == 1 || num == 4) this.x = 433;
        else this.x = 766;
        this.text = text;
        this.col = col;
        this.chosen = chosen;
        this.timeRendered = 0;
    }
    public void draw() {
        strokeWeight(5);
        if (chosen) fill(col);
        else fill(255, 255, 255);
        rect(x, y, 333, 300);
        if (chosen) {
            fill(0);
            text(text, x, y, 333, 300);
            if (timeRendered > 0) timeRendered--;
            else chosen = false;
        }
    }
    public void wrong() {
        color tmp = col;
        col = #ff0000;
        draw();
        col = tmp;
    }
    public void choose() {
        this.chosen = true;
        this.timeRendered = 60;
    }
    public boolean isChosen() {
        return this.chosen;
    }
}

void setup() {
    size(1200, 800);
    frameRate(60);
    boxText.append("1");
    boxText.append("2");
    boxText.append("3");
    boxText.append("4");
    boxText.append("5");
    boxText.append("6");
    boxText.shuffle();
    for (int i = 0; i < 6; i++) {
        boxes[i] = new Box(i, boxText.get(i), colors[i], false);
    } 
}

void draw() {
    background(255, 255, 255);
    textAlign(CENTER, CENTER);
    textSize(40);
    for (Box box : boxes) box.draw();
    if (current < order.size() && playback) {
        if (boxes[order.get(current)].isChosen()) current++; 
    }
}

void mouseClicked() {
}