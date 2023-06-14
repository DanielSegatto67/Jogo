class Bullet {

  // Variaveis
  
  PImage imgFogo;
   
  int posX;
  int posY;
  int diametro;
  int velX;
  int velY;
  boolean valido;

  //Variaveis de HitBox e dano
  int left;
  int right;
  int top;
  int bottom;
  int dano;

  //Construtor
  Bullet(int startX, int startY, int X, int Y) {
    velX = X;
    velY = Y;
    posX = startX;
    posY = startY;
    diametro = 15;
    valido = true;
    dano = 1;

    // Carrega as imagens
    imgFogo = loadImage("imagens/frostBall.png");
  }

  // Desenha objeto na tela
  void render() {
    imageMode(CENTER);
    image(imgFogo, posX, posY);
    //circle(posX,posY,diametro);
    imageMode(CORNER);
  }

  // Função responsável por mover o prejétil
  void move() {
    posX += velX;
    posY += velY;
    left = posX - (diametro/2);
    right = posX + (diametro/2);
    top = posY - (diametro/2);
    bottom = posY + (diametro/2);
  }

  // Verifica se o projétil saiu da tela e determina como inválido
  void verificaValidez(){
    if (posX<0 || posX > width-1 || posY<80 || posY > height-1) valido = false;
  }

  //Verifica se a bala acertou um inimigo
  void colisao(Enemy anEnemy){
    if (top <= anEnemy.bottom+15 && bottom >= anEnemy.top+15 && left <= anEnemy.right+16 && right >= anEnemy.left+14){
      valido = false;
      anEnemy.vida -= dano;
      if (anEnemy.vida <=0) anEnemy.vivo = false;
    }
  }
}
