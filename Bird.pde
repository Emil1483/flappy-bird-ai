class Bird {
  PVector vel;
  PVector acc;
  PVector pos;
  
  float score = 0;
  float fitness = 0;
  
  float size = 80;
  
  PVector jumpVel = new PVector(0, -15); 
  PVector gravity = new PVector(0, 0.8);
  
  Network brain;
  
  Bird() {
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    pos = new PVector(200, height/2);
    brain = new Network(layer_sizes);
  }
  
  Bird(Network brain_) {
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    pos = new PVector(200, height/2);
    brain = brain_;
  }
  
  int find_pipe() {
    int x = 0;
    if (pipes.get(0).x + pipes.get(0).w < pos.x - size/2) {
      x = 1;
    }
    return x;
  }
  
  double[][] load_inputs() {
    double[][] x = new double[layer_sizes[0]][1];
    int pipes_index = find_pipe();
    x[0][0] = pos.y / height;
    x[1][0] = pipes.get(pipes_index).x / width;
    x[2][0] = pipes.get(pipes_index).yDown / height;
    x[3][0] = pipes.get(pipes_index).yUp / height;
    x[4][0] = (vel.y) / 25;
    return x;
  }
  
  void think() {
    double[][] inputs = load_inputs();
    double[][] output = brain.feedforward(inputs);
    if (output[0][0] > output[1][0]) {
      jump();
    }
  }
  
  void applyForce(PVector f) {
    acc.add(f);
  }
  
  void edges() {
    if(pos.y + size/2 >= height) {
      pos.y = height - size/2;
      vel.mult(0);
    }
    if (pos.y - size/2 <= 0) {
      pos.y = size/2;
      vel.mult(0);
    }
  }
  
  void jump() {
    vel.set(jumpVel);
  }
  
  void update() {
    think();
    score += 1;
    applyForce(gravity);
    vel.add(acc);
    pos.add(vel);
    //edges();
  }
  
  void lastCall() {
    acc.mult(0);
  }
  
  void copy_bird(Bird b) {
    brain = b.brain;
    score = b.score;
  }
  
  void show() {
    fill(255, 100);
    stroke(255);
    rect(pos.x - size/2, pos.y - size/2, size, size);
  }
}
