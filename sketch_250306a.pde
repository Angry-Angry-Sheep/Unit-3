PGraphics Canvas, Preview;
int brushSize = 10;
color brushColor = color(0);
boolean eraser = false;
int selectedButton = -1;
int hoveredButton = -1;
int sliderX = 300;
PImage Ethan1;
PImage Ethan2;
String selectedTool = null;
boolean imageStamp1 = false;
boolean imageStamp2 = false;

void setup() {
  size(1000, 650);
  Canvas = createGraphics(1000, 650);
  Preview = createGraphics(1000, 650);
  background(255);
  Ethan1 = loadImage("ethan.png");
  Ethan2 = loadImage("ethan2.png");
  
  Canvas.beginDraw();
  Canvas.fill(255);
  Canvas. rect(0,0,1000,650);
  Canvas.endDraw();
}

void draw() {
  Preview.beginDraw();
  Preview.background(0, 0);
  Preview.clear();
  if (selectedTool == "IMAGE"){
    Preview.stroke(0);
    Preview.fill(255, 0, 0, 0);
    Preview.strokeWeight(1.5);
    
    if (selectedButton == -2)
      Preview.rect(mouseX - (Ethan1.width*(brushSize/60.0)) / 2, mouseY - (Ethan1.height*(brushSize/60.0)) / 2, Ethan1.width*(brushSize/60.0), Ethan1.height*(brushSize/60.0));
    else
      Preview.rect(mouseX - (Ethan2.width*(brushSize/60.0)) / 2, mouseY - (Ethan2.height*(brushSize/60.0)) / 2, Ethan2.width*(brushSize/60.0), Ethan2.height*(brushSize/60.0));
  }
  if (selectedTool == "PEN"){
    Preview.fill(255, 0, 0, 0);
    Preview.strokeWeight(1.5);
    Preview.ellipse(mouseX, mouseY, brushSize, brushSize);
  }
  Preview.endDraw();
  
  Canvas.beginDraw();
  if (mousePressed && mouseY > 50) {
    if (selectedButton == -2) {
      Canvas.image(Ethan1, mouseX - (Ethan1.width*(brushSize/60.0)) / 2, mouseY - (Ethan1.height*(brushSize/60.0)) / 2, Ethan1.width*(brushSize/60.0), Ethan1.height*(brushSize/60.0));
    }
    else if (selectedButton == -3) {
      Canvas.image(Ethan2, mouseX - (Ethan2.width*(brushSize/60.0)) / 2, mouseY - (Ethan2.height*(brushSize/60.0)) / 2, Ethan2.width*(brushSize/60.0), Ethan2.height*(brushSize/60.0));
    } else {
      Canvas.stroke(eraser ? color(255) : brushColor);
      Canvas.strokeWeight(brushSize);
      Canvas.line(pmouseX, pmouseY, mouseX, mouseY);
    }
  }
  
  strokeWeight(1);
  stroke(0);
  fill(200);
  rect(-10, 0, width+30, 50, 10);
  fill(255, 0, 0);
  Canvas.endDraw();
  
  image(Canvas, 0, 0);
  image(Preview, 0, 0);
  
  drawButtons();
  drawSlider();
  drawIndicator();
  drawStamps();
}

void drawButtons() {
  fill(200);
  rect(0, 0, width, 50);
  
  drawButton(0, 10, color(255, 0, 0));
  drawButton(1, 50, color(0, 255, 0));
  drawButton(2, 90, color(0, 0, 255));
  drawButton(3, 130, color(255, 255, 0));
  drawButton(4, 170, color(128, 0, 128));
  drawButton(5, 210, color(0));
  drawButton(6, 250, color(255));
}

