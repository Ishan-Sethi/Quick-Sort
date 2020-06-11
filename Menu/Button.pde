/* 
   Min Kang, Ishan Sethi
   Ms.Krasteva
   April 17th, 2020
   
   Button class for the sorting animation. This class allows for flexibility in
   placing buttons around the entire program. Every clickable button uses this class
   or an extention of it. Accessor and mutator methods are written for variables that 
   require them.
*/

public class Button {
  
  // Variable Declarations \\
  private String label;      // Determines the text inside the button.
  private int xPos;          // Determines the X position of the button.
  private int yPos;          // Determines the Y position of the button.
  private int w;             // Determines the width of the button.
  private int h;             // Determines the height of the button.
  private color c;           // Determines the button's color.
  private boolean isClicked; // Determines if the button has been clicked.
  private int stroke;        // Determines the button's stroke size.
  private int strokeC;       // Determines the button's stroke color.
  
  // Constructor 1/2 \\
  // Used for the first three buttons in the main menu. Because the xPos, width, and height
  // is the same for these buttons, it can make the code look simplier by creating an overloaded method.
  public Button(String l, int y, color co) {
    label = l;
    xPos = 200;
    yPos = y;
    w = 250;
    h = 50;
    c = co;
    isClicked = false;
    stroke = 2;
    strokeC = 0;
  }
  
  // Constructor 2/2 \\
  // Used for rest of the buttons, where customization of the xPos size is needed.
  public Button(String l, int x, int y, int wi, int he, color co) {
    label = l;
    xPos = x;
    yPos = y;
    w = wi;
    h = he;
    c = co;
    isClicked = false;
    stroke = 2;
    strokeC = 0;
  }

  // Update Method \\
  // Method that updates the graphics of the button.
  public void update() {
    // Default values if the user does not click the button.
    isClicked = false;
    
    // Draws the outline of the button.
    fill(c);
    stroke(strokeC);
    strokeWeight(stroke);
    rectMode(CORNER);
    rect(xPos, yPos, w, h, 20);

    // Draws the text on the button.
    fill(0);
    textAlign(CENTER, CENTER);
    textFont(serif, 24);
    text(label, xPos+(w/2.0), yPos+(h/2.0));
    
    // Checks if the user is hovering over the button.
    if (mouseX >= xPos && mouseX <= xPos + w && mouseY >= yPos && mouseY <= yPos + h) {
      stroke = 5;
      if (mousePressed) {
        isClicked = true;
        mousePressed = false;
      }
    } else {
      stroke = 2;
    }
  }
  
  // SetStrokeColor Method \\
  // A mutator method to change the strokeC color based on the argument.
  public void setStrokeColor(int c){
    strokeC = c;
  }
  
  // GetClicked Method \\
  // An accessor method that returns the isClicked boolean value for other methods to use.
  public boolean getClicked() {
    return isClicked;
  }
}
