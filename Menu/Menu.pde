/* 
 Min Kang, Ishan Sethi
 Ms.Krasteva
 April 17th, 2020
 
 Menu tab for the QuickSort demonstration/visualization program.
 This tab holds all of the methods and global variables not stored in a class.
 Rest of the tabs will all be seperate classes.
 */

// Global Variable Declaration \\
int menuState;             // Stores what screen the draw method needs to loop.
int arrayIndexPos;         // Stores the index of the arrayHistory the sort stores to.
int[][] arrayHistory;      // Stores every shift of variables in the QuickSort method, allowing it
                           //      to be looped over to animate the values.
int tempIndexPos;          // Stores the index that the animation is first drawing.
int arraySize;             // Stores the array size the sort and animation will handle. Determines lots of
                           //      things, such as ball size, pointer length, etc.
int animateDelay;          // Stores the delay value that the animation will use.
int alpha;                 // Stores the alpha channel values for certain screens.
int pageNum;               // Stores the instructions page count, allowing for different screens inside the method.
int animateDummy;          // Stores the animation delay that can be shown in the instructions menu.
PFont broadway;            // Stores the fonts used in the program.
PFont calibri; 
PFont serif;  
PFont bigSerif;
PShader blur;              // Stores the .glsl file which determines the shader that the renderer uses.
PShader glow;              // Same .glsl files as PShader with different configurations.
PGraphics border;          // Stores the borders with the glow for the instructions screen.
Ball[] ba;                 // Stores the array of balls the animation uses to draw.
Button[] bu;               // Stores the array of buttons the user can choose between in the main menu.
Button[] flip;             // Stores the array of buttons the user can use to flip between screens in instructions.
Button cont;               // Stores the button that allows for you to animate from the options chosen.
Pivot[] piv;               // Stores the pivot locations and allows the animation to draw them later.
Pointer[] poi;             // Stores the pointers, which are the values being compared to one another.
Pointer[] dummyPoi;        // Stores the pointers used to describe how the sorting animation works.
Slider delay;              // Stores the slider that can determine the length of the delay for the animation.
Slider dummyS;             // Stores the slider that is usable in the instructions menu, demonstrating the usage in the options menu.
Switch[] arrayCount;       // Stores the switches (it can be on or off) the user can choose between 
                           //      in the options menu. This is the array size.
Switch numberVis,dummyVis; // Stores the other switches the user can turn on or off.

// The below global variables are for drawing use only, and therefore are final.
// Final Global Variables \\
final color blue = color(65, 182, 230);
final color pink = color(219, 62, 177);

