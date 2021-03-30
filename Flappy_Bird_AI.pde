int TOTAL = 250;
int[] layer_sizes = {5, 4, 2};
int maxSpeed = 100;

ArrayList<Bird> birds = new ArrayList<Bird>();
ArrayList<Bird> saved_birds = new ArrayList<Bird>();
ArrayList<Pipe> pipes = new ArrayList<Pipe>();

void setup() {
  background(0);
  for (int i = 0; i < TOTAL; i++) {
    birds.add(new Bird());
  }
  pipes.add(new Pipe());
  fullScreen(1);
}
int speed = 1;
int gen = 1;
void draw() {
  background(0);
  
  for (int k = 0; k < speed; k++) {
    for (Bird b: birds) {
      b.update();
      b.lastCall();
    }
    
    for (int i = 0; i < birds.size(); i++) {
      if (pipes.get(0).touching(birds.get(i).pos, birds.get(i).size) || birds.get(i).pos.y + birds.get(i).size/2 > height || birds.get(i).pos.y - birds.get(i).size/2 < 0) {
        saved_birds.add(new Bird());
        saved_birds.get(saved_birds.size() - 1).copy_bird(birds.get(i));
        birds.remove(i);
      }
    }
    if (birds.size() == 0) {
      next_generation();
      gen++;
    }
    for (Pipe p: pipes) {
      p.update();
    }
    controlSize(pipes);
  }
  
  for (Bird b: birds) {
      b.show();
  }
  for (Pipe p: pipes) {
    p.show();
  }
  showSpeed();
}

void showSpeed() {
  float h = 50;
  float w = 150;
  noStroke();
  fill(0, 144);
  rect(width - w, height - h, w, h);
  
  fill(255);
  textSize(h);
  text("x" + speed, width - w, height);
}

void mousePressed() {
  speed *= 10;
  if (speed > maxSpeed) speed = 1;
}
