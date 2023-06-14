class Enemy{

  //Variaveis pra renderização e posição
  int posX;
  int posY;
  int larg;
  int alt;
  int velocidade = 3;

  //Variavel pra testar se o inimigo tá vivo
  boolean vivo;

  //Variaveis de HitBox, dano e vida
  int left;
  int right;
  int top;
  int bottom;
  int vida;
  int dano;

  int numFrames = 5;  // Numeros de frames da animação
  int currentFrame = 0;

  PImage[] images;

  int frameInterval = 200; // Intervalo de tempo em milissegundos para trocar de imagem
  int lastFrameTime = 0; // Tempo em milissegundos da última troca de imagem



  //Construtor
  Enemy(int inicioX, int inicioY, int Largura, int Altura, int hp){
    posX = inicioX;
    posY = inicioY;
    larg = Largura;
    alt = Altura;
    vivo = true;
    vida = hp;
    dano = 1;

    // Carrega as imagens
    images = new PImage[numFrames];
    images[0] = loadImage("imagens/inimigo1.png");
    images[1] = loadImage("imagens/inimigo2.png");
    images[2] = loadImage("imagens/inimigo3.png");
    images[3] = loadImage("imagens/inimigo4.png");
    images[4] = loadImage("imagens/inimigo5.png");
  }

  //Função para mostrar na tela
  void render(int PposX, int PposY){
    
    //Sistema para seguir o player 
    float targetX = PposX-(posX+37);
    if (targetX<=-2) {
      posX = posX - velocidade;
    } else if (targetX>=2) {
      posX = posX + velocidade;
    }

    float targetY = PposY-(posY+40);

    if (targetY<=-2) {
      posY = posY - velocidade;
    } else if (targetY>=2) {
      posY = posY + velocidade;
    }

    left = posX-12;
    right = posX+12;
    top = posY-12;
    bottom = posY+12;

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
      image(images[imageIndex], posX, posY);
    }

    //Verifica a colisão com o player
    if (top <= PposY-10 && bottom >= PposY-65 && left <= PposX-10 && right >= PposX-60){
      p.vida = 0;
    }
  }
}
