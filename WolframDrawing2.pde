PImage cur;
CA ca;
CA catwo;
float time = 4;

void setup() {
  size(1000, 1000);
  int[] ruleset = {0,1,0,1,1,0,1,0};
  ca = new CA(ruleset);
  catwo = new CA(ruleset); 
  background(random(205) + 50, random(205) + 50, random(205) + 50);
  cursor(CROSS);
}

void draw() {
   if(frameCount % time == 0){
  catwo.render2(); 
  catwo.generate();
  }
   ca.render5(); 
  if (ca.finished()) {
    ca.randomize2();
    ca.restart();
  }
  if (catwo.afinished()) {
    catwo.randomize();
    catwo.restart();
  }
}

void mouseDragged()
{
  ca.render();
  ca.generate();
  ca.render5(); 
}

void mousePressed() {
  ca.randomize2();
}

void keyPressed() {
  if (keyCode == UP) {
    catwo.randomize();
    ca.randomize2();
  }
  else if (keyCode == LEFT) {
     ca.randomize2();
     catwo.randomize2();
     background(random(205) + 50, random(205) + 50, random(205) + 50);
  }
  else if (keyCode == RIGHT) {
    noLoop();
    catwo.indice();
  }
  else if (keyCode == DOWN) {
    ca.mode();
    
  }
  else if (keyCode == CONTROL) {
    ca.mode2();
  }
  else if (key == 'a')
    time--;
  else if (key == 'z')
    time++;
  else {
    loop();
  }
}
