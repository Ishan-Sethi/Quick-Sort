/* 
   Min Kang, Ishan Sethi
   Ms.Krasteva
   April 17th, 2020
   
   Pointer class to show the comparisons occuring in the sort. This class
   allows for the program to draw multiple arrows showing the comparisons
   between the rightmost index in the partition and the for loop going through 
   the array. Accessor and mutator methods are written for variables that require them.
*/

public class Pointer {
  
  // Variable Declarations \\
  private int xPos;             // Determines the X position of the pointer.
  private int yPos;              // Determines the Y position of the pointer.
  private int offset;           // Determines the offset of the pointer for the X position.
  private color col;            // Determines the color of the pointer.
  
  // Constructor \\
  // This constructor also takes an index and array size instead of the xPos
  // for flexibility in animation. A color argument is took to differenciate 
  // between the two pointers used in the animation.
  public Pointer (int index, int arrSize, int off, int y, color c) {
    xPos = ((width/(arrSize+2)+1)*index)+(width/arrSize)-2 + off;
    yPos = y;
    offset = off;
    col = c;
  }
  
  // Update Method \\
  // Method that updates the graphics of the pointer.
  public void update() {
    noStroke();
    fill(col);
    triangle(xPos - 15, yPos + 20, xPos, yPos, xPos + 15, yPos + 20);
    rectMode(CORNER);
    rect(xPos - 5, yPos + 20, 10, 40);
  }
  
  // SetX Method \\
  // This method also takes in the index and array size for the flexibility and
  // simplification of code.
  public void setX(int index, int arrSize) {
    xPos = ((width/(arrSize+2)+1)*index)+(width/arrSize)-2 + offset;
  }
}
