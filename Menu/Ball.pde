/* 
   Min Kang, Ishan Sethi
   Ms.Krasteva
   April 17th, 2020
   
   Ball class for the sorting animation. This contains all of the variables
   that the program may need for animations, the position, color, radius, and
   a boolean that controls if the text is visible or not. A method controls the 
   drawing mechanic that is called to animate the ball. Accessor and mutator methods
   are written for variables tha require them.
*/

public class Ball {
  
  // Variable Declarations \\
  private int xPos;             // Determines the X position of the circle.
  private int col;              // Determines the color of the circle.
  private int rad;              // Determines the radius of the circle.
  private boolean textVisible;  // Determines if the color value is shown on the ball.
  private PGraphics ballG;      // Stores the graphics of the ball as if it was in another window,
                                //      allows filter effects to be set on it without any problem.
                                //      The PGraphics are similar to a JPanel.
  // Final Variables \\
  private final int yPos = 150; // Determines the Y position of the circle.
  
  // Constructor \\
  // Instead of taking the radius and xPos values directly, an equation has been written
  // to calculate the radius and xPos based on the arraySize and index of the ball in the
  // array. This allows for flexible array size when demonstrating the sort, with the side
  // effect of having weird spacing at some points.
  public Ball (int index, int arrSize, int c, boolean vis) {
    rad = width/(arrSize+2);
    xPos = ((rad+1)*index)+(width/arrSize)-2;
    col = c;
    textVisible = vis;
    
    //This initializes the graphics into ballG.
    ballG = createGraphics(width, height, P2D);
      ballG.beginDraw();
      ballG.noStroke();
      ballG.fill(blue);
      ballG.ellipseMode(CENTER);
      ballG.ellipse(xPos, yPos, rad+(rad/4), rad+(rad/4));
      ballG.filter(glow);
      ballG.endDraw();
  }

  // UpdateBall Method \\
  // Method that updates the graphics of the ball.
  public void updateBall() {
    
    // Draws the circle.
    noStroke();
    fill(col);
    ellipseMode(CENTER);
    ellipse(xPos, yPos, rad, rad);
    
    // Draws the text if textVisible is true.
    if(textVisible){
      fill(135-col, 255-col, 200-col);
      textAlign(CENTER, CENTER);
      textFont(calibri, rad-(rad/2));
      text(col, xPos, yPos-(rad*0.05));
    }
  }
  
  // UpdateGlow Method \\
  // Method that draws the glow of the ball.
  public void updateGlow() {
    
    // Calls the PGraphics ballG into image, drawing the pGraphics from the origin 0,0.
    image(ballG, 0, 0);
  }
  
  // SetColor Method \\
  // An accessor method that changes the color based on the argument given.
  public void setColor(int c) {
    col = c;
  }
}
