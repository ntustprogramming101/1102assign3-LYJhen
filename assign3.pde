final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;
int block = 80;
float lifeCount = 2;


final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil8x24;
PImage soil0,soil1,soil2,soil3,soil4,soil5;
PImage stone1,stone2;

PImage life;

PImage groundhogIdle;
float groundhogX = 4*block;
float groundhogY = block;  
float groundhogXPlus;
float groundhogYPlus;
PImage groundhogDown;
PImage groundhogRight;
PImage groundhogLeft;
int groundhogStat;
int timer;
final int GH_IDLE=0, GH_DOWN=1, GH_RIGHT=2, GH_LEFT=3;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	soil8x24 = loadImage("img/soil8x24.png");
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  life= loadImage("img/life.png");
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

		// Background
		image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
		
    for(int x=0; x<width; x+=block){
       for(int o=160; o<480; o+=block){
         image(soil0, x,o);
      }
    }
   //for(int y=480; y<800; y+=block){
     // image(soil1, block, block);
     // for(int x=0; x<width; x+=block){
     // }
    //}
		// Player
      //Draw hog
    switch(groundhogStat){
    case GH_IDLE:
      image(groundhogIdle,groundhogX,groundhogY);
      break;
    case GH_DOWN:
      image(groundhogDown,groundhogX,groundhogY);
      timer+=1;
      groundhogY+=80.0/15;
      break;
    case GH_RIGHT:
      image(groundhogRight,groundhogX,groundhogY);
      timer+=1;
      groundhogX+=80.0/15;
      break;
    case GH_LEFT:
      image(groundhogLeft,groundhogX,groundhogY);
      timer+=1;
      groundhogX-=80.0/15;
      break;
    }
    //check timer
    if(timer==15){
      groundhogStat=GH_IDLE;
    if(groundhogY%block<30){//fix float point offset
      groundhogY=groundhogY-groundhogY%block;
      }else{
      groundhogY=groundhogY-groundhogY%block+block;
      }
    if(groundhogX%block<30){
      groundhogX=groundhogX-groundhogX%block;
      }else{
      groundhogX=groundhogX-groundhogX%block+block;
      }
      //println(hogX);
      //println(hogY);
      timer=0;
   }

		// Health UI
     image(life,10,10);
     image(life,80,10);   

		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here
    if(key ==CODED){
    switch(keyCode){
      case DOWN:
        if(groundhogY+block<height&&groundhogStat==GH_IDLE){
          groundhogStat=GH_DOWN;
          timer=0;
        }
        break;
      case RIGHT:
        if(groundhogX+block<width&&groundhogStat==GH_IDLE){
          groundhogStat=GH_RIGHT;
          timer=0;
        }
        break;
      case LEFT:
        if(groundhogX>0&&groundhogStat==GH_IDLE){
         groundhogStat=GH_LEFT;
          timer=0;
      break;
    }}
  }
	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){
}
