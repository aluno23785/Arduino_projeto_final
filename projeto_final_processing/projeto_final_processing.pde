import processing.serial.*;
Serial myPort; // Porta série
bird b = new bird();
pillar[] p = new pillar[3];
boolean end = false;
boolean intro = true;
int score = 0;
PImage sky_background;

void setup() {
   myPort = new Serial(this, "COM4", 9600);
  myPort.clear(); // Limpa buffer inicial
  size(500, 800);
  smooth(4);
  sky_background=loadImage("sky_background.jpg");
  sky_background.resize(500,800);
  // Inicializar porta série


  for (int i = 0; i < 3; i++) {
    p[i] = new pillar(i);
  }
}

void draw() {
background(sky_background);
 while (myPort.available() > 0) {
    String valor = myPort.readStringUntil('\n');
    if (valor != null) {
      valor = valor.trim(); // remover espaços e \n
      if (valor.equals("1")) {
        b.jump();
        intro = false;
        if (end == false) {
          reset();
        }
      }
    }
  }
  // Leitura da serial


  if (end) {
    b.move();
  }
  b.drawBird();

  if (end) {
    b.drag();
  }
  b.checkCollisions();

  for (int i = 0; i < 3; i++) {
    p[i].drawPillar();
    p[i].checkPosition();
  }

  fill(0);
  stroke(255);
  textSize(32);

  if (end) {
    rect(20, 20, 100, 50);
    fill(255);
    text(score, 30, 58);
  } else {
    rect(150, 100, 200, 50);
    fill(255);
    if (intro) {
      text("Flappy Duck", 155, 140);
    } else {
      text("game over", 170, 140);
      fill(0);
      rect(150, 200, 200, 50);
      fill(255);
      text("score", 180, 240);
      text(score, 280, 240);
    }
  }
}

class bird {
  float xPos, yPos, ySpeed;

  bird() {
    xPos = 250;
    yPos = 400;
  }

  void drawBird() {
   
    stroke(255);
    fill(255, 255, 0);
    strokeWeight(2);
    ellipse(xPos, yPos, 20, 20);
   fill(0);
    ellipse(xPos+3, yPos-3, 7, 7);
     fill(200);
    ellipse(xPos+7, yPos+5, 17, 9);
  }

  void jump() {
    ySpeed = -10;
  }

  void drag() {
    ySpeed += 0.4;
  }

  void move() {
    yPos += ySpeed;
    for (int i = 0; i < 3; i++) {
      p[i].xPos -= 3;
    }
  }

  void checkCollisions() {
    if (yPos > 800) {
      end = false;
    }
    for (int i = 0; i < 3; i++) {
      if ((xPos < p[i].xPos + 50 && xPos > p[i].xPos - 10) && 
          (yPos < p[i].opening - 100 || yPos > p[i].opening + 100)/*&&
          (xPos >= p[i].xPos  ||xPos <= p[i].xPos +50)*/) {
        end = false;
      }
    }
  }
}

class pillar {
  float xPos, opening;
  boolean cashed = false;
float R=random(255);
float G=random(255);
float B=random(255);


  pillar(int i) {
    xPos = 400 + (i * 200);
    opening = random(600) + 100;
   
  }

  void drawPillar() {
    fill(R,G,B);
    stroke(random(180,255));
    rect(xPos, opening - 100 ,50,  -opening);
    rect(xPos, opening + 100, 50, 800);
  }

  void checkPosition() {
    if (xPos < 0) {
      xPos += (200 * 3);
      opening = random(600) + 100;
      cashed = false;
    }
    if (xPos < 250 && cashed == false) {
      cashed = true;
      score++;
    }
  }
}

void reset() {
  end = true;
  score = 0;
  b.yPos = 400;
  for (int i = 0; i < 3; i++) {
    p[i].xPos += 550;
    p[i].cashed = false;
  }
}


}
