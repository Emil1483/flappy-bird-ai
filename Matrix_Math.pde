double e = 2.71828182846;

void matrixPrintln(double[][] a) {
  for (int i = 0; i < a.length; i++) {
    println("");
    for (int j = 0; j < a[i].length; j++) {
      print(a[i][j] + "   ");
    }
  }
}

double[][] round_matrix(double[][] a) {
  double[][] x = a;
  for (int i = 0; i < x.length; i++) {
    for (int j = 0; j < x[i].length; j++) {
      x[i][j] = round((float)x[i][j]);
    }
  }
  return x;
}

boolean is_matrixs_equal(double[][] a, double[][] b) {
  boolean x = true;
  for (int i = 0; i < a.length; i++) {
    for (int j = 0; j < a[i].length; j++) {
      if (a[i][j] != b[i][j]) {
        x = false;
      }
    }
  }
  return x;
}

double[][] vector_to_matrix(double[] a) {
  double[][] x = new double[a.length][1];
  for (int i = 0; i < x.length; i++) {
    x[i][0] = a[i];
  }
  return x;
}

int[] load_biggest_activation(double[][] a) {
  double record = 0;
  int[] index = new int[2];
  for (int i = 0; i < a.length; i++) {
    for (int j = 0; j < a[0].length; j++) {
      if (a[i][j] > record) {
        record = a[i][j];
        index[0] = i;
        index[1] = j;
      }
    }
  }
  return index;
}

double[][] transpose(double[][] a) {
  double[][] x = new double[a[0].length][a.length];
  for (int i = 0; i < x.length; i++) {
    for (int j = 0; j < x[i].length; j++) {
      x[i][j] = a[j][i];
    }
  }
  return x;
}

double[][] sigmoid(double[][] a) {
  double[][] x = new double[a.length][a[0].length];
  for (int i = 0; i < x.length; i++) {
    for (int j = 0; j < x[i].length; j++) {
      x[i][j] = 1 / (1 + pow((float)e, (float)-a[i][j]));
    }
  }
  return x;
}

double[][] matrix_shape(int a, int b, double val) {
  double[][] x = new double[a][b];
  for (int i_ = 0; i_ < a; i_++) {
    for (int j_ = 0; j_ < b; j_++) {
      x[i_][j_] = val;
    }
  }
  return x;
}

double[][] matrixMult(double[][] a, double b) {
  double[][] x = new double[a.length][a[0].length];
  for (int i = 0; i < x.length; i++) {
    for (int j = 0; j < x[i].length; j++) {
      x[i][j] = a[i][j] * b;
    }
  }
  return x;
}

double[][] matrixAdd(double[][] a, double[][] b) {
  double[][] x = new double[a.length][a[0].length];
  for (int i = 0; i < x.length; i++) {
    for (int j = 0; j < x[i].length; j++) {
      x[i][j] = a[i][j] + b[i][j];
    }
  }
  return x;
}

double[][] matrixSub(double[][] a, double[][] b) {
  double[][] x = matrixAdd(a, matrixMult(b, -1));
  return x;
}

double[][] sigmoid_prime(double[][] a) {
  double[][] x = hadamard(sigmoid(a),(matrixSub(matrix_shape(a.length, a[0].length, 1),sigmoid(a))));
  return x;
}

double[][] hadamard(double[][] a, double[][] b) {
  double[][] x = new double[a.length][a[0].length];
  for (int i = 0; i < a.length; i++) {
    for (int j = 0; j < a[i].length; j++) {
      x[i][j] = a[i][j] * b[i][j];
    }
  }
  return x;
}

double[][] evolve_matrix(double[][] a, float prob) {
  double[][] x = new double[a.length][a[0].length];
  for (int i = 0; i < x.length; i++) {
    for (int j = 0; j < x[i].length; j++) {
      if (random(1) < prob) {
        x[i][j] = random(-1, 1);
      } else {
        x[i][j] = a[i][j];
      }
    }
  }
  return(x);
}

double[][] randomize_Matrix(double[][] a) {
  double[][] x = new double[a.length][a[0].length];
  for (int i = 0; i < x.length; i++) {
    for (int j = 0; j < x[i].length; j++) {
      x[i][j] = random(-1, 1);
    }
  }
  return(x);
}

double[][] matrixDot(double[][] a, double[][] b) {
  double[][] x = new double[a.length][b[0].length];
  
  for (int i = 0; i < x.length; i++) {
    for (int j = 0; j < x[0].length; j++) {
      double temp = 0;
      for (int k = 0; k < a[0].length; k++) {
        temp += a[i][k] * b[k][j];
      }
      x[i][j] = temp;
    }
  }
  return x;
}

double[][][] shuffle_threeD(double[][][] a) {
  double[][][] x = a;
  for (int i = 0; i < a.length; i++) {
    int randIndex = round(random(x.length-1));
    double[][] choosen = x[randIndex];
    for (int j = randIndex-1; j >= 0; j--) {
      x[j+1] = x[j];
    }
    x[0] = choosen;
  }
  return x;
}