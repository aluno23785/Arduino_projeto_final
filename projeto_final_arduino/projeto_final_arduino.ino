#define BOTAO_PIN 2
#define BUZZER 5

void setup() {
  pinMode(BOTAO_PIN, INPUT_PULLUP);
  pinMode(BUZZER, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  bool botaoPressionado = (digitalRead(BOTAO_PIN) == LOW);


  if (botaoPressionado) {
    Serial.println("0");
      noTone(BUZZER);//Sets the voltage to low and makes no noise
  } else {
    Serial.println("1");
   Bird_sound();
  }

  delay(50);
}

void Bird_sound(){
    tone(BUZZER, 1500, 10); 
  delay(10);
  tone(BUZZER, 1800, 50);
  delay(10);
  tone(BUZZER, 2200, 30);  
  delay(10);
  tone(BUZZER, 2000, 20); 
  delay(10);
  noTone(BUZZER);
}