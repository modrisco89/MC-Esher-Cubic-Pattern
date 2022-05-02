// Note the following intialised variables are global variables since they're used in multiple methods.
int distort = 0; // initialise distortion variable as Integer
float redTop = random(255); // initialise redTop variable as Random float (red variable of the top triangles)
float blueTop = random(255); // initialise blueTop variable as Random float (blue variable of the top triangles)
float greeTop = random(255); // initialise greeTop variable as Random float (green variable of the top triangles)
float redRight = random(255); // initialise redRight variable as Random float (red variable of the left triangles)
float blueRight = random(255); // initialise blueRight variable as Random float (blue variable of the left triangles)
float greeRight = random(255); // initialise greeRight variable as Random float (green variable of the left triangles)
float redLeft = random(255); // initialise redLeft variable as Random float (red variable of the right triangles)
float blueLeft = random(255); // initialise blueLeft variable as Random float (blue variable of the right triangles)
float greeLeft = random(255);// initialisegreeLeft variable as Random float (green variable of the right triangles)
int count =-1; // initialise count variable as integer (this enables the for loop to know when it is even or odd in outloop of the nester loop) - global because it's used in 2 different methods.
int init = -50; // initialise initial variable as integer (this enables the the rows of cubes to fit together by adding and removing 50 pixal distance each row of cubes) - global because it's used in 2 different methods
//The Following are: Intialised boolean flag to let other methods know which type of colouring to use, set to false
boolean flagRGB=false; //used in Outerloop of DrawCube Method
boolean flagBW=false; //used in Outerloop of DrawCube Method
boolean flagRGB2=false; //used in Innerloop of DrawCube Method
boolean flagBW2=false; //used in Innerloop of DrawCube Method
boolean flagSRGB=false; //used in Outerloop of DrawSmallcube Method
boolean flagSBW=false; //used in Outerloop of DrawSmallcube Method
boolean flagSRGB2=false; //used in Innerloop of DrawSmallcube Method
boolean flagSBW2=false; //used in Innerloop of DrawSmallcube Method
int numLeft=0; //Intialised number of clicks variable as integer (This enables multiple left clicks to allow user to cycle through images), set to 0
String imgDesc = "Standard"; //Intialised String variable which is initialised as "Standard" since this is the 1st type of image that will appear.
String imgDesc2 = ""; //Intialised String variable which is initialised as "" since distortion is not always used, this is a measure of the intensity of distortion used.
int whiteDecrease=255; //Inialised int variable which is insitialised at 255, this will decrement until less than or equal to zero, see transitionBW method.
boolean shiftFlag = false;
import javax.swing.*; //Class import to enable use of JOptionPane

void setup() { // Any code that occurs within the setup() method will execute when the program is run
  size(1280, 720); // sets the size of the window to 1280x720 pixals
  frameRate(5); // FrameRate which causes draw framerate to reduce to 5 fps
  JOptionPane.showMessageDialog(null, "Please Follow Instructions:\n\nLeft Click to cycle through\ndifferent verions of MC Esher Inspired Works!\nHold down SHIFT key while left clicking to cycle in reverse\n\nPress Q or W to distort image.\nPress R to reset distortion.\n\nNote: Distortion only applies to \'Standard\' images.\n\nRight Click for a second to Save :)", "Instructions", JOptionPane.PLAIN_MESSAGE);
  //Above is the intial dialog that opens upon running, advising the user on how to use keys and mouse events to cycle, distort and save image \n is used as newline to keep everything tidy
}

void draw() {
  if (numLeft==0) {
    fill(random(255), random(255), random(255));
    textSize(100);
    text("MC Esher Inspired", 400, 360);
  }
  // No code to execute in here since the images are to be static in order for the user to save the image correctly, although it is used to enable mouse and key events.
}

void mousePressed() { //mousePressed: Code will execute upon pressing down as opposed to clicking (and releasing).
  if (mouseButton==RIGHT && (numLeft>0 && numLeft<=10)) //Condition: Code within the if statement will execute based on the right mouse button being clicked
    //and to prevent user from saving the "blank gray" image at the start (i.e numLeft = 0)
  {
    save("MC Esher Cubic Pattern - " + imgDesc.toUpperCase() + imgDesc2.toLowerCase() + ".PNG"); 
    // Save image that is right clicked on - uses string variables and string concatenation with constant strings, string variables based on the image saved. It sets the string variables to Upper case using the uppercase method and Lower Case using lowercase method
    JOptionPane.showMessageDialog(null, "Your " + imgDesc.toUpperCase() + imgDesc2.toLowerCase() + " version of an MC Esher inspired pattern has been saved\n\n Enjoy!"); 
    // Shows dialog box which prompts the user that the image is saved- uses string variables and string concatenation with constant strings, string variables (using uppercase methods/lowercase methods to set string variables to Upper case/lower case) based on the image saved.
    exit();
  }
}

