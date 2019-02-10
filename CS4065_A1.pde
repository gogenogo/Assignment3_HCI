/* **********************************************************************************

CS4065 - Assignment 1
Author: Alex Demmings 3530599

IMPORTANT NOTE: To execute this code on a high DPI screen, go to setup() and change 
                the pixelDensity() parameter from 1 to 2, like so: 
                
                                        pixelDensity(2);

********************************************************************************** */

import processing.sound.*;
import static javax.swing.JOptionPane.*;

//initialize block and trial; blocks are indexed from 0 to 2
int currentBlock = -1; 
int currentTrial=20;
int[][] blocks = {{1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 1, 2, 2, 2, 2, 1, 2, 1, 1, 2},
                  {4, 2, 1, 1, 2, 1, 3, 4, 2, 1, 4, 3, 4, 4, 2, 3, 3, 4, 4, 4},
                  {6, 6, 3, 6, 1, 1, 8, 6, 6, 7, 2, 5, 5, 7, 3, 6, 5, 1, 8, 3}};

//button declarations
StartButton start = new StartButton();
ReadyButton readyButton = new ReadyButton();
StandardButton north = new StandardButton(500, 187);         // top; represented by 1
StandardButton south = new StandardButton(500, 613);        // bottom; represented by 2
StandardButton west = new StandardButton(187, 400);           // left; represented by 3
StandardButton east = new StandardButton(813, 400);          // right; represented by 4
StandardButton northwest = new StandardButton(217, 217);      // top-left; represented by 5
StandardButton northeast = new StandardButton(783, 217);     // top-right; represented by 6
StandardButton southwest = new StandardButton(217, 583);     // bottom-left; represented by 7
StandardButton southeast = new StandardButton(783, 583);    // bottom-right; represented by 8

//declarations for storing user data
int user;
int[][] responseTime = new int[3][20];                  
int[][] errors = new int[3][20];
int startInMS;
int successInMS;
             
//miscellaneous declarations
SoundFile sound;
boolean ready=true;

void setup() {
  size(1000, 800);
  //               **************************************** FOR HIGH DPI SCREENS: CHANGE pixelDensity() PARAMETER TO 2 *****************************************
  pixelDensity(2); 
  background(0, 0, 0);
      
  sound = new SoundFile(this, "success.wav");
  
  String userIn = showInputDialog("Welcome! Please enter your user number.");
  user = parseInt(userIn);
  println("Welcome, user " + user + "!");
  
  //start.display();
  //println("Press \"Start\" to begin.");
}

void draw() {
  if (ready && currentTrial == 20) {
    println("Congratulations! You've made it through block " + (currentBlock + 1) + "! :)");
    if(currentBlock < 2){
      println("Click to begin block " + (currentBlock + 2) + ".");
      ready=false;
      clickContinue();
    } else {
      background(0);
      fill(255);
      text("Congratulations!", 300, 200);
      text("You have finished all three blocks.", 125, 300);
      text(":)", 475, 500);
      currentTrial = 21;
    }
  }
}

void clickContinue() {
  background(0, 0, 0);
  readyButton.display();
  fill(255);
  if(currentBlock >= 0) {
    text("Block " + (currentBlock+1) + " completed.", 300, 200); 
    text("Click \"Ready\" to continue...", 200, 300);
  } else {
    textSize(30);
    text("Instructions:", 10, 50);
    text("A set of blue buttons with a red \"Start\" button will appear.", 10, 150);
    text("Each time \"Start\" is pressed, one blue button will turn yellow.", 10, 200);
    text("Your goal is to tap the yellow button as quickly as possible.", 10, 250);
    text("You will repeat this 20 times for each of 3 rounds.", 10, 300);
    text("Click \"I'm ready!\" to begin.", 300, 500);
  }
}

void nextButton() {  
  if(currentTrial < 20) {
    switch(blocks[currentBlock][currentTrial]) {
      case 1: north.highlight(); break;
      case 2: south.highlight(); break;
      case 3: west.highlight(); break;
      case 4: east.highlight(); break;
      case 5: northwest.highlight(); break;
      case 6: northeast.highlight(); break;
      case 7: southwest.highlight(); break;
      case 8: southeast.highlight(); break;
    }
  }
}

