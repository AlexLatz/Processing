color[] colors = {#ef476f, #ffd166, #74fbd7, #44c3ee, #8b79cd, #e9d6ec};
StringList boxText = new StringList();
ArrayList<Integer> order = new ArrayList<Integer>();

void setup() {
    size(1200, 800);
    boxText.append("1");
    boxText.append("2");
    boxText.append("3");
    boxText.append("4");
    boxText.append("5");
    boxText.append("6");
    boxText.shuffle();
}

void draw() {
    background(255, 255, 255);
    strokeWeight(5);
    fill(colors[0]);
    rect(100, 100, 333, 300);
    fill(colors[1]);
    rect(433, 100, 333, 300);
    fill(colors[2]);
    rect(766, 100, 333, 300);
    fill(colors[3]);
    rect(100, 400, 333, 300);
    fill(colors[4]);
    rect(433, 400, 333, 300);
    fill(colors[5]);
    rect(766, 400, 333, 300);
}

void mouseClicked() {
    
}