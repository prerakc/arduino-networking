//Import network library
import processing.net.*; 

//Create CLient object
Client myClient; 

//Create an array to hold the button objects
ArrayList<Button> buttons;

//Store server ip-address as a string
String ipAddress = "199.235.213.223";

String coPPM = "";
String temp = "";

void setup()
{ 
  size(640, 480); 

  //Initialize client object and button array
  myClient = new Client(this, ipAddress, 5204); 
  buttons = new ArrayList<Button>();

  //Create 3 button objects and store them in the array
  for (float i = 8; i <= 10; i++)
  {
    buttons.add(new Button(100*(i-8), i, -1));
  }
} 

void draw()
{
  clear();
  background(255);

  //If there is data being sent from the server
  if (myClient.available() > 0)
  {
    //Read the carbon monoxide and temperature readings, with a delay of 100ms in between each reading
    coPPM = myClient.readStringUntil('\n');
    delay(100);
    temp = myClient.readStringUntil('\n');
  }

  //If the data is not sent properly
  if (coPPM == null || temp == null)
  {
    fill(0, 0, 255);

    //Purge the network stream of all existing data
    myClient.clear();

    text("CO Reading (ppm): ", 450, 50);
    text("Reading..", 575, 50);

    text("Temperature (C): ", 450, 100);
    text("Reading..", 575, 100);
  }

  //If the data is sent properly
  if (coPPM != null && temp != null)
  {
    fill(0, 0, 255);

    text("CO Reading (ppm): ", 450, 50);
    text(coPPM, 575, 50);

    text("Temperature (C): ", 450, 100);
    text(temp, 575, 100);
  }

  //Draw the buttons
  drawButtons();
} 

void mouseReleased()
{
  //Use a for loop to obtain each button object
  for (int i = 0; i < 3; i++)
  {
    //Store a button object obtained from the array as this object
    Button button = buttons.get(i);

    //Check to see if each button was pressed
    if (button.checkButton() == true)
    {
      //Tell the server which button was pressed and whether to turn the LED on or off
      button.sendData();
    }
  }
}

void drawButtons()
{
  text("Red LED: ", 5, 55);
  text("Green LED: ", 5, 155);
  text("Yellow LED: ", 5, 255);

  //Use a for loop to obtain each button object
  for (int i = 0; i < 3; i++)
  {
    //Store a button object obtained from the array as this object
    Button button = buttons.get(i);

    //Draw every button
    button.drawButton();
  }
}