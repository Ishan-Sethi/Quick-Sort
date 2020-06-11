/* 
   Min Kang, Ishan Sethi
   Ms.Krasteva
   April 17th, 2020
   
   Pivot class to show what has been sorted and what has not. This class
   contains a method to draw two lines around the pivot, which shows when the
   entire array has been sorted. This two-line pivot, when it surrounds all of
   the balls, indicate that the array has been sorted.
*/

public class Pivot {
  
  // Variable Declarations \\
  private int xPos;    // Determines the X position of the pivot lines.
  private int yPos;    // Determines the Y position of the pivot lines.
  private int rad;     // Determines the radius of the circle. This is
                       //      duplicate value from the Ball class as it
                       //      is needed for certain calculations.
  
  // Final Variables \\
  private final color col = color(70, 230, 230);  //Determines the color of the pivot.
  
  // Constructor \\
  // This constructor also takes an index and arrSize instead of the xPos and yPos as
  // all of the classes used in the animation is made to be flexible with any amount of balls.
  // Another equation is used to calculate these positions.
  public Pivot (int index, int arrSize) {
    rad = width/(arrSize+2)/2;
    xPos = ((width/(arrSize+2)+1)*index)+(width/arrSize)-2;
    yPos = 150-rad;
  }

  // Update Method \\
  // Method that updates the graphics of the pivot lines.
  public void update() {
    stroke(col, 240);
    strokeWeight(2);
    line(xPos - rad, yPos - 10, xPos - rad, yPos + rad*2 + 10);
    line(xPos + rad, yPos - 10, xPos + rad, yPos + rad*2 + 10);
  }
}