void mousePressed() {  
  boolean success = true;
  
  //check for clicked start button
  if(ready && currentTrial < 20) {
    if(mouseX >= 400 && mouseX <= 600) {
      if(mouseY >= 350 && mouseY <= 450) {
          startInMS = millis();
          ready=false;
          
          background(0,0,0);
          start.display();
                   
          if(currentBlock == 2) {
            northwest.display();
            northeast.display();
            southwest.display();
            southeast.display();
          }
          if(currentBlock >= 1) {
            west.display();
            east.display();
          } 
          north.display();
          south.display();
          nextButton();
        }
      }
    }
    //check for other clicked buttons
    else if(currentTrial < 20){     
     success = false;
      if(blocks[currentBlock][currentTrial] == 1) {
       if(mouseX >= (north.getX()-112) && mouseX <= (north.getX()+112)) {
         if(mouseY >= (north.getY()-62) && mouseY <= (north.getY()+62)) {
           successInMS = millis();
           responseTime[currentBlock][currentTrial] = successInMS - startInMS;
           north.display();
           ready=true;
           success = true;
           sound.play();
           println(user+"\t"+(currentBlock+1) +"\t"+(currentTrial+1)+"\t"+responseTime[currentBlock][currentTrial]+"\t"+errors[currentBlock][currentTrial]);
           currentTrial++;
         }
       }
     }
     else if(blocks[currentBlock][currentTrial] == 2) {
       if(mouseX >= (south.getX()-112) && mouseX <= (south.getX()+112)) {
         if(mouseY >= (south.getY()-62) && mouseY <= (south.getY()+62)) {
           successInMS = millis();
           responseTime[currentBlock][currentTrial] = successInMS - startInMS;
           south.display();
           println(user+"\t"+(currentBlock+1) +"\t"+(currentTrial+1)+"\t"+responseTime[currentBlock][currentTrial]+"\t"+errors[currentBlock][currentTrial]);
           currentTrial++;
           ready=true;
           success = true;
           sound.play();
         }
       }
     }
     else if(blocks[currentBlock][currentTrial] == 3) {
       if(mouseX >= (west.getX()-112) && mouseX <= (west.getX()+112)) {
         if(mouseY >= (west.getY()-62) && mouseY <= (west.getY()+62)) {
           successInMS = millis();
           responseTime[currentBlock][currentTrial] = successInMS - startInMS;
           west.display();
           println(user+"\t"+(currentBlock+1) +"\t"+(currentTrial+1)+"\t"+responseTime[currentBlock][currentTrial]+"\t"+errors[currentBlock][currentTrial]);
           currentTrial++;
           ready=true;
           success = true;
           sound.play();
         }
       }
     }
     else if(blocks[currentBlock][currentTrial] == 4) {
       if(mouseX >= (east.getX()-112) && mouseX <= (east.getX()+112)) {
         if(mouseY >= (east.getY()-62) && mouseY <= (east.getY()+62)) {
           successInMS = millis();
           responseTime[currentBlock][currentTrial] = successInMS - startInMS;
           east.display();
           println(user+"\t"+(currentBlock+1) +"\t"+(currentTrial+1)+"\t"+responseTime[currentBlock][currentTrial]+"\t"+errors[currentBlock][currentTrial]);
           currentTrial++;
           ready=true;
           success = true;
           sound.play();
         }
       }
     }
     else if(blocks[currentBlock][currentTrial] == 5) {
       if(mouseX >= (northwest.getX()-112) && mouseX <= (northwest.getX()+112)) {
         if(mouseY >= (northwest.getY()-62) && mouseY <= (northwest.getY()+62)) {
           successInMS = millis();
           responseTime[currentBlock][currentTrial] = successInMS - startInMS;
           northwest.display();
           println(user+"\t"+(currentBlock+1) +"\t"+(currentTrial+1)+"\t"+responseTime[currentBlock][currentTrial]+"\t"+errors[currentBlock][currentTrial]);
           currentTrial++;
           ready=true;
           success = true;
           sound.play();
         }
       }
     }
     else if(blocks[currentBlock][currentTrial] == 6) {
       if(mouseX >= (northeast.getX()-112) && mouseX <= (northeast.getX()+112)) {
         if(mouseY >= (northeast.getY()-62) && mouseY <= (northeast.getY()+62)) {
           successInMS = millis();
           responseTime[currentBlock][currentTrial] = successInMS - startInMS;
           northeast.display();
           println(user+"\t"+(currentBlock+1) +"\t"+(currentTrial+1)+"\t"+responseTime[currentBlock][currentTrial]+"\t"+errors[currentBlock][currentTrial]);
           currentTrial++;
           ready=true;
           success = true;
           sound.play();
         }
       }
     }
     else if(blocks[currentBlock][currentTrial] == 7) {
       if(mouseX >= (southwest.getX()-112) && mouseX <= (southwest.getX()+112)) {
         if(mouseY >= (southwest.getY()-62) && mouseY <= (southwest.getY()+62)) {
           successInMS = millis();
           responseTime[currentBlock][currentTrial] = successInMS - startInMS;
           southwest.display();
           println(user+"\t"+(currentBlock+1) +"\t"+(currentTrial+1)+"\t"+responseTime[currentBlock][currentTrial]+"\t"+errors[currentBlock][currentTrial]);
           currentTrial++;
           ready=true;
           success = true;
           sound.play();
         }
       }
     }
     else if(blocks[currentBlock][currentTrial] == 8) {
       if(mouseX >= (southeast.getX()-112) && mouseX <= (southeast.getX()+112)) {
         if(mouseY >= (southeast.getY()-62) && mouseY <= (southeast.getY()+62)) {
           successInMS = millis();
           responseTime[currentBlock][currentTrial] = successInMS - startInMS;
           southeast.display();
           println(user+"\t"+(currentBlock+1) +"\t"+(currentTrial+1)+"\t"+responseTime[currentBlock][currentTrial]+"\t"+errors[currentBlock][currentTrial]);
           currentTrial++;
           ready=true;
           success = true;
           sound.play();
         }
       }
     }
     if(success == false) {
       errors[currentBlock][currentTrial]++;
     }
  } else if (!ready && currentTrial == 20){
    if(mouseX >= 50 && mouseX <= 750 && mouseY >= 650 && mouseY <= 750) {
      currentBlock++;
      currentTrial=0;
      ready = true;
      background(0,0,0);
      start.display();
                     
      if(currentBlock == 2) {
        northwest.display();
        northeast.display();
        southwest.display();
        southeast.display();
      }
      if(currentBlock >= 1) {
        west.display();
        east.display();
      } 
      north.display();
      south.display();
    }
  }
}

class StandardButton {
 color colourInit;
 color colourHighlight;
 float xpos;
 float ypos;
 float bHeight;
 float bWidth;
 
 StandardButton(float x, float y) {
   colourInit = color(0, 0, 255);
   colourHighlight = color(255, 255, 0);
   xpos = x;
   ypos = y;
 }
 
 void display() {
   fill(colourInit);
   rect(xpos, ypos, 225, 125);
 }
 
 void highlight() {
   fill(colourHighlight);
   rect(xpos, ypos, 225, 125);
 }
 
 float getX() {
   return xpos;
 }
 
 float getY() {
   return ypos;
 }
}

class StartButton {
  
  void display() {
    rectMode(CENTER);
    fill(255, 0, 0);
    rect(500, 400, 200, 100);
    textSize(45);
    fill(255);
    text("Start", 450, 412);
  }

}

class ReadyButton {
void display() {
    rectMode(CENTER);
    fill(100, 255, 100);
    rect(500, 700, 700, 100);
    textSize(45);
    fill(255);
    text("I'm ready!", 400, 712);
  }
}