// Setup Method \\
// This method only runs once, almost like the main method in Java. This allows
// for initializations for the upcomming draw method. Other things such as setting
// of the window size must be done here as well.
public void setup() {

  // Sets size, changes renderer.
  size(650, 500, P2D);

  // Initialization of the variables and arrays being used.
  menuState = 0;
  arrayIndexPos = 0;
  tempIndexPos = 0;
  arraySize = 0;
  alpha = 0;
  animateDelay = 0;
  pageNum = 0;
  broadway = loadFont("Broadway-48.vlw");
  calibri = loadFont("Calibri-Light-48.vlw");
  serif = loadFont("SansSerif.plain-18.vlw");
  bigSerif = loadFont("SansSerif.plain-36.vlw");
  blur = loadShader("blur.glsl");
    blur.set("blurSize", 220);
    blur.set("sigma", 10.0f);
  glow = loadShader("blur.glsl");
    glow.set("blurSize", 120);
    glow.set("sigma", 2.0f);
  border = createGraphics(width, height, P2D);
    border.beginDraw();
    border.stroke(blue);
    border.strokeWeight(12);
    border.line(15, 15, 100, 15);
    border.line(15, 15, 15, 400);
    border.line(635, 400, 540, 400);
    border.line(635, 400, 635, 15);
    border.filter(glow);
    border.stroke(255);
    border.strokeWeight(7);
    border.line(15, 15, 100, 15);
    border.line(15, 15, 15, 400);
    border.line(635, 400, 540, 400);
    border.line(635, 400, 635, 15);
    border.fill(255, 190);
    border.noStroke();
    border.rectMode(CORNERS);
    border.rect(15, 15, 635, 400);
    border.endDraw();
  bu = new Button [4];
    bu[0] = new Button("Sort", 150, color(150, 225, 255));
    bu[1] = new Button("Instruction", 237, color(255, 145, 226));
    bu[2] = new Button("Exit", 325, color(150, 225, 255));
    bu[3] = new Button("Return", 225, 425, 200, 50, color(139, 231, 255));
  flip = new Button [2];
    flip[0] = new Button("<", 500, 425, 50, 50, color(246, 232, 255));
    flip[1] = new Button(">", 560, 425, 50, 50, color(246, 232, 255));
  cont = new Button("Continue", 225, 400, 200, 50, color(139, 231, 255));
  dummyPoi = new Pointer [3];
  delay = new Slider(97, 330, 403);
  dummyS = new Slider(50, 330, 403);
  arrayCount = new Switch [5];
    arrayCount[0] = new Switch("10", 95, 70, 100, 100, color(255));
    arrayCount[1] = new Switch("20", 220, 70, 100, 100, lerpColor(color(255), blue, 0.33));
    arrayCount[2] = new Switch("30", 345, 70, 100, 100, lerpColor(color(255), blue, 0.66));
    arrayCount[3] = new Switch("40", 470, 70, 100, 100, blue);
    arrayCount[4] = new Switch("10", 495, 70, 100, 100, color(255));
    arrayCount[0].setSwitched(true);
  numberVis = new Switch("Number Visible?", 200, 210, 250, 50, color(255, 145, 226));
  dummyVis = new Switch("Number Visible?", 35, 200, 250, 50, color(255, 145, 226));
}

// Draw Method \\
// This method refreshes 60 times a second, allowing easy access to animation. The draw functions
// only run when the draw method reaches the end, so it is important to place the delay commands
// strategically. This contains all of the code to change screens, as well as drawing the background
// used in all of the screens.
public void draw() {

  // Draws the mainMenu with a black background.
  background(0);
  mainMenu();

  // If the screen is on the main menu, sort or options, draw the title.
  if(menuState < 3)
    drawTitle();

  // Calls different methods based on the value of menuState.
  if (menuState == 0) {
    for (int i = 0; i < 3; i++) {
      bu[i].update();
      if (bu[i].getClicked()) {
        menuState = (i+2);
      }
    }
  } 
  else if (menuState == 1)
    sortDisplay();
  else if (menuState == 2)
    options();
  else if (menuState == 3)
    instructions();
  else if (menuState == 4)
    leave();
}

// DrawTitle Method \\
// Draws the title
public void drawTitle() {
  // Program title
  textFont(broadway); 
  textAlign(CENTER, CENTER);
  textSize(62);
  fill(0);
  text("QuickSort", width/2 + 3, 35 + 3);
  fill(pink);
  text("QuickSort", width/2 - 3, 35 - 3);
  fill(255, 255, 255);
  text("QuickSort", width/2, 35);
}

