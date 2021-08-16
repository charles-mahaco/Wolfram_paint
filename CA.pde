class CA {
  int[] cells;
  int generation;
  int scl;
  int[] prevcells;
  int[][] memory;
  int[] prevprevcells;
  int[] rules;
  int mem;
  int step = 3;
  int solid[];
  float solid2[];
  int trans[];
  float trans2[];
  int pos_x[];
  int pos_y[];
  int cell_anim[][];
  int it_col;
  float col;
  int step_col;
  int mode;
  int indice;
  int b_size;
  float time = 4;
  
  CA(int[] r) {
    rules = r;
    scl = 4;
    mem = 2;
    b_size = 6;
    cells = new int[(width/scl)  ];
    memory = new int[((width/scl)) + 1][(width/scl)];
    prevcells = new int[(width/scl) ];
    prevprevcells = new int[(width/scl)];
    solid = new int[3];
    solid2 = new float[3];
    trans2 = new float[3];
    trans = new int[3];
    pos_x = new int[((height/scl)*4) + 100];
    pos_y = new int[((height/scl)*4) + 100];
    cell_anim = new int [((height/scl)*4) + 100][(width/scl)];
    it_col = 0;
    mode = 1;
    indice = 500;
    time = 4;
    restart();
  }
  
  void setRules(int[] r) {
    rules = r;
  }
  
  void randomize() {
    int ok = 1;
    int rule = 0;
    int tot = 0;
   
    while (ok == 1) { 
      tot = 0;
    for (int i = 0; i < 8; i++) {
      rule = int(random(2));
      tot += rule;
      rules[i] = rule;
    }
    if (tot <= 6 && tot >= 2) {
      ok = 0;
    }
    }
  }
    void randomize2() {
    int ok = 1;
    int rule = 0;
    int tot = 0;
    solid[0] = int(random(205)) + 50;
    solid[1] = int(random(205)) + 50;
    solid[2] = int(random(205)) + 50;
    trans[0] = int(random(205)) + 50;
    trans[1] = int(random(205)) + 50;
    trans[2] = int(random(205)) + 50;
    solid2[0] = solid[0];
    solid2[1] = solid[2];
    solid2[2] = solid[2];
    trans2[0] = trans[0];
    trans2[1] = trans[1];
    trans2[2] = trans[2];
    while (ok == 1) { 
      tot = 0;
    for (int i = 0; i < 8; i++) {
      rule = int(random(2));
      tot += rule;
      rules[i] = rule;
    }
    if (tot <= 6 && tot >= 2) {
      ok = 0;
    }
    }
  }
  
  void restart() {
     solid[0] = int(random(205)) + 50;
   solid[1] = int(random(205)) + 50;
   solid[2] = int(random(205)) + 50;
   trans[0] = int(random(205)) + 50;
   trans[1] = int(random(205)) + 50;
   trans[2] = int(random(205)) + 50;
    step = int(random(2) + 1);
    mem = int(random(10));
    println(mem);
    for (int i = 0; i < cells.length; i = i + step) {
      cells[i] = 0;
    }
    cells[cells.length/2] = 1;
    for (int i = 0; i < cells.length-1; i = i + 1) {
      memory[0][i] = cells[i];
    }
    generation = 0;
  }

  void generate() {
    int compt = 0;
    int s = 0;
    int me = 0;
    int left = 0;
    int right = 0;
    int sum = 0;
    
    col = 0;
    int[] nextgen = new int[cells.length];
    for (int i = 1; i < cells.length - 1; i = i + 1) {
      if (i == 0) { left = 0; }
      else { left = cells[i-1]; }
      if (mem < 0 && generation >= mem) {
        me = memory[generation-mem][i];
      }
      else
      {
        me = cells[i];       // Current state
      }
       if (i == cells.length - 1) { right = 0; }
       else { right = cells[i+1]; }
      nextgen[i] = executeRules(left,me,right);
      if (s != 0 && i >= s) {
        for (int x = s; x >= 0; x--) {
          if (nextgen[i - x] == 1) {compt++;}
        }
      }
      if (s != 0 && compt - 1 == s) {
        nextgen[i] = 0;
      }
      compt = 0;
    }
    
    for (int i = 0; i < cells.length; i = i + 1) {
      sum += cells[i];
    }
    for (int i = 0; i < cells.length; i = i + 1) {
      cells[i] = nextgen[i];
      cell_anim[generation][i] = nextgen[i];
      sum += cells[i];
    }
    if ((generation >= 1 && sum <= 2) || (generation >= 1 && sum >= cells.length * 2)) { randomize(); }
    if (generation == cells.length / 2 && int(random(3)) == 4) { randomize(); } 
    generation = generation + 1;
  }
 
  void render() {
    for (int i = 0; i < cells.length / b_size ; i = i + 1) {
      if (cells[i] == 1) {
        fill(solid[0], solid[1], solid[2], 255);
      } else { 
        fill(trans[0], trans[1], trans[2], 255);
      }
      noStroke();
      rect(i*scl + mouseX,  mouseY, scl,scl);
      pos_x[generation] = mouseX;
      pos_y[generation] = mouseY;
    }
  }
  
  void render2() {
    for (int i = 0; i < cells.length; i = i + 1) {
      if (cells[i] == 1) {
        fill(solid[0], solid[1], solid[2], 255);
      } else { 
        fill(trans[0], trans[1], trans[2], 255);
      }
      noStroke();
      rect(generation*scl,i*scl + indice, scl,scl);
    }
  }
  
  void render3() {
    int a = 0;
    int b = 0;
    while (b < generation - 1) {
      a = 0;
    while(a < cells.length / 6) {
      if (cell_anim[b][a] == 1) {
        fill(solid2[0], solid2[1], solid2[2], 255);
      } else { 
        fill(trans2[0], trans2[1], trans2[2], 255);
      }
    rect(a * scl + pos_x[b], pos_y[b], scl, scl);
    a++;
    }
    b++;
     if (it_col == 0) {
     solid2[0] += 0.01;
     solid2[1] -= 0.01; 
     trans2[0] += 0.01;
    }
    if (it_col == 1) {
     solid2[0] -= 0.01;
     solid2[1] += 0.01;
     trans2[0] -= 0.01;
    }
    if (solid2[0] > 254) {
    it_col = 1;
    } else if (solid2[0] < 1) {
     it_col = 0; 
    }
    }
  }
  
  void render4() {
    int a = 0;
    int b = 0;
    while(a < cells.length / 2) {
      if (cell_anim[step_col][a] == 1) {
        fill(solid2[0], solid2[1], solid2[2], 255);
      } else { 
        fill(trans2[0], trans2[1], trans2[2], 255);
      }
    rect(a * scl + pos_x[step_col], pos_y[step_col], scl, scl);
    a++;
    }
     if (it_col == 0) {
     solid2[2] += 1;
     solid2[1] -= 1; 
     trans2[1] += 1;
    }
    if (it_col == 1) {
     solid2[2] -= 1;
     solid2[1] += 1;
     trans2[1] -= 1;
    }
    if (solid2[2] > 254) {
    it_col = 1;
    } else if (solid2[2] < 1) {
     it_col = 0; 
    }
    if (++step_col >= generation - 1) {step_col = 0;};
  }
  
  void render5() {
    int a = 0;
    int b = 0;
    if (mode == 0) {
      while(a < cells.length / b_size) {
      if (cell_anim[step_col][a] == 1) {
        fill(solid2[0], solid2[1], solid2[2], 255);
      } else { 
        fill(trans2[0], trans2[1], trans2[2], 255);
      }
    rect(a * scl + pos_x[step_col], pos_y[step_col], scl, scl);
    a++;
    }
     if (it_col == 0) {
     solid2[0] += 1;
     solid2[1] -= 1; 
     trans2[1] += 1;
    }
    if (it_col == 1) {
     solid2[0] -= 1;
     solid2[1] += 1;
     trans2[1] -= 1;
    }
    if (solid2[0] > 254) {
    it_col = 1;
    } else if (solid2[0] < 1) {
     it_col = 0; 
    }
    } else {
    while(a < cells.length / b_size) {
      color c = get(pos_x[step_col] + a * scl, pos_y[step_col]);
      c += 2;
      fill(c);
    rect(a * scl + pos_x[step_col], pos_y[step_col], scl, scl);
    a++;
    }
    }
    if (++step_col >= generation - 1) {step_col = 0;};
  }
  
  void mode() {
   if (b_size == 6) {b_size = 10;}
   else if (b_size == 10) {b_size = 2;}
   else {b_size = 6;};
  }
  
  void mode2() {
   if (mode == 0) {mode = 1;}
   else {mode = 0;};
  }
  
  void indice() {
   if (indice == 0) {indice = 500;}
   else if (indice == 500) {indice = 1000;}
   else {indice = 0;};
  }

  int executeRules (int a, int b, int c) {
    if (a == 1 && b == 1 && c == 1) { return rules[0]; }
    if (a == 1 && b == 1 && c == 0) { return rules[1]; }
    if (a == 1 && b == 0 && c == 1) { return rules[2]; }
    if (a == 1 && b == 0 && c == 0) { return rules[3]; }
    if (a == 0 && b == 1 && c == 1) { return rules[4]; }
    if (a == 0 && b == 1 && c == 0) { return rules[5]; }
    if (a == 0 && b == 0 && c == 1) { return rules[6]; }
    if (a == 0 && b == 0 && c == 0) { return rules[7]; }
    return 0;
  }
  
  boolean afinished() {
    if (generation >= (height/scl) ) {
       return true;
    } else {
       return false;
    }
  }
  boolean finished() {
    if (generation > (height/scl)*4) {
        
       return true;
    } else {
       return false;
    }
  }
}
