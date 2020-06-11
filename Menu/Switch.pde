/* 
   Min Kang, Ishan Sethi
   Ms.Krasteva
   April 17th, 2020
   
   Switch class to use in the options menu. This child class based off of the
   Button class is adds on the ability to switch "on and off" the button. This is used
   for the options menu, where certain options can be checked off to be used.
   Accessor and mutator methods are written for variables that require them.
*/

public class Switch extends Button {
  
  // Variable Declarations \\
  private boolean switchedOn;  // Determines if the switch has been flicked on.
  
  // Constructor \\
  // This constructor calls the super's constructer, that being Button's constructer,
  // with the arguments given from the parameters. Then another variable is initialized,
  // the boolean that differenciates a button from a switch.
  public Switch(String l, int x, int y, int wi, int he, color co) {
    super(l, x, y, wi, he, co);
    switchedOn = false;
  }

  // Update Method \\
  // Method that updates the graphics of the switch. This method calls the super's update
  // method as well and on top of that, uses the getClicked method to add another function.
  public void update() {
    super.update();
    if (this.getClicked())
      switchedOn = !switchedOn;
    
    if(switchedOn)
      this.setStrokeColor(150);
    else
      this.setStrokeColor(0);
  }

  // SetSwitched Method \\
  // A mutator method to change the switchedOn value depending on the argument.
  public void setSwitched(boolean on) {
    switchedOn = on;
  }

  // GetSwitched Method \\
  // An accessor method that returns the switchedOn boolean.
  public boolean getSwitched() {
    return switchedOn;
  }
}
