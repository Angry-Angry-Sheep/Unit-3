int brushSize = 10;
color brushColor = color(0);
boolean eraser = false;

void setup() {
  size(800, 600);
  background(255);
}

void draw() {
  if (mousePressed && mouseY > 50) {
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
  
  rect(10, 10, 30, 30, 10);
  fill(0, 255, 0);
  rect(50, 10, 30, 30, 10);
  fill(0, 0, 255);
  rect(90, 10, 30, 30, 10);
  fill(0);
  rect(130, 10, 30, 30, 10);
  fill(255);
  rect(170, 10, 30, 30, 10);
  
}

void mousePressed() {
  if (mouseY < 50) {
    if (mouseX > 10 && mouseX < 40) {
      brushColor = color(255, 0, 0);
    }
    if (mouseX > 50 && mouseX < 80){
      brushColor = color(0, 255, 0);
    }
    if (mouseX > 90 && mouseX < 120){
      brushColor = color(0, 0, 255);
    }
    if (mouseX > 130 && mouseX < 160){
      brushColor = color(0);
    }
    if (mouseX > 170 && mouseX < 200){
      eraser = true;
    }
    else eraser = false;
  }
}

void keyPressed() {
  if (key == '+') brushSize += 2;
  if (key == '-' && brushSize > 2) brushSize -= 2;
}