void keySettings() { // Method designed to reduce the amount of code used in keyPressed Method
  colourFlags(false, false, false, false, false, false, false, false);
  //Flags above prevent the colours from randomising the colours as the user trying to distort the image to their liking,
  //the drawCube/drawSmallCube methods are called since the flags are false the colours won't randomise within those methods.
  imgDesc2 = " with distortion " + distort; 
  //this populates the imgDesc2 variable by concatenating the string constant with the variable "distort" this is a number based on the Q or R keys
  if (numLeft==1) {
    drawCube();
  } else if (numLeft==6) {
    drawCube();
    drawSmallcube();
  }
  //Based on the number of left clicks, it will redraw the image with distortion (With or without small cubes) when called in the keyPressed Method.
  if (distort >=50) {
    distort=0;
  } else if (distort <=-50) {
    distort=0;
  } else if (distort == 0) {
    imgDesc2 = "";
  }
  //If statement used either, reset the distort variable to avoid the user over distorting the image,
  //basically creating a distortion limit, if set to 0, then it resets the imgDesc2 to 0
  //this will prevent 0 from being inserted into the Text at the top left of the screen as it's not required.
  fill(255);
  textSize(10); 
  text(imgDesc.toUpperCase() + imgDesc2.toLowerCase(), 10, 10);
  //text appears with each call of this method, set to white (255) and textsize 10, this concatenates the 2 string variables (and uppercase/lowercase them) at (10,10)
}

void keyPressed() {
  if (key=='w'&& (numLeft == 1 || numLeft == 6)) {
    distort++;
    keySettings();
  } else if (key=='q'&& (numLeft == 1 || numLeft == 6)) {
    distort--;
    keySettings();
  } else if (key=='r'&& (numLeft == 1 || numLeft == 6)) {
    distort = 0;
    keySettings();
  }
  if (key == CODED) {
    if (keyCode == SHIFT) {
      shiftFlag=true;
    }
  }//If statement added to set a shift flag to true when SHIFT key is pressed, allowing the back click to work
}                                                  

void keyReleased() {
  if (key == CODED) {
    if (keyCode == SHIFT) {
      shiftFlag=false;
    }
  }//If statement added to set a shift flag to false when SHIFT key is released, disabling the back click
}
//KeyPressed Method calls the keySettings Method and increments/decrements the distort variable to give user full control of distortion by using Q and R.
//Also R is used to reset the distort variable rather than the user having to overpress keys
//Due to limitations of the code, distotion only works on Standard and Standard image 2

