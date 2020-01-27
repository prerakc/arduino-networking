//Import network and serial library
import processing.net.*;
import processing.serial.*;

//Declare server and serial objects
Server myServer;
Serial myPort;

void setup()
{
  size(200, 200);

  //Store the com port being used as a string
  String portName = "COM3";

  //Initalize server and serial objects
  myServer = new Server(this, 5204); 
  myPort = new Serial(this, portName, 9600);
}

void draw()
{
  //Initalize a client object using the client connected to the server
  Client thisClient = myServer.available();

  //If there is a client connected to the server
  if (thisClient !=null)
  {
    //Read what was sent by the client
    String whatClientSaid = thisClient.readString();

    //If the client actually sent a message
    if (whatClientSaid != null)
    {
      //Write the message over the serial port to the arduino
      myPort.write(whatClientSaid);
    }
  } 

  //If there is data being sent from the arduino
  while (myPort.available() > 0)
  {
    //Obtain the carbon monoxide and temperature readings from the sensors connected to the arduino
    String coPPM = myPort.readStringUntil('\n');
    String temp = myPort.readStringUntil('\n');

    //If the carbon monoxide reading was sent properly
    if (coPPM != null)
    {
      //Send the data to the client
      myServer.write(coPPM);
    }

    //If the temperature reading was sent properly
    if (temp != null)
    {
      //Send the data to the client
      myServer.write(temp);
    }
  }
}