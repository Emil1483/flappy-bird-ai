class Network {
  int[] sizes;
  int num_layers;
  double[][][] biases;
  double[][][] weights;
  
  Network(int[] sizes_) {
    sizes = sizes_;
    num_layers = sizes.length;
    
    biases = new double[num_layers][][];
    weights = new double[num_layers][][];
    
    for (int i = 1; i < num_layers; i++) {
      biases[i] = new double[sizes[i]][1];
      biases[i] = randomize_Matrix(biases[i]);
    }
    
    for (int i = 1; i < num_layers; i++) {
      weights[i] = new double[sizes[i]][sizes[i-1]];
      weights[i] = randomize_Matrix(weights[i]);
    }
  }
  
  double[][] feedforward(double[][] a) {
    double[][] x = a;
    for (int i = 1; i < num_layers; i++) {
      x = sigmoid(matrixAdd(matrixDot(weights[i], x), biases[i]));
    }
    return x;
  }
  
  void mutate(float evolve_val) {
    for (int i = 1; i < num_layers; i++) {
      biases[i] = evolve_matrix(biases[i], evolve_val);
    }
    
    for (int i = 1; i < num_layers; i++) {
      weights[i] = evolve_matrix(weights[i], evolve_val);
    }
  }
  
  void copy_brain(Network nn) {
    sizes = nn.sizes;
    num_layers = nn.sizes.length;
    
    biases = new double[num_layers][][];
    weights = new double[num_layers][][];
    
    for (int i = 1; i < num_layers; i++) {
      biases[i] = new double[sizes[i]][1];
      biases[i] = nn.biases[i];
    }
    
    for (int i = 1; i < num_layers; i++) {
      weights[i] = new double[sizes[i]][sizes[i-1]];
      weights[i] = nn.weights[i];
    }
  }
  
  void saveJason(String directory) {
    JSONObject json = new JSONObject();
    for (int i = 1; i < num_layers; i++) {
      for (int j = 0; j < sizes[i]; j++) {
        json.setDouble("biases[" + str(i) + "][" + str(j) + "][0]", biases[i][j][0]);
        for (int k = 0; k < sizes[i - 1]; k++) {
          json.setDouble("weights[" + str(i) + "][" + str(j) + "][" + str(k) + "]", weights[i][j][k]);
        }
      }
    }
    saveJSONObject(json, directory);
  }
  
  void loadJason(String directory) {
    JSONObject json = loadJSONObject(directory);
    for (int i = 1; i < num_layers; i++) {
      for (int j = 0; j < sizes[i]; j++) {
        biases[i][j][0] = json.getDouble("biases[" + str(i) + "][" + str(j) + "][0]");
        for (int k = 0; k < sizes[i - 1]; k++) {
          weights[i][j][k] = json.getDouble("weights[" + str(i) + "][" + str(j) + "][" + str(k) + "]");
        }
      }
    }
  }
}