void colourFlags(Boolean flag1, Boolean flag2, Boolean flag3, Boolean flag4, Boolean flag5, Boolean flag6, Boolean flag7, Boolean flag8, String Desc) {
  flagRGB = flag1;
  flagBW = flag2;
  flagRGB2 = flag3;
  flagBW2 = flag4;
  flagSRGB= flag5;
  flagSBW= flag6;
  flagSRGB2= flag7;
  flagSBW2= flag8;
  imgDesc= Desc;
}
//colourFlags method created to reduce repeating the flags in each if statement below in mouseClicked(), this is called with each left click
void colourFlags(Boolean flag1, Boolean flag2, Boolean flag3, Boolean flag4, Boolean flag5, Boolean flag6, Boolean flag7, Boolean flag8) {
  flagRGB = flag1;
  flagBW = flag2;
  flagRGB2 = flag3;
  flagBW2 = flag4;
  flagSRGB= flag5;
  flagSBW= flag6;
  flagSRGB2= flag7;
  flagSBW2= flag8;
}//method overloading used
void mouseClicked() { //Mouse clicked method: all code executes based on the mouse being clicked and released

  if (mouseButton!=RIGHT && shiftFlag == false) {
    numLeft+=1;
    if (numLeft>10) {
      numLeft = 0;
      imgDesc = "";
      imgDesc2 = "";
      background(125);
    }
  }//each time the mouse is left clicked, the numLeft variable increments by 1, this enables a flag to each if statement below on which click number it's on
  if (mouseButton!=RIGHT && shiftFlag == true) {
    numLeft-=1;
    if (numLeft<1) {
      numLeft = 0;
      imgDesc = "";
      imgDesc2 = "";
      background(125);
    }
  }
  //each time the mouse is left clicked while holding shift, the numLeft variable decrements by 1, this enables a flag to each if statement below on which click number it's on
  if (mouseButton==LEFT && numLeft==1) {
    distort=0;
    imgDesc2 = "";
    colourFlags(false, false, false, false, false, false, false, false, "Standard");
    randomColours();
    drawCube();
    //if left clicked set all colour flags to false, indicate to the user which image they are currently on by setting imgDesc to "Standard", it randomises the colours
    //So when the user returns to the standard image, it will have a different colour giving more variety, drawCube(); method is called in order to draw/redraw the image.
    //This all occurs on the 1st click determined by numLeft
  } else if (mouseButton==LEFT && numLeft==2) {
    distort=0;
    imgDesc2 = "";
    colourFlags(true, false, false, false, false, false, false, false, "Multi-Coloured");
    drawCube();
    //if left clicked again set all colour flags to false except the random colours that occur in the outerloop within the drawCube Method, 
    //This prevents colouring of each cube, instead, colour each row
    //indicate to the user which image they are currently on by setting imgDesc to "Multi-Coloured"
    //drawCube(); is called to redraw
    //This all occurs on the 2nd click determined by numLeft
  } else if (mouseButton==LEFT && numLeft==3) {
    distort=0;
    imgDesc2 = "";
    colourFlags(false, true, false, false, false, false, false, false, "Black & White");
    drawCube();
    //if left clicked again set all colour flags to false except the Black and white that occur in the outerloop within the drawCube Method, 
    //This prevents colouring of each cube, instead, colour each row
    //indicate to the user which image they are currently on by setting imgDesc to "Black and White"
    //drawCube(); is called to redraw
    //This all occurs on the 3rd click determined by numLeft
  } else if (mouseButton==LEFT && numLeft==4) {
    distort=0;
    imgDesc2 = "";
    colourFlags(false, false, true, false, false, false, false, false, "Multi-Coloured 2");
    drawCube();
    //if left clicked again set all colour flags to false except the random colours that occur in the inner nested loop within the drawCube Method, 
    //This prevents colouring of each row, instead, colour each cube
    //indicate to the user which image they are currently on by setting imgDesc to "Multi-Coloured 2"
    //drawCube(); is called to redraw
    //This all occurs on the 4th click determined by numLeft
  } else if (mouseButton==LEFT && numLeft==5) {
    distort=0;
    imgDesc2 = "";
    colourFlags(false, false, false, true, false, false, false, false, "Black & White 2");
    drawCube();
    //if left clicked again set all colour flags to false except the Black and white that occur in the inner nested loop within the drawCube Method, 
    //This prevents colouring of each row, instead, colour each cube
    //indicate to the user which image they are currently on by setting imgDesc to "Black and White 2"
    //drawCube(); is called to redraw
    //This all occurs on the 5th click determined by numLeft
  } else if (mouseButton==LEFT && numLeft==6) {
    distort=0;
    imgDesc2 = "";
    colourFlags(false, false, false, false, false, false, false, false, "Standard 2");
    randomColours();
    drawCube();
    drawSmallcube();
    //if left clicked set all colour flags to false, indicate to the user which image they are currently on by setting imgDesc to "Standard 2", it randomises the colours
    //So when the user returns to the standard image, it will have a different colour giving more variety, drawCube(); AND drawSmallCube method is called in order to draw/redraw the image.
    //This all occurs on the 6th click determined by numLeft
  } else if (mouseButton==LEFT && numLeft==7) {
    distort=0;
    imgDesc2 = "";
    colourFlags(true, false, false, false, false, false, true, false, "Multi-Coloured 3");
    drawCube();
    drawSmallcube();
    //if left clicked again set all colour flags to false except the random colours that occur in the outerloop within the drawCube Method, and the innerloop of the drawSmallCube Method
    //This prevents colouring of each cube, instead, colour each row with the drawCube method and prevents colouring of each row, instead, colour each cube with the drawSmallCube method
    //indicate to the user which image they are currently on by setting imgDesc to "Multi-Coloured 3"
    //drawCube() and drawSmallCube() is called to redraw
    //This all occurs on the 7th click determined by numLeft
  } else if (mouseButton==LEFT && numLeft==8) {
    distort=0;
    imgDesc2 = "";
    colourFlags(false, true, false, false, true, false, false, false, "Black & White 3");
    drawCube();
    drawSmallcube();
    //if left clicked again set all colour flags to false except the Black and White that occur in the outerloop within the drawCube Method, and the Random colours in the outer loop of the drawSmallCube Method
    //This prevents colouring of each cube, instead, colour each row with the drawCube method and prevents colouring of each cube, instead, colour each row with the drawSmallCube method
    //indicate to the user which image they are currently on by setting imgDesc to "Black & White 3"
    //drawCube() and drawSmallCube() is called to redraw
    //This all occurs on the 8th click determined by numLeft
  } else if (mouseButton==LEFT && numLeft==9) {
    distort=0;
    imgDesc2 = "";
    colourFlags(false, false, true, false, true, false, false, false, "Multi-Coloured 4");
    drawCube();
    drawSmallcube();
    //if left clicked again set all colour flags to false except the colour that occur in the innerloop within the drawCube Method, and the Random colours in the outer loop of the drawSmallCube Method
    //This prevents colouring of each row, instead, colour each cube with the drawCube method and prevents colouring of each cube, instead, colour each row with the drawSmallCube method
    //indicate to the user which image they are currently on by setting imgDesc to "Multi-Coloured 4"
    //drawCube() and drawSmallCube() is called to redraw
    //This all occurs on the 9th click determined by numLeft
  } else if (mouseButton==LEFT && numLeft==10) {
    distort=0;
    imgDesc2 = "";
    colourFlags(true, false, false, false, false, true, false, false, "Black & White 5");
    drawCube();
    drawSmallcube();
  }
  //if left clicked again set all colour flags to false except the colour that occur in the outerloop within the drawCube Method, and the black and white in the outer loop of the drawSmallCube Method
  //This prevents colouring of each cube, instead, colour each row with the drawCube method and prevents colouring of each cube, instead, colour each row with the drawSmallCube method
  //indicate to the user which image they are currently on by setting imgDesc to "Black & White 5"
  //drawCube() and drawSmallCube() is called to redraw
  //This all occurs on the 10th click determined by numLeft
  fill(255);
  textSize(10); 
  text(imgDesc.toUpperCase() + imgDesc2.toLowerCase(), 10, 10);
  //text appears with each call of this method, set to white (255) and textsize 10, this concatenates the 2 string variables (and uppercase/lowercase them) at (10,10)
}

