//Declare variables
int pin;
int state;

void setup()
{
  //Open serial port
  Serial.begin(9600);

  //Set pins 8,9 and 10 to be output pins
  pinMode(8, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
}

void loop()
{
  //If a message is being sent from the server
  if (Serial.available() > 0)
  {
    //Read the message and store it in a variable
    String message = Serial.readStringUntil('\n');

    //Turn the various LEDs on or off depending on the message sent
    if (message == "rON")
    {
      digitalWrite(8, HIGH);
    }

    else if (message == "rOFF")
    {
      digitalWrite(8, LOW);
    }

    else if (message == "gON")
    {
      digitalWrite(9, HIGH);
    }

    else if (message == "gOFF")
    {
      digitalWrite(9, LOW);
    }

    else if (message == "yON")
    {
      digitalWrite(10, HIGH);
    }

    else if (message == "yOFF")
    {
      digitalWrite(10, LOW);
    }
  }

  //Obtain a carbon monoxide reading from the sensor and send it to the server
  int coSensor_Value = analogRead(A0);
  String coString = String(coSensor_Value, DEC);
  Serial.println(coString);

  //Pause for 100ms
  delay(100);

  //Obtain a temperature reading from the sensor and send it to the server
  uint16_t val;
  double dat;
  val = analogRead(A1);
  dat = (double) val * (5 / 10.24);
  String tempString = String(dat);
  Serial.println(tempString);

  //Pause for 500ms
  delay(500);
}
