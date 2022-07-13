PImage background, bird, cano, menu;
PFont font;

boolean playing, gameover = false;

int backX, y, vy, score = 0, highScore = 0, backSpeed = 2;

int[] canoX = new int[2];
int[] canoY = new int[2];

void setup() {
  if (highScore>=10) {
    backSpeed++;
  }

  frameRate(60);
  background = loadImage("background1.png");
  bird = loadImage("bird.png");
  cano = loadImage("cano.png");
  menu = loadImage("menu.png");
  font = createFont("AtariSmall.ttf", 22);


  playing = false;

  size(600, 800);
}

void draw () {
  if (backX == -1200) backX = 0;

  if (!playing) {
    println(keyCode);

    canoX[0] = 600;
    canoY[0] = height/2;
    canoX[1] = 900;
    canoY[1] = 600;
    y = 50;
    vy = 0;
    backX = 0;
    
    imageMode(CENTER);
    image(menu, width/2, height/2);

    fill(255);
    textFont(font);
    textAlign(CENTER, CENTER);
    text("press < W > to jump", width/2, height/2);
    text("and press < SPACE > to play!", width/2, height/2 + 30);

    textSize(40);
    text("High Score = " + highScore, width/2, height/2 + 90);

    if (gameover) {
      textSize(40);
      text("Try again!", width/2, 130);
    }
  }

  if (playing) {
    imageMode(CORNER);
    image(background, backX, 0);
    image(background, backX+background.width, 0);
    backX = backX-backSpeed;

    textSize(50);
    bird();
    cano();
    text(score, width/2, 30);
  }
}

void bird () {
  imageMode(CENTER);
  image(bird, width/2, y);
  vy = vy+1;
  y = y+vy;
}

void cano () {
  for (int i=0; i<2; i++) {
    imageMode(CENTER);
    image(cano, canoX[i], canoY[i] - (cano.height/2+100));
    image(cano, canoX[i], canoY[i] + (cano.height/2+100));
    canoX[i] = canoX[i] - 2;

    if (canoX[i] < 0) {
      canoY[i]= (int)random(200, height-200);
      canoX[i] = width;
    }

    if (canoX[i] == width/2) {
      score++;
      highScore = max(score, highScore);
    }
    if (y>height || y<0 || (abs(width/2-canoX[i])<40 && abs(y-canoY[i])>90)) {
      playing = false;
      score = 0;
      gameover = true;
    }
  }
}

void keyPressed() {
  if (keyCode == 87) {
    vy = -16;
  }

  if (keyCode == 32 && !playing) {
    playing = true;
    gameover = false;
  }
}
