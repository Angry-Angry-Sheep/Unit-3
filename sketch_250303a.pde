int brushSize = 10;
color brushColor = color(0);
boolean eraser = false;
int selectedButton = -1;
int sliderX = 300;

void setup() {
  size(1000, 650);
  background(255);
}

void draw() {
  if (mousePressed && mouseY > 50 && selectedButton != -1) {
    stroke(eraser ? color(255) : brushColor);
    strokeWeight(brushSize);
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
  // UI setup
  strokeWeight(1);
  stroke(0);
  fill(200);
  
  rect(-10, 0, width+30, 50, 10);
  fill(255, 0, 0);
  
  drawButtons();
  drawSlider();
}

void drawButtons() {
  fill(200);
  rect(0, 0, width, 50);
  
  fill(selectedButton == 0 ? color(255, 140, 140) : color(255, 0, 0));
  rect(10, 10, 30, 30, 10);
  fill(selectedButton == 1 ? color(140, 255, 140) : color(0, 255, 0));
  rect(50, 10, 30, 30, 10);
  fill(selectedButton == 2 ? color(140, 140, 255) : color(0, 0, 255));
  rect(90, 10, 30, 30, 10);
  fill(selectedButton == 3 ? color(255, 255, 140) : color(255, 255, 0));
  rect(130, 10, 30, 30, 10);
  fill(selectedButton == 4 ? color(200, 140, 255) : color(128, 0, 128));
  rect(170, 10, 30, 30, 10);
  fill(selectedButton == 5 ? color(140) : color(0));
  rect(210, 10, 30, 30, 10);
  fill(selectedButton == 6 ? color(190) : color(255));
  rect(250, 10, 30, 30, 10);
}

void drawSlider() {
  fill(150);
  rect(300, 20, 150, 10, 5);
  fill(0);
  ellipse(sliderX, 25, 15, 15);
  brushSize = int(map(sliderX, 300, 450, 2, 100));
}

void mousePressed() {
  if (mouseY < 50 && mouseX < 280) {
    if (mouseX > 10 && mouseX < 40) { brushColor = color(255, 0, 0); selectedButton = 0; }
    if (mouseX > 50 && mouseX < 80) { brushColor = color(0, 255, 0); selectedButton = 1; }
    if (mouseX > 90 && mouseX < 120) { brushColor = color(0, 0, 255); selectedButton = 2; }
    if (mouseX > 130 && mouseX < 160) { brushColor = color(255, 255, 0); selectedButton = 3; }
    if (mouseX > 170 && mouseX < 200) { brushColor = color(128, 0, 128); selectedButton = 4; }
    if (mouseX > 210 && mouseX < 240) { brushColor = color(0); selectedButton = 5; }
    if (mouseX > 250 && mouseX < 280) { eraser = true; selectedButton = 6; }
    else eraser = false;
  }
}

void mouseDragged() {
  if (mouseY > 15 && mouseY < 35 && mouseX > 300 && mouseX < 450) {
    sliderX = mouseX;
  }
}
