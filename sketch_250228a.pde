int buttonSize = 50;
int rows = 4;
int cols = 3;
String password = "";
String correctPassword = "198355";
int accessGranted = 0;
int maxPasswordLength = 10;
String[] labels = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "←", "0", "✔"};

void setup() {
  size(200, 320);
  textAlign(CENTER, CENTER);
  textSize(20);
  
  if (correctPassword.length() > maxPasswordLength)
    System.out.println("WARNING: Password length exceeds maximum length limit");
}

void draw() {
  background(220);
  
  if (accessGranted == 0)
    fill(210);
  else if (accessGranted == 1)
    fill(0,255,0);
  else
    fill(255,0,0);
  rect(25, 35, 150, 30, 0);
  
  drawButtons();
  displayPassword();
}

void drawButtons() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      int index = i * cols + j;
      int x = j * buttonSize + 25;
      int y = i * buttonSize + 100;
      
      //Check if hovered
      if (mouseX > x && mouseX < x + buttonSize && mouseY > y && mouseY < y + buttonSize) {
        fill(180);
      } else {
        fill(200);
      }
      
      stroke(150);
      strokeWeight(2);
      rect(x, y, buttonSize, buttonSize, 5);
      fill(0);
      text(labels[index], x + buttonSize / 2, y + buttonSize / 2);
    }
  }
}

void displayPassword() {
  fill(0);
  textSize(20);
  if (accessGranted == 1) {
    text("Access Granted", width / 2, 50);
  } 
  else if (accessGranted == -1) {
    text("Access Denied", width / 2, 50);
  }
  else {
    text(password.replaceAll(".", "*"), width / 2, 50);
  }
}

void mousePressed() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      int index = i * cols + j;
      int x = j * buttonSize + 25;
      int y = i * buttonSize + 100;
      if (mouseX > x && mouseX < x + buttonSize && mouseY > y && mouseY < y + buttonSize) {
        handleButtonPress(index);
        return;
      }
    }
  }
}

void handleButtonPress(int index) {
  String pressed = labels[index];
  
  if (pressed.equals("✔")) {
    if (password.length() > 0 && accessGranted == 0) {
      password = password.substring(0, password.length() - 1);
    }
    else{
      accessGranted = 0;
      password = "";
    }
  } 
  else if (pressed.equals("←")) {
    if (password.equals(correctPassword)) {
      accessGranted = 1;
    } 
    else {
      accessGranted = -1;
    }
  } 
  else {
    if (password.length() < maxPasswordLength) {
      password += pressed;
    }
  }
}