// MainMenu Method \\
// This method is used to create a custom background for the entire program.
public void mainMenu() {

  // Draws the glow from the white lines.
  for (int i = -600; i <= width + 600; i+= 50) {
    strokeWeight(5);
    stroke(pink);
    line(i, height, (width/2), 200);
  }
  for (int i = 300; i < height; i += 30) {
    strokeWeight(5);
    stroke(pink);
    line(0, i, width, i);
  }

  // Uses the shader to blur out the pink lines.
  filter(blur);

  // Draws the white lines over the pink glow.
  for (int i = -600; i <= width + 600; i+= 50) {
    strokeWeight(2);
    stroke(255);
    line(i, height, (width/2), 200);
  }
  for (int i = 300; i < height; i += 30) {
    strokeWeight(2);
    stroke(255);
    line(0, i, width, i);
  }

  // Draws the gradient sky using lerpColor.
  for (int i = 0; i < 300; i++) {
    stroke(lerpColor(blue, pink, i/200.0));
    line(0, i, width, i);
  }

  // Painstakingly coded City Skyline.
  fill(0);
  ellipseMode(CORNER);
  rectMode(CORNER);
  noStroke();
  rect(0, 270, width, 30, 2);
  rect(0, 200, 45, 75, 2);
  rect(5, 165, 35, 135);
  rect(45, 150, 55, 125, 2);
  triangle(45, 150, 100, 150, 72.5, 125);
  rect(100, 175, 35, 100, 2);
  rect(135, 200, 50, 75, 2);
  ellipse(141, 190, 35, 25);
  rect(185, 195, 15, 90, 2);
  rect(200, 180, 15, 105, 2);
  rect(215, 165, 15, 120, 2);
  rect(230, 80, 35, 220, 2);
  rect(280, 80, 35, 220, 2);
  rect(265, 120, 15, 10);
  rect(265, 185, 15, 115);
  rect(315, 165, 30, 135);
  ellipse(312, 152, 32, 30);
  triangle(345, 100, 385, 145, 345, 145);
  rect(345, 145, 40, 155);
  rect(385, 230, 40, 50);
  rect(387.5, 210, 35, 40);
  rect(390, 170, 30, 40);
  rect(392.5, 150, 25, 20);
  rect(395, 130, 20, 20);
  triangle(397.5, 130, 405, 110, 412.5, 130);
  triangle(425, 170, 465, 125, 465, 170);
  rect(425, 170, 40, 130);
  rect(465, 210, 15, 90);
  rect(470, 180, 20, 120);
  rect(480, 160, 20, 140);
  rect(500, 150, 20, 150);
  rect(520, 175, 25, 125);
  rect(545, 200, 15, 100);
  rect(560, 230, 20, 70);
  rect(580, 185, 30, 115);
  rect(610, 205, 15, 95);
  rect(625, 190, 25, 110);

  // Draws a haze like glow in the background.
  for (int i = 0; i < 120; i++) {
    stroke(255, 180, 220, 120-i);
    strokeWeight(1);
    if (i == 0)
      line(0, 150, width, 150);
    else {
      line(0, 150+i, width, 150+i);
      line(0, 150-i, width, 150-i);
    }
  }
}

// SortDisplay Method \\
// This method uses arrayHistory to animate the steps quicksort takes to fully
// sort the given array. It uses the ball, pivot, and pointer class to draw these.
// After the animation is over, the user has the choice to return to the main menu.
public void sortDisplay() {

  //updates the ball glow and the actual ball.
  for (int i = 0; i < arraySize; i++)
    ba[i].updateGlow();
  for (int i = 0; i < arraySize; i++) {
    ba[i].setColor(arrayHistory[i][tempIndexPos]);
    ba[i].updateBall();
  }

  //updates the pointers.
  for (int i = arraySize; i < arraySize+3; i++) {
    poi[i-arraySize].setX(arrayHistory[i][tempIndexPos], arraySize);
    poi[i-arraySize].update();
  }

  //adds a pivot if it is needed.
  if (arrayHistory[arraySize+3][tempIndexPos] == 0)
    piv[arrayHistory[arraySize+2][tempIndexPos]] = new Pivot(arrayHistory[arraySize+2][tempIndexPos], arraySize);

  //updates all pivots.
  for (int i = 0; i < arraySize; i++) {
    if (piv[i] != null)
      piv[i].update();
  }

  //increment tempIndexPos if the array has not been fully animated,
  if (tempIndexPos < arrayIndexPos-1) {
    tempIndexPos++;
    delay(animateDelay);
  } 
  //else show the button to return back.
  else {
    bu[3].update();
    if (bu[3].getClicked())
      menuState = 0;
  }
}

