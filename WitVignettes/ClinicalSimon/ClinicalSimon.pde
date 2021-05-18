color[] colors = {#ef476f, #ffd166, #74fbd7, #44c3ee, #8b79cd, #e9d6ec};
StringList boxText = new StringList();
Box[] boxes = new Box[6];
Simon simon;

class Box {
    private String text;
    private color col;
    private boolean chosen;
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
    }
    public void draw() {
        strokeWeight(5);
        if (chosen) fill(col);
        else fill(255, 255, 255);
        rect(x, y, 333, 300);
        if (chosen) {
            fill(0);
            text(text, x, y, 333, 300);
        }
    }
    public void wrong() {
        color tmp = col;
        col = #ff0000;
        draw();
        col = tmp;
    }
    public void choose() {
        this.chosen = !this.chosen;
    }
    public boolean isChosen() {
        return this.chosen;
    }
}

class Simon {
    private Box[] boxes;
    private int current;
    private ArrayList<Integer> order;
    private int timeRendered;
    private boolean playback;
    public Simon(Box[] boxes) {
        this.boxes = boxes;
        this.current = 0;
        this.order = new ArrayList<Integer>();
        this.order.add((int)(Math.random()*6));
        this.timeRendered = 0;
        this.playback = false;
    }
    public void draw() {
        if (this.playback) {
            if (!boxes[order.get(current)].isChosen()) {
                boxes[order.get(current)].choose();
                timeRendered = 60;
            } else {
                if (timeRendered <= 0) {
                    boxes[order.get(current)].choose();
                    if (current < order.size()-1) current++;
                    else {
                        order.add((int)(Math.random()*6));
                        playback = false;
                        this.current = 0;
                    }
                } else timeRendered--;
            }
        }
        for (Box box : boxes) box.draw();
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
    simon = new Simon(boxes);
}

void draw() {
    background(255, 255, 255);
    textAlign(CENTER, CENTER);
    textSize(40);
    simon.draw();
}

void mousePressed() {
    if (!simon.playback) simon.playback = true;
    if (mouseY < 400 && mouseY > 100) {
        if (mouseX > 100 && mouseX <= 433) {
            println("topleft");
        } else if (mouseX > 433 && mouseX <= 766) {
            println("topmid");
        } else if (mouseX < 1000) {
            println("topright");
        }
    } else if (mouseY < 700 && mouseY > 400) {
        if (mouseX > 100 && mouseX <= 433) {
            println("botleft");
        } else if (mouseX > 433 && mouseX <= 766) {
            println("botmid");
        } else if (mouseX < 1000) {
            println("botright");
        }
    }
}