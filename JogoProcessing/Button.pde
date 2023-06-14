class Button{
  // Variáveis
  int posX;
  int posY;
  float largura;
  float altura;
  String text;
  Boolean Pressed = false;
  Boolean Clicked = false;

  //Construtor
  Button(int x, int y, int w, int h, String t){
    posX = x;
    posY = y;
    largura = w;
    altura = h;
    text = t;
  }

  // Desenha objeto na tela e verifica se o botão foi acionado
  void update(){
    fill(255);
    text(text, posX, posY);

    if (mousePressed == true && mouseButton == LEFT && Pressed == false){
      Pressed = true;
      if (mouseX>= posX-(largura/2) && mouseX <= posX + (largura/2) && mouseY >= posY - (altura/2) && mouseY <= posY + (altura/2)){
        Clicked = true;
      }
    } else{
      Clicked = false;
      Pressed = false;
    }
  }

  boolean isClicked(){
    return Clicked;
  }
}
