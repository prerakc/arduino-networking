//Button Class
class Button
{
  //Declare variables
  float posX;
  float posY;
  float LED_State;
  float pin;

  //Constructor called when creating a new button
  Button(float yMod, float pin, float LED_State)
  {
    //Store the button's x and y position and the pin assosiated with the button
    posX = 100;
    posY = 50 + yMod;
    this.LED_State = LED_State;
    this.pin = pin;
  }

  void drawButton()
  {
    //If the LED's state is off, draw a red button
    if (LED_State == -1)
    {
      fill(255, 0, 0);
    } else if (LED_State == 1)  //If the LED's state is on, draw a green button
    {
      fill(0, 255, 0);
    }

    ellipse(posX, posY, 25, 25);
  }

  //Check to see if a button was pressed
  boolean checkButton()
  {
    //If the mouse was used to press a button
    if (dist(mouseX, mouseY, posX, posY) <= 12.5)
    {
      //Switch the state of the LED
      LED_State *= -1;
      return true;
    } else
    {
      return false;
    }
  }

  void sendData()
  {
    //Create a string to store the message being sent to the server
    String message = new String();

    /*
    The first character is based on the pin associated with the button
     
     r = red LED
     g = green LED
     y = yellow LED
     */
    if (pin == 8)
    {
      message += "r";
    } else if (pin == 9)
    {
      message += "g";
    } else if (pin == 10)
    {
      message += "y";
    }

    //ON or OFF is written afterwards depending on the new state of the LED
    if (LED_State == -1)
    {
      message += "OFF";
    } else if (LED_State == 1)
    {
      message += "ON";
    }

    //The string is sent to the server
    myClient.write(message);
  }
}