void drawButton(int index, int x, color baseColor) {
  strokeWeight(1.25);
  if (selectedButton == index) {
    fill(lerpColor(baseColor, color(0), 0.5));
    stroke(255);
  } else if (hoveredButton == index) {
    fill(lerpColor(baseColor, color(255), 0.5));
    stroke(0);
  } else {
    fill(baseColor);
    stroke(0);
  }
  rect(x, 10, 30, 30, 10);
  strokeWeight(1);
  stroke(0);
}

void drawSlider() {
  fill(150);
  rect(300, 20, 150, 10, 5);
  fill(0);
  ellipse(sliderX, 25, 15, 15);
  brushSize = int(map(sliderX, 300, 450, 2, 100));
}

void drawIndicator() {
  fill(brushColor);
  stroke(0);
  rect(470, 10, 30, 30, 2);
  fill(0);
  textSize(16);
  textAlign(LEFT, CENTER);
  text("Size: " + brushSize, 510, 25);
}

void drawStamps() {
  if (selectedButton == -2) {
    fill(100);
  } else if (hoveredButton == -2) {
    fill(200);
  } else {
    fill(215);
  }
  rect(850, 10, 40, 30, 5);
  fill(255);
  text("E", 865, 30);
  
  if (selectedButton == -3) {
    fill(100);
  } else if (hoveredButton == -3) {
    fill(200);
  } else {
    fill(215);
  }
  rect(900, 10, 40, 30, 5);
  fill(255);
  text("X", 915, 30);
}

void mousePressed() {
  if (mouseY < 50 && mouseX < 280) {
    brushColor = color(0);
    eraser = false;
    selectedButton = -1;
    imageStamp1 = false;
    imageStamp2 = false;
    
    if (mouseX > 10 && mouseX < 40) { brushColor = color(255, 0, 0); selectedButton = 0; selectedTool = "PEN";}
    if (mouseX > 50 && mouseX < 80) { brushColor = color(0, 255, 0); selectedButton = 1; selectedTool = "PEN";}
    if (mouseX > 90 && mouseX < 120) { brushColor = color(0, 0, 255); selectedButton = 2; selectedTool = "PEN";}
    if (mouseX > 130 && mouseX < 160) { brushColor = color(255, 255, 0); selectedButton = 3; selectedTool = "PEN";}
    if (mouseX > 170 && mouseX < 200) { brushColor = color(128, 0, 128); selectedButton = 4; selectedTool = "PEN";}
    if (mouseX > 210 && mouseX < 240) { brushColor = color(0); selectedButton = 5; selectedTool = "PEN";}
    if (mouseX > 250 && mouseX < 280) { brushColor = color(255); eraser = true; selectedButton = 6; selectedTool = "PEN";}
  }
  if (mouseY < 50 && mouseX > 850 && mouseX < 890) {
    selectedTool = "IMAGE";
    selectedButton = -2;
  }
  if (mouseY < 50 && mouseX > 900 && mouseX < 940) {
    selectedTool = "IMAGE";
    selectedButton = -3;
  }
}

void mouseMoved() {
  hoveredButton = -1;
  if (mouseY < 50 && mouseX < 280) {
    if (mouseX > 10 && mouseX < 40) hoveredButton = 0;
    if (mouseX > 50 && mouseX < 80) hoveredButton = 1;
    if (mouseX > 90 && mouseX < 120) hoveredButton = 2;
    if (mouseX > 130 && mouseX < 160) hoveredButton = 3;
    if (mouseX > 170 && mouseX < 200) hoveredButton = 4;
    if (mouseX > 210 && mouseX < 240) hoveredButton = 5;
    if (mouseX > 250 && mouseX < 280) hoveredButton = 6;
  }
    if (mouseY < 50 && mouseX > 850 && mouseX < 890) hoveredButton = -2;
    if (mouseY < 50 && mouseX > 900 && mouseX < 940) hoveredButton = -3;
}

void mouseDragged() {
  if (mouseY > 15 && mouseY < 35 && mouseX > 300 && mouseX < 450) {
    sliderX = mouseX;
  }
}