// Options Method \\
// This method is reached is when the user presses the sort button from the main menu. 
// It allows the user to customize three things, the amount of balls being sorted, if the 
// text (number) is shown on the ball, and the length of the delay between the sorting steps.
public void options() {

  // Updates and checks for switches for the four buttons that control the size of the array.
  for (int i = 0; i < 4; i++) {
    arrayCount[i].update();
    if (arrayCount[i].getClicked()) {
      if (!arrayCount[i].getSwitched())
        arrayCount[i].setSwitched(true); 
      else {
        if (i != 0) { arrayCount[0].setSwitched(false); }
        if (i != 1) { arrayCount[1].setSwitched(false); }
        if (i != 2) { arrayCount[2].setSwitched(false); }
        if (i != 3) { arrayCount[3].setSwitched(false); }
      }
    }
    if (arrayCount[i].getSwitched()) {
      if (i == 0) { arraySize = 10; } 
      else if (i == 1) { arraySize = 20; } 
      else if (i == 2) { arraySize = 30; } 
      else if (i == 3) { arraySize = 40; }
    }
  }

  // Updates rest of the switches, buttons, and sliders.
  numberVis.update();
  cont.update();
  delay.update();
  
  // Calcualtes the delay using the value from the slider and draws it next to the slider.
  animateDelay = int(delay.getValue()/300.0*100);
  noStroke();
  fill(255, 220);
  rectMode(CORNER);
  rect(515, 310, 80, 50);
  fill(0);
  textAlign(CENTER, CENTER);
  textFont(calibri);
  text(animateDelay, 555, 330);

  // When the continue button is clicked,
  if (cont.getClicked()) {

    //Initialize the ball array,
    ba = new Ball [arraySize];
    for (int i = 0; i < arraySize; i++)
      ba[i] = new Ball(i, arraySize, 0, numberVis.getSwitched());

    //Initialize the pointers,
    poi = new Pointer[3];
    poi[0] = new Pointer(0, arraySize, -2, 170, color(0, 0, 255, 150));
    poi[1] = new Pointer(0, arraySize, 2, 170, color(0, 255, 0, 150));
    poi[2] = new Pointer(0, arraySize, 0, 170, color(255, 0, 0, 150));

    //initialise the pivot array,
    piv = new Pivot[arraySize];
    
    //initialise the values needed for the array storage/animation,
    arrayIndexPos = 0;
    tempIndexPos = 0;
    arrayHistory = new int [arraySize+4][arraySize*arraySize];

    //generate a random integer array with the values between 1 and 255.
    int[] array = new int[arraySize];
    for (int j = 0; j < arraySize; j++) {
      int random = (int)random(1, 255);
      ba[j].setColor(random);
      array[j] = random;
    }
    
    //store this current array and call the sorting method.
    storeArrayPos(array, 0, 0, array.length-1, array.length-1);
    quickSort(array, 0, array.length-1);

    //change menuState to 1, moving the screen to the sorting screen.
    menuState = 1;
  }
}

