import java.util.ArrayList;

ArrayList<PGraphics> Canvases = new ArrayList<PGraphics>();
int Index = 0;
PGraphics baseCanvas, Preview;
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
  baseCanvas = createGraphics(1000, 650);
  Preview = createGraphics(1000, 650);
  background(255);
  Ethan1 = loadImage("ethan.png");
  Ethan2 = loadImage("ethan2.png");
  
  baseCanvas.beginDraw();
  baseCanvas.fill(255);
  baseCanvas. rect(0,0,1000,650);
  baseCanvas.endDraw();
  
  Canvases.add(baseCanvas);
  Canvases.add(createGraphics(1000, 650));
}

void draw() {
  if (selectedTool == "CLEAR") {
    Canvases.clear();
    baseCanvas = createGraphics(1000, 650);
    Preview = createGraphics(1000, 650);
    background(255);
    Ethan1 = loadImage("ethan.png");
    Ethan2 = loadImage("ethan2.png");
    
    baseCanvas.beginDraw();
    baseCanvas.fill(255);
    baseCanvas. rect(0,0,1000,650);
    baseCanvas.endDraw();
    
    Canvases.add(baseCanvas);
    Canvases.add(createGraphics(1000, 650));
    Index = 0;
  }
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
  
  Canvases.get(Index).beginDraw();
  if (mousePressed && mouseY > 50) {
    if (selectedButton == -2) {
      Canvases.get(Index).image(Ethan1, mouseX - (Ethan1.width*(brushSize/60.0)) / 2, mouseY - (Ethan1.height*(brushSize/60.0)) / 2, Ethan1.width*(brushSize/60.0), Ethan1.height*(brushSize/60.0));
    }
    else if (selectedButton == -3) {
      Canvases.get(Index).image(Ethan2, mouseX - (Ethan2.width*(brushSize/60.0)) / 2, mouseY - (Ethan2.height*(brushSize/60.0)) / 2, Ethan2.width*(brushSize/60.0), Ethan2.height*(brushSize/60.0));
    } else if (selectedButton > -1) {
      Canvases.get(Index).stroke(eraser ? color(255) : brushColor);
      Canvases.get(Index).strokeWeight(brushSize);
      Canvases.get(Index).line(pmouseX, pmouseY, mouseX, mouseY);
    }
  }
  
  strokeWeight(1);
  stroke(0);
  fill(200);
  rect(-10, 0, width+30, 50, 10);
  fill(255, 0, 0);
  mouseHovered();
  Canvases.get(Index).endDraw();
  
  for (PGraphics pg : Canvases) {
    image(pg, 0, 0);
  }
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
  
  // Reset Button
  if (selectedButton == -4) {
    fill(150);
  } else if (hoveredButton == -4) {
    fill(180);
  } else {
    fill(215);
  }
  rect(800, 10, 80, 30, 5);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(16);
  text("New", 840, 25);
  
  // Save Button
  if (selectedButton == -5) {
    fill(150);
  } else if (hoveredButton == -5) {
    fill(180);
  } else {
    fill(215);
  }
  rect(715, 10, 80, 30, 5);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(16);
  text("Save", 755, 25);
  
  // Undo Button
  if (selectedButton == -6) {
    fill(150);
  } else if (hoveredButton == -6) {
    fill(180);
  } else {
    fill(215);
  }
  ellipse(600, 25, 30, 30); // Move Undo button left
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(16);
  text("<<", 600, 25); // Undo symbol
  
  // Load Button
  if (selectedButton == -7) {
    fill(150);
  } else if (hoveredButton == -7) {
    fill(180);
  } else {
    fill(215);
  }
  rect(630, 10, 80, 30, 5); // Position similar to Save button
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(16);
  text("Load", 670, 25); // Load button text
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
    fill(160);
  } else {
    fill(215);
  }
  rect(900, 10, 40, 30, 5);
  fill(255);
  image(Ethan1, 900, 10, 40, 30);
  
  if (selectedButton == -3) {
    fill(100);
  } else if (hoveredButton == -3) {
    fill(160);
  } else {
    fill(215);
  }
  rect(950, 10, 40, 30, 5);
  fill(255);
  image(Ethan2, 950, 10, 40, 30);
}

void mousePressed() {
  if (selectedTool != null) {
    Canvases.add(createGraphics(1000, 650));
    Index++;
  }
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
  if (mouseY < 50 && mouseX > 900 && mouseX < 940) {
    selectedTool = "IMAGE";
    selectedButton = -2;
  }
  if (mouseY < 50 && mouseX > 950 && mouseX < 990) {
    selectedTool = "IMAGE";
    selectedButton = -3;
  }
  if (mouseY < 50 && mouseX > 800 && mouseX < 885) {
    selectedTool = "CLEAR";
    selectedButton = -4;
  }
  if (mouseY < 50 && mouseX > 715 && mouseX < 795) {
    selectedTool = "SAVE";
    selectedButton = -5;
    saveFrame("drawing.png");
  }
  if (mouseY < 50 && mouseX > 585 && mouseX < 615) {
    selectedTool = "UNDO";
    selectedButton = -6;
    if (Index > 0) {
      Canvases.remove(Canvases.size() - 1);
      Index--;
      System.out.println(Index);
      if (Index == 0) {
        Canvases.remove(Canvases.size() - 1);
        Canvases.add(createGraphics(1000, 650));
      }
    }
    selectedTool = null;
    selectedButton = -1;
  }
}

void mouseHovered() {
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
    if (mouseY < 50 && mouseX > 900 && mouseX < 940) hoveredButton = -2;
    if (mouseY < 50 && mouseX > 950 && mouseX < 990) hoveredButton = -3;
    
    if (mouseY < 50 && mouseX > 800 && mouseX < 885) {
      hoveredButton = -4;
      if (!mousePressed) {
        if (selectedButton == -4) {
          selectedButton = -1;
          selectedTool = null;
        }
      }
    }
    
    if (mouseY < 50 && mouseX > 715 && mouseX < 795) {
      hoveredButton = -5;
      if (!mousePressed) {
        if (selectedButton == -5) {
          selectedButton = -1;
          selectedTool = null;
        }
      }
    }
    
    if (mouseY < 50 && mouseX > 585 && mouseX < 615) {
      hoveredButton = -6;
    }
}

void mouseDragged() {
  if (mouseY > 15 && mouseY < 35 && mouseX > 300 && mouseX < 450) {
    sliderX = mouseX;
  }
}

void keyPressed() {
  if (key == BACKSPACE) {
    if (Index > 0) {
      Canvases.remove(Canvases.size() - 1);
      Index--;
      System.out.println(Index);
      if (Index == 0) {
        Canvases.remove(Canvases.size() - 1);
        Canvases.add(createGraphics(1000, 650));
      }
    }
  }
}