void drawCube() { //this method is created so it can be called several times in other methods - in summary, it draws a pattern of Large Cubes
  for (int j = 0; j<=height; j+=100) { //For loop created to cycle through ROWS until height of window is reached, incrementing at a hundred each cycle.
    if (flagRGB==true) {
      randomColours();
    } else if (flagBW==true) {
      transitionBw();
    }
    //As explained within the Mouse clicked method, depending on the flag will determine B&W or Coloured, since it's in the outloop it will repeat the same colours on each row
    count += 1;
    if (count%2!=0) {
      init = init + 50;
    } else {
      init = init - 50;
    }
    //Each time count is incremented, the code can then determine whether it is on an even or odd number, it will increment the initialised i in the nested loop by 50 on an even count
    //then decrement by 50 if on an odd count, this causes the cubes to fit together creating the pattern visualised.
    for (int i = init; i<=width; i+=100) { //For loop created to cycle through Cube until width of window is reached, incrementing at a hundred each cycle.

      if (flagRGB2==true) {
        randomColours();
      } else if (flagBW2==true) {
        transitionBw();
      }
      //As explained within the Mouse clicked method, depending on the flag will determine B&W or Coloured, since it's in the inner nested loop it will repeat the same colours on each cube
      fill(redTop, greeTop, blueTop);
      noStroke();
      triangle(i, j, i+50+distort, j-50+distort, i+50+distort, j+50+distort);
      triangle(i+100, j, i+50+distort, j-50+distort, i+50+distort, j+50+distort);
      //2 triangles placed together to form top part of the cube, with random colours
      fill(redRight, greeRight, blueRight);
      triangle(i+100, j, i+100+distort, j+50+distort, i+50+distort, j+50+distort);
      triangle(i+50, j+100, i+100+distort, j+50+distort, i+50+distort, j+50+distort);
      //2 triangles placed together to form right part of the cube, with random colours
      fill(redLeft, greeLeft, blueLeft);
      triangle(i, j, i+distort, j+50+distort, i+50+distort, j+50+distort);
      triangle(i+50, j+100, i+distort, j+50+distort, i+50+distort, j+50+distort);
      //2 triangles placed together to form left part of the cube, with random colours
    }
  }
  count = 0; //sets count back to zero so it doesn't max it's range
}
//Note: noStroke used to remove borderline to create cubes, if it wasn't there then the image wouldn't give the 3D effect intended.
//Note: distort was added to enable user to distort the image on the 2nd and 3rd corners of the triangles.
//constants added to tune the shape initially