// Instructions Method \\
// This method is reached when the user presses the instructions button. This allows them to then
// flip through four pages, each describing a certain portion of the program. 
public void instructions() {

  //draws the border with a glow in the back.
  image(border, 0, 0);

  // Draws the decrement page button if the pageNum value is not 0.
  if (pageNum != 0) {
    flip[0].update();
    // If the button is being pressed, decrement pageNum.
    if (flip[0].getClicked())
      pageNum--;
  }

  // Draws the increment page button if the pageNum value is not 3.
  if (pageNum != 3) {
    flip[1].update();
    // If the button is being pressed, increment pageNum.
    if (flip[1].getClicked())
      pageNum++;
  }

  // Draws the return button and checks for it being pressed.
  bu[3].update();
  if (bu[3].getClicked()){
    menuState = 0;
    pageNum = 0;
  }
  
  // Draws the other details such as text on the screen based on the value of pageNum.
  rectMode(CORNER);
  switch(pageNum) {
    // Draws all of the nessesary text and objects to describe the options in the options screen.
    case 0:
      textAlign(LEFT, TOP);
      textFont(broadway, 32);
      fill(255);
      for (int x = -1; x <= 1; x++) {
        text("Options Pannel: What They Mean", 25+x, 25);
        text("Options Pannel: What They Mean", 25, 25+x);
      }
      fill(0);
      text("Options Pannel: What They Mean", 25, 25);
      textFont(serif, 18);
      textAlign(RIGHT, TOP);
      text("These buttons with the numbers control the amount of balls being sorted in the animation.", 180, 90, 300, 200);
      textAlign(LEFT, TOP);
      text("This button will show numbers on the ball, which is the value of the color on the ball.", 300, 190, 200, 200);
      textFont(serif, 16);
      text("The below slider controls the animation speed. Try messing around with the knobs!", 30, 280);
      arrayCount[4].update();
      dummyVis.update();
      dummyS.update();
      noStroke();
      ellipseMode(CENTER);
      textAlign(CENTER, CENTER);
      textFont(calibri, 16);
      if ((dummyS.getValue()/5+1) > animateDummy) {
        fill(0);
        ellipse(520, 330, 50, 50);
        fill(255);
        text(dummyS.getValue()/5, 520, 330);
      } else {
        fill(255);
        ellipse(520, 330, 50, 50);
        fill(0);
        text(dummyS.getValue()/5, 520, 330);
        if ((dummyS.getValue()/5+1)*2 < animateDummy)
          animateDummy = 0;
      }
      animateDummy++;
      break;
    
    // Draws all of the nessesary text and objects to describe the actions of the pointers and what they describe.
    case 1:
      textAlign(LEFT, TOP);
      textFont(broadway, 32);
      fill(255);
      for (int x = -1; x <= 1; x++) {
        text("Pointers: What They Describe", 25+x, 25);
        text("Pointers: What They Describe", 25, 25+x);
      }
      fill(0);
      text("Pointers: What They Describe", 25, 25);
      textFont(serif, 18);
      text("The blue pointer shows the pivot of the current partition. In short, it is the value that gets compared with the green pointer.", 70, 70, 500, 100);
      text("The green pointer shows the loop counter of the current partition. It increments every animation and gets compared to with the blue pointer. If the green pointer's value is smaller than the blue's, it increments red pointer.", 70, 170, 500, 100);
      text("The red pointer shows where the pivot, the blue pointer, will go to after the green pointer reaches the end of the partition.", 70, 290, 500, 100);
      dummyPoi[0] = new Pointer(3, 50, 0, 70, color(0, 0, 255, 150));
      dummyPoi[1] = new Pointer(3, 50, 0, 170, color(0, 255, 0, 150));
      dummyPoi[2] = new Pointer(3, 50, 0, 290, color(255, 0, 0, 150));
      for(int i = 0; i < 3; i++)
        dummyPoi[i].update();
      break;
    
    // Draws all of the nessesary text and objects to describe the partitioning and recursion in this sort.
    case 2:
      textAlign(LEFT, TOP);
      textFont(broadway, 32);
      fill(255);
      for (int x = -1; x <= 1; x++) {
        text("Partitions and Sorting Process", 25+x, 25);
        text("Partitions and Sorting Process", 25, 25+x);
      }
      fill(0);
      text("Partitions and Sorting Process", 25, 25);
      textFont(serif, 18);
      textAlign(CENTER, TOP);
      text("Partitions are what Quicksort uses to split up the array into smaller pieces. These partitions are created when the pivot moves into it's correct location. Everything before and after that moved pivot becomes the new \"array\" where then quicksort uses recursion to divide up the array once more, until all parts of the array has been partitioned.", 50, 60, 550, 200);
      int[] dummyArr = {23, 10, 61, 35, 44, 12, 24};
      for(int i = 0; i < 7; i++){
        textFont(serif, 18);
        text(dummyArr[i], (50*i)+170, 240);
        textFont(serif, 16);
        text(i, (50*i)+170, 220);
      }
      dummyPoi[0] = new Pointer(24, 50, 0, 270, color(255, 0, 0, 150));
      dummyPoi[1] = new Pointer(35, 50, 0, 270, color(0, 0, 255, 150));
      dummyPoi[0].update();
      dummyPoi[1].update();
      stroke(color(70, 230, 230), 240);
      strokeWeight(2);
      line(300, 210, 300, 260);
      line(340, 210, 340, 260);
      fill(0);
      textAlign(CENTER, TOP);
      text("The cyan lines represent the partitions. When all values of the array is surrounded by these cyan lines, the sort understands that the array has been fully sorted.", 30, 340, 590, 200);
      break;
    
    // Draws all of the nessesary text to describe the time complexities of this sort.
    case 3:
      textAlign(LEFT, TOP);
      textFont(broadway, 32);
      fill(255);
      for (int x = -1; x <= 1; x++) {
        text("Big O Notation: Time Complexity", 25+x, 25);
        text("Big O Notation: Time Complexity", 25, 25+x);
      }
      fill(0);
      text("Big O Notation: Time Complexity", 25, 25);
      textFont(bigSerif);
      text("O(n log n)", 30, 70);
      text("O(n log n)", 30, 170);
      text("O(n ^ n)", 30, 270);
      textFont(serif);
      text("This is best case time complexity. This occurs when the pivot is always placed in the middle of the array. This causes the least amount of comparisons.", 190, 70, 410, 200);
      text("This is average case time complexity. This is one of the reason why quicksort is used so often, as the average case scenario is the same as the best. It ensures fast sorting for most cases.", 190, 170, 410, 200);
      text("This is worst case time complexity. This only occurs when the array is sorted, the array is sorted in reverse, or if all of the values are the same. These cases don't happen frequently, and if they do occur, it is easy to check beforehand.", 160, 270, 410, 200);
      break;
  }
}

