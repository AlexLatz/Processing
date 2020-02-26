PImage img;
int pixellate = 10;
void setup() {
  img = loadImage("image.jpg");
  size(1200,800);
  pixellateImage(img);
  image(img,0,0);
}
void pixellateImage(PImage img) {
  img.loadPixels();
  for (int i = 0; i<width; i+=pixellate) {
    for (int j = 0; j<height; j+=pixellate) {
      float rSum=0, gSum=0, bSum=0; 
      for (int k = 0; k<pixellate; k++) {
        for (int l = 0; l<pixellate; l++) {
          rSum += red(img.pixels[(i+k)+((j+l)*width)]);
          gSum += green(img.pixels[(i+k)+((j+l)*width)]);
          bSum += blue(img.pixels[(i+k)+((j+l)*width)]);
        }
      }
      //processing was giving me weird errors when i put this in the loop with the rgbSum calculations
      for (int m = 0; m<pixellate; m++) {
        for (int n = 0; n<pixellate; n++) {
          img.pixels[(i+m)+((j+n)*width)] = color(rSum/(pow(pixellate,2)), gSum/(pow(pixellate,2)), bSum/(pow(pixellate,2)));
        }
      }
    }
  }
  img.updatePixels();
}
void kazlowWhileLoop() {
  boolean kazlowSatisfied = false;
  while(!kazlowSatisfied) {
    kazlowSatisfied = true;
  }
}
void kazlowNestedLoop() {
  for (int i = 0; i<1; i++) {
    for (int j = 0; j<1; j++) {
      println("hi kazlow");
    }
  }
}