void drawSmallcube() { //this method is created so it can be called several times in other methods - in summary, it draws a pattern of Small Cubes
  int j = -50; //j is intialised at -50 instead, used locally since it's not used anywhere else.
  while (j<=height) { //while loop used instead, very similar operation to the for loop in the previous method "drawCube"
    //while j less than the height of the window it will execute the code below:
    if (flagSRGB==true) {
      randomColours();
    } else if (flagSBW==true) {
      transitionBw();
    }
    //As explained within the Mouse clicked method, depending on the flag will determine B&W or Coloured, since it's in the inner nested loop it will repeat the same colours on each cube
    count += 1;
    if (count%2!=0) {
      init = init + 50;
    } else {
      init = init - 50;
    }
    //Each time count is incremented, the code can then determine whether it is on an even or odd number, it will increment the initialised i in the nested loop by 50 on an even count
    //then decrement by 50 if on an odd count, this causes the cubes to fit together creating the pattern visualised.
    int i = init+25;
    while (i<=width) {//init + 25 as opposed to the drawCube Method, this added due to the size of the cube being smaller and in order to fit into place.
      //Top
      if (flagSRGB2==true) {
        randomColours();
      } else if (flagSBW2==true) {
        transitionBw();
      }
      //As explained within the Mouse clicked method, depending on the flag will determine B&W or Coloured, since it's in the inner nested loop it will repeat the same colours on each cube

      noStroke();
      fill(redTop, greeTop, blueTop);
      triangle(i, j, i+25+distort, j-25+distort, i+25+distort, j+25+distort);
      triangle(i+50, j, i+25+distort, j-25+distort, i+25+distort, j+25+distort); 
      //2 triangles placed together to form top part of the cube, with random colours
      fill(redRight, greeRight, blueRight);
      triangle(i+25, j+25, i+50+distort, j+distort, i+50+distort, j+25+distort);
      triangle(i+25, j+50, i+50+distort, j+25+distort, i+25+distort, j+25+distort);
      //2 triangles placed together to form right part of the cube, with random colours
      fill(redLeft, greeLeft, blueLeft);
      triangle(i+25, j+25, i+distort, j+distort, i+distort, j+25+distort); 
      triangle(i+25, j+50, i+distort, j+25+distort, i+25+distort, j+25+distort);
      //2 triangles placed together to form left part of the cube, with random colours
      i+=100; //increments after code executes within loop before starting again
    }
    j+=100; //increments after code executes within loop before starting again
  }
  count=0; //sets count back to zero so it doesn't max it's range
}
//Note: noStroke used to remove borderline to create cubes, if it wasn't there then the image wouldn't give the 3D effect intended.
//Note: distort was added to enable user to distort the image on the 2nd and 3rd corners of the triangles.
//constants added to tune the shape initially
void randomColours() {
  redTop = random(255);
  blueTop = random(255);
  greeTop = random(255);
  redRight = random(255);
  blueRight = random(255);
  greeRight = random(255);
  redLeft = random(255);
  blueLeft = random(255);
  greeLeft = random(255);
}
//Method designed to randomise colours and avoid bulk code

void transitionBw() {
  if (whiteDecrease<=0) {
    whiteDecrease=255;
  }
  whiteDecrease-=15;
  redTop = 0;
  blueTop = 0;
  greeTop = 0;
  redRight = 125;
  blueRight = 125;
  greeRight = 125;
  redLeft = whiteDecrease;
  blueLeft = whiteDecrease;
  greeLeft = whiteDecrease;
}
//This method was designed to create the black and white imagary, it decrements the whiteDecrease variable by -15 until it reaches less than or equal t0 0 and resets it back to 255
