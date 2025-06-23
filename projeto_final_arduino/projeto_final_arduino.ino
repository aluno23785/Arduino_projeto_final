#define BOTAO_PIN 2

void setup() {
  pinMode(BOTAO_PIN, INPUT_PULLUP);
  Serial.begin(9600);
}

void loop() {
  bool botaoPressionado = (digitalRead(BOTAO_PIN) == LOW);

  if (botaoPressionado) {
    Serial.println("0");
  } else {
    Serial.println("1");
  }

  delay(50);
}