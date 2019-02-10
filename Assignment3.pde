import static javax.swing.JOptionPane.*;

boolean start = false;
int trialCounter = 0;
int conditionNumber = -1;
int userNumber = 0;
int errorCounter = 0;
double targetDistance = 0;
long elapsedTime = 0;
long timeAtLastClick = 0;
int randomValue = (int)(random(25)) + 1;
int prevClick = -1;
int prevLightUp = 0;
int roundNumber = 1;

//Buttons 4 and 8 on for block1
//Buttons 3, 5, 7, 9 on for block2
//Buttons 2-9 on for block3
//320
void setup(){
  String id = showInputDialog("Please enter a number ID");
  userNumber = Integer.parseInt(id);
  while(conditionNumber != 0 && conditionNumber != 1){
     Object[] option = {"0", "1"};
     conditionNumber = showOptionDialog(frame, "Please select a condition number", "Condition Number", YES_NO_OPTION, QUESTION_MESSAGE, null, option, option); 

  }
  Object[] option = {"Click to practice!"};
  showOptionDialog(frame, "Please select each bar as quickly and accurately as possible. This is round " + roundNumber + " of 4.", "Confirmation", YES_NO_OPTION, QUESTION_MESSAGE, null, option, option); 
  size(240,240);
}

void draw(){
 background(200); 
 stroke(0, 0, 0);
 //mouseClicked();
 fill(255);
 if(!start){
   lightUp(randomValue);
   if(prevClick == randomValue ){
     start = true;
     prevLightUp = randomValue;
     randomValue = (int)(random(25)) + 1;
     timeAtLastClick = millis();
     prevClick = -1;

   }
 }
 else{
   lightUp(randomValue);
 }
 
}


int whichButton()  {
   int xPos = mouseX;
   int yPos = mouseY;
   if(conditionNumber ==0){
     if(xPos > 27.5 && xPos < 212.5 && yPos > 27.5 && yPos < 212.5){
       int moddedX = xPos % 40;
       int moddedY = yPos % 40;
       
       if(moddedX >= 20){
          moddedX = Math.abs(moddedX - 40);
          xPos += 20;
       }
       if(moddedY >= 20){
          moddedY = Math.abs(moddedY - 40); 
          yPos += 20;
       }
       double distance = Math.sqrt((0 - moddedX)*(0 - moddedX) + (0 - moddedY)*(0 - moddedY));
       
       int clickedX = xPos / 40;
       int clickedY = yPos / 40;
       
      
      if(distance < 12.5){
         return (clickedX - 1) * 5 + clickedY;
      }
      
      else{
       return 0; 
      }
     }
     else{
   //    println("Outside");
       return 0;
     }
   }
   else{
     if(xPos > 20 && xPos < 220 && yPos > 20 && yPos < 220){
       int moddedX = xPos % 40;
       int moddedY = yPos % 40;
       
       if(moddedX >= 20){
          moddedX = Math.abs(moddedX - 40);
          xPos += 20;
       }
       if(moddedY >= 20){
          moddedY = Math.abs(moddedY - 40); 
          yPos += 20;
       }
       double distance = Math.sqrt((0 - moddedX)*(0 - moddedX) + (0 - moddedY)*(0 - moddedY));
       
       int clickedX = xPos / 40;
       int clickedY = yPos / 40;
       
      
      if(distance < 20){
         return (clickedX - 1) * 5 + clickedY;
      }
      
      else{
       return 0; 
      }
     }
     else{
   //    println("Outside");
       return 0;
     }
   }
}

double distanceBetween(){
  int tensPlacePrev = prevLightUp / 5;
  int onesPlacePrev = prevLightUp % 5;
  if(onesPlacePrev == 0){
      onesPlacePrev = 5;
  } else {
    tensPlacePrev++; 
  }
 // println(tensPlacePrev + ", " + onesPlacePrev);
  int tensPlaceCurr = randomValue / 5;
  int onesPlaceCurr = randomValue % 5;
  if(onesPlaceCurr == 0){
      onesPlaceCurr = 5;
  }
  else {
    tensPlaceCurr++; 
  }
    //println(tensPlaceCurr + ", " + onesPlaceCurr);

  
  int xPrev = tensPlacePrev * 40;
  int yPrev = onesPlacePrev * 40;
  int xCurr = tensPlaceCurr * 40;
  int yCurr = onesPlaceCurr * 40;
  
  return Math.sqrt((yCurr - yPrev) * (yCurr - yPrev) + (xCurr - xPrev) * (xCurr - xPrev));
}


void lightUp(int value){
  int counter = 1;
  for(int i = 1; i <= 5; i++){
     for(int j = 1; j <= 5; j++){
       if(counter != value){
         ellipse(40*i,40*j,25,25);
       }
       else{
         fill(0,255,0);
         ellipse(40*i,40*j,25,25);
         fill(255);
       }
       counter++;
     }
   }
}

void mouseClicked(){
    prevClick = whichButton();
    //println(prevClick);
    if(!start){
       if(prevClick == randomValue){
     trialCounter++;
          prevLightUp = randomValue;
     randomValue = (int)(random(25)) + 1;  
     long currentTime = millis();
     elapsedTime = currentTime - timeAtLastClick;
     timeAtLastClick = currentTime;
     if(roundNumber == 2 || roundNumber == 4){
       println(userNumber + "\t" + trialCounter + "\t" + conditionNumber + "\t" + elapsedTime + "\t" + errorCounter + "\t" + targetDistance);
     }
     targetDistance = distanceBetween();
     errorCounter = 0;  
 }
   else if(prevClick != 0 && prevClick != randomValue){
     errorCounter++;
     //delay(120);
   }
   if(trialCounter == 20){
      start = false;
      roundNumber++;
      if(roundNumber == 3){
        Object[] option = {"Click to begin practice!"};
        showOptionDialog(frame, "Please select each bar as quickly and accurately as possible. This is round " + roundNumber + " of 4.", "Confirmation", YES_NO_OPTION, QUESTION_MESSAGE, null, option, option); 
      }
      else if(roundNumber == 2 || roundNumber == 4){
        Object[] option = {"Click to begin evaluation!"};
        showOptionDialog(frame, "Please select each bar as quickly and accurately as possible. This is round " + roundNumber + " of 4.", "Confirmation", YES_NO_OPTION, QUESTION_MESSAGE, null, option, option);         
      }
      if(roundNumber == 5){
        Object[] option = {"OK!"};
        showOptionDialog(frame, "Thank you for your time", "Thank you", YES_NO_OPTION, QUESTION_MESSAGE, null, option, option);  
        exit();
        
      }
     if(roundNumber == 3 && conditionNumber == 1){
       conditionNumber = 0;
     }
     else if(roundNumber == 3 && conditionNumber == 0){
       conditionNumber = 1;
     }
      trialCounter = 0;
   }
   //delay(120);
   prevClick = -1;
    }
}
