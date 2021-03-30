void next_generation() {
  load_fitness();
  
  for (int i = 0; i < TOTAL; i++) {
    Network brain_temp =  new Network(layer_sizes); 
    brain_temp.copy_brain(saved_birds.get(pick_one_brain()).brain);
    brain_temp.mutate(0.01);
    birds.add(new Bird(brain_temp));
    
  }
  
  
  for (int i = pipes.size() - 1; i >= 0; i--) {
    pipes.remove(i);
  }
  pipes.add(new Pipe());
  
  for (int i = TOTAL - 1; i >= 0; i--) {
    saved_birds.remove(i);
  }
}

int pick_one_brain() {
  
  int index = 0;
  double r = random(1);
  while(r > 0) {
    r = r - saved_birds.get(index).fitness;
    index += 1;
  }
  index -= 1;

  return index;
}

void load_fitness() {
  float sum = 0;
  for (int i = 0; i < TOTAL; i++) {
    sum += saved_birds.get(i).score;
  }
  for (int i = 0; i < TOTAL; i++) {
    saved_birds.get(i).fitness = (saved_birds.get(i).score) / sum;
  }
  for (int i = 0; i < TOTAL; i++) {
  }
}