// Leave Method \\
// This method allows for the program to slowly fade out and automatically
// exit. It uses a variable for the alpha channel and slowly increments it until it 
// reaches a certain point, which then it closes the program.
public void leave() {

  //increments alpha by 2.
  alpha+=2;

  //when alpha is 400, exit the program.
  if (alpha > 400)
    exit();

  //draws the translucent background.
  noStroke();
  fill(0, alpha);
  rectMode(CORNERS);
  rect(0, 0, width, height);

  //draws the goodbye text.
  textAlign(CENTER, CENTER);
  fill(255, alpha);
  textSize(24);
  text("Made by Min Kang and Ishan Sethi.", width/2, 5*height/6);
  text("The program will automatically close.", width/2, 5.3*height/6);
}

// Quicksort Method \\
// This method contains the actual quicksort that occurs before the
// animation. A method is called at certain points of the sort to store 
// the current values of the array, high, loop counter, and pivot position.
public void quickSort(int[] arr, int low, int high) {
  if (low < high) {
    int pos = low;
    for (int i = low; i <= high - 1; i++) {
      if (arr[i] < arr[high]) {
        int arrTemp = arr[pos];
        arr[pos] = arr[i];
        arr[i] = arrTemp;
        storeArrayPos(arr, high, i, pos, -1);  // Called before pos increment as it interferes with correct storing.
        pos++;
      } else {
        storeArrayPos(arr, high, i, pos, -1);  // Called if the comparison does not occur.
      }
    }
    int arrTemp = arr[high];
    arr[high] = arr[pos];
    arr[pos] = arrTemp;
    storeArrayPos(arr, high, high-1, pos, 0);  // The last argument is 0, indicating the pivot has been placed.

    quickSort(arr, low, pos - 1);
    quickSort(arr, pos + 1, high);
  }
}

// StoreArrayPos Method \\
// This method is responsible for storing each step of the quicksort into an 2d 
// integer array. The parameters given are inputted from the sort method, and a
// for loop goes through each index of the array and places them into the correct
// index. This is done by incrementing a global variable called arrayIndexPos.
public void storeArrayPos(int[] arr, int rightmost, int counter, int pos, int piv) {
  for (int i = 0; i < arraySize+4; i++) {
    if (i < arraySize)
      arrayHistory[i][arrayIndexPos] = arr[i];
    else if (i == arraySize)
      arrayHistory[i][arrayIndexPos] = rightmost;
    else if (i == arraySize+1)
      arrayHistory[i][arrayIndexPos] = counter;
    else if (i == arraySize+2)
      arrayHistory[i][arrayIndexPos] = pos;
    else if (i == arraySize+3)
      arrayHistory[i][arrayIndexPos] = piv;
  }
  arrayIndexPos++;
}
