/* 
   Min Kang, Ishan Sethi
   Ms.Krasteva
   April 17th, 2020
   
   Slider class to use in the options menu. This class allows for the user's 
   dragging motion on the slider to be translated to the knob of the slider. 
   This value is also stored into the class.
*/

public class Slider {
  
  // Variable Declarations \\
  private int value;           // Determines the value of the slider based on the knob's position
  private int xPos;            // Determines the X position of the slider.
  private int yPos;            // Determines the Y position of the slider.
  private int w;               // Determines the width of the slider.
  private int xSliderPos;      // Determines the x position of the slider knob.

  // Constructor \\
  // This constructor takes in the x, y, and width values of the slider.
  // The slider knob will be placed at the end of the slider.
  public Slider(int x, int y, int wi) {
    xPos = x;
    xSliderPos = xPos-5;
    yPos = y;
    w = wi;
  }

  // Update Method \\
  // Method that updates the graphics of the slider and calculates where
  // the knob must be placed depending on where the mouse cursor is and if
  // it is being pressed or not.
  public void update() {
    
    stroke(0);
    strokeWeight(2);
    fill(255);
    rect(xPos, yPos, w, 10, 10);
    if (mouseX >= xPos && mouseX <= xPos + w && mouseY >= yPos - 20 && mouseY <= yPos + 30) {
      if (mouseX >= xSliderPos && mouseX <= xSliderPos + 20) {
        strokeWeight(5);
        stroke(65, 182, 230);
      }
      if (mousePressed) {
        strokeWeight(5);
        stroke(65, 182, 230);
        xSliderPos = mouseX -10;
      }
    } else {
      noStroke();
      mousePressed = false;
    }
    rect(xSliderPos, yPos - 20, 20, 50, 5);
    value = (xSliderPos - xPos)+10;
  }
  
  // GetValue Method \\
  // An accessor method that returns the value of the slider knob.
  public int getValue() {
    return value;
  }
}
