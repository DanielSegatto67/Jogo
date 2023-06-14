class Player {
  //Variáveis 
  int posX, posY, w, h;
  int velX, velY;
  int vel = 3;
  int vida;
  int left, right, top, bottom;
  int numFrames = 4;  // The number of frames in the animation
  int currentFrame = 0;
  int frameInterval = 150; // Intervalo de tempo em milissegundos para trocar de imagem
  int lastFrameTime = 0; // Tempo em milissegundos da última troca de imagem
  
  boolean esquerda, direita, cima, baixo;

  PImage[] images;

  // Constructor
  Player() {

    w = 32;
    h = 32;

    // Carregar as imagens no bloco de inicialização
    images = new PImage[numFrames];
    images[0] = loadImage("imagens/player1.png");
    images[1] = loadImage("imagens/player2.png");
    images[2] = loadImage("imagens/player3.png");
    images[3] = loadImage("imagens/player4.png");
  }

  // Desenha o objeto na tela
  void display() {
    rectMode(CENTER);
    fill(237, 121, 255);

    // Verificar se é hora de trocar a imagem
    int currentTime = millis();
    if (currentTime - lastFrameTime >= frameInterval) {
      currentFrame = (currentFrame + 1) % numFrames;
      lastFrameTime = currentTime;
    }

    for (int x = -100; x < width; x += images[0].width) {
      int imageIndex = (currentFrame + x / images[0].width) % numFrames;
      if (imageIndex < 0) {
        imageIndex += numFrames; // Evita um índice negativo
      }
      image(images[imageIndex], posX-49, posY-57);
      //rect(posX-20,posY-20,45,45);
    }
  }

  // Altera a posição do player
  void movimento() {
    if (cima == true && posY > 133)
      posY -= vel;
    if (direita == true && posX < width - 45)
      posX += vel;
    if (baixo == true && posY < height - 35)
      posY += vel;
    if (esquerda == true && posX > 45)
      posX -= vel;

    left = posX;
    right = posX;
    top = posY;
    bottom = posY;
  }

  // Configura para iniciar/ reiniciar jogo
  void reiniciar(int x, int y, int hp) {
    posX = x;
    posY = y;
    vida = hp;
  }
}
