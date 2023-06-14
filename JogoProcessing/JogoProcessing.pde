// Importa a biblioteca para utilizar audio
import processing.sound.*;
SoundFile music, music2;

// Declara as variáveis 
int opMusica;
int velT = 30;
int aux=-800, aux2=1;
int travaTiro = 0;
int janela = 0;
int score;
int enemySpawnX, enemySpawnY;
int dificuldade;
int arma;

float aux3, aux4 = 0.5;
float randomA, randomB;
float angulo = 0;

boolean left, up, right, down;

PImage img, img2, img3, img4, img5;

Button botaoIniciar, botaoInstrucao, botaoCredito, botaoCredito2, botaoCreditoVoltar, botaoVoltarMenu, botaoVoltarJogo, BotaoHistoria, botaoFacil,
botaoMedio, botaoDificil, botaoEscolhaArma1, botaoEscolhaArma2, botaoEscolhaArma3;

Player p;
Enemy e;

ArrayList<Player> playerList;
ArrayList<Bullet> bulletList;
ArrayList<Enemy> enemyList;

void setup() {
  // Declara tamanho da tela
  size(800, 700);
  
  // Carregamento de imagens e musicas
  music = new SoundFile(this, "musicas/Hotline Miami 2 OST- Mega Drive - NARC (mp3cut.net).mp3");
  music2 = new SoundFile(this, "musicas/01. Untitled (mp3cut.net).mp3");

  img = loadImage("imagens/menuExtendido3.png");
  img2 = loadImage("imagens/jogo.jpg");
  img3 = loadImage("imagens/sagaDeArion.png");
  img4 = loadImage("imagens/dead.png");
  img5 = loadImage("imagens/frostBall3x.png");

  music(1);
  
  // Criação dos botões
  botaoIniciar = new Button(118, 200, 180, 50, "Iniciar");
  botaoInstrucao = new Button(120, 300, 200, 50, "Regras");
  BotaoHistoria = new Button(130, 400, 180, 50, "História");
  botaoCredito = new Button(135, 500, 150, 50, "Créditos");
  botaoCredito2 = new Button(600, 600, 150, 50, "Avançar");
  botaoCreditoVoltar = new Button(230, 600, 150, 50, "Voltar");
  botaoVoltarMenu = new Button(400, 600, 220, 50, "Voltar Menu");
  botaoVoltarJogo = new Button(400, 500, 220, 50, "Reiniciar");
  
  botaoFacil = new Button(400, 250, 220, 50, "Fácil");
  botaoMedio = new Button(400, 350, 220, 50, "Médio");
  botaoDificil = new Button(400, 450, 220, 50, "Difícil");

  botaoEscolhaArma1 = new Button(200, 500, 150, 50, "Single Gun");
  botaoEscolhaArma2 = new Button(400, 500, 150, 50, "Triple Gun");
  botaoEscolhaArma3 = new Button(600, 500, 150, 50, "Quad Gun");
  
  /*
  Indice janelas do jogo
   0 - menu
   1 - istrucao
   2 - historia
   3 - credito
   4 - dificuldade
   5 - arma
   6 - jogo
   7 - fim de jogo
   8 - credito 2
   */

  // Criação do player e inimigos
  p = new Player();
  e = new Enemy(100, 300, 70, 70, 5); //Cria o quadrado do inimigo 1
  
  p.reiniciar(450, 450, 1);

  playerList = new ArrayList<Player>();
  bulletList = new ArrayList<Bullet>();
  enemyList = new ArrayList<Enemy>();
}

// Corpo principal do jogo
void draw() {
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  imageMode(CORNER);
  
  background(0);
  fill(255);
  textSize(40);
  
  if (janela == 0) { 
    // MENU
    
    // Plano de fundo deslizante
    image(img, aux, 0);
    aux+=aux2;
    if (aux>0)
    {
      aux2 = -1;
    } else if (aux < -1000) {
      aux2 = 1;
    }
    image(img3, 100, 30);

    // Botão para abrir as instruções
    botaoInstrucao.update();
    if (botaoInstrucao.isClicked()) {
      janela = 1;
    }

    // Botão para abrir a história 
    BotaoHistoria.update();
    if (BotaoHistoria.isClicked()) {
      janela = 2;
    }

    // Botão para abrir os créditos 
    botaoCredito.update();
    if (botaoCredito.isClicked()) {
      janela = 3;
    }

    // Botão para inicar o jogo - 4 
    botaoIniciar.update();
    if (botaoIniciar.isClicked()) {
      janela = 4;
    }
  } 
    else if (janela == 1){ 
      // Instrucões
    image(img, aux, 0);
    aux+=aux2;
    if (aux>0){
      aux2 = -1;
    } else if (aux < -1000) {
      aux2 = 1;
    }
    textSize(60);
    text("Instruções", 410, 120);
    textSize(35);
    text("A, S, D e W - Movimentação", 400, 200);
    text("Teclas direcionais - Disparo", 400, 300);
    text("Sem vidas adicionais", 400, 400);
    text("Qualquer ferimento é mortal", 400, 500);
    textSize(40);
    
    //Botão para abrir o menu 
    botaoVoltarMenu.update();
    if (botaoVoltarMenu.isClicked()) {
      janela = 0;
    }
    
    } else if (janela == 2) {
    // História
    image(img, aux, 0);
    aux+=aux2;
    if (aux>0)
    {
      aux2 = -1;
    } else if (aux < -1000) {
      aux2 = 1;
    }
    
    //Botão para abrir o menu 
    botaoVoltarMenu.update();
    if (botaoVoltarMenu.isClicked()) {
      janela = 0;
    }
    textSize(60);
    text("História", 410, 120);
    textAlign(LEFT);
    textSize(25);
    text("O grande mago Arion, parte em uma perigosa jornada em busca", 100, 230);
    text("de uma relíquia mística, que se encontra em uma caverna amaldiçoada.", 50, 260);
    text("O poder desta relíquia é desconhecido e permitirá qualquer desejo ao ", 50, 290);
    text("seu portador. Entretanto, a ganância de Arion resultou em um caminho", 50, 320);
    text("sem volta, e para sobreviver ele deverá enfrentar as profundezas", 50, 350);
    text("do desconhecido.", 50, 380);

  } else if (janela == 3) {
    // Créditos
    image(img, aux, 0);
    aux+=aux2;
    if (aux>0)
    {
      aux2 = -1;
    } else if (aux < -1000) {
      aux2 = 1;
    }
   //Botão para abrir o menu 
    botaoVoltarMenu.update();
    if (botaoVoltarMenu.isClicked()) {
      janela = 0;
    }
    //Botão para avançar crédito 
    botaoCredito2.update();
    if (botaoCredito2.isClicked()) {
      janela = 8;
    }
    textSize(60);
    text("Desenvolvedores", 410, 120);
    
    textSize(40);
    text("Daniel Segatto Dias", 400, 300);
    text("Eduardo Augusto Berti Birello ", 400, 400);
    
  } else if (janela == 8){ 
    // Crédito 2
    image(img, aux, 0);
    aux+=aux2;
    if (aux>0){
      aux2 = -1;
    } else if (aux < -1000) {
      aux2 = 1;
    }
    textSize(45);
    text("Músicas Utilizadas", 410, 370);
    text("Imagens Utilizadas", 410, 120);
    textSize(30);
    text("Cave Walls - SlashDashGames Studio", 400, 210);
    text("Cave Background - Lil Cthulhu", 400, 270);
    text("NARC - Mega Drive", 400, 440);
    text("02 Untitled - Green Kingdom", 400, 500);
    textSize(40);
    botaoCreditoVoltar.update();
    if (botaoCreditoVoltar.isClicked()) {
      janela = 3;
    }
    botaoVoltarMenu.update();
    if (botaoVoltarMenu.isClicked()) {
      janela = 0;
    }
  
} else if (janela == 4){ 
    // Dificuldade
    image(img, aux, 0);
    aux+=aux2;
    if (aux>0){
      aux2 = -1;
    } else if (aux < -1000) {
      aux2 = 1;

      botaoVoltarMenu.update();
      if (botaoVoltarMenu.isClicked()) {
        janela = 0;
      }
    }
    textSize(60);
    text("Dificuldade", 410, 120);
    textSize(40);
    botaoFacil.update();
    botaoMedio.update();
    botaoDificil.update();
    botaoVoltarMenu.update();

    if (botaoFacil.isClicked()){
      janela = 5;
      dificuldade = 1;
    } else if (botaoMedio.isClicked()){
      janela = 5;
      dificuldade = 2;
    } else if (botaoDificil.isClicked()){
      janela = 5;
      dificuldade = 3;
    } else if (botaoVoltarMenu.isClicked()){
      janela = 0;
    }
  } else if (janela == 5){ 
    // Seleção de Armas
    image(img, aux, 0);
    aux+=aux2;
    if (aux>0){
      aux2 = -1;
    } else if (aux < -1000) {
      aux2 = 1;
    }
    textSize(60);
    text("Armas", 410, 120);
    textSize(40);
    botaoEscolhaArma1.update();
    image(img5,180,aux3 + 300);
    
    image(img5,410,aux3 + 300);
    image(img5,350,aux3 + 250);
    image(img5,350,aux3 + 350);
    
    image(img5,540,aux3 + 300);
    image(img5,620,aux3 + 300);
    image(img5,580,aux3 + 250);
    image(img5,580,aux3 + 350);
    
    aux3 += aux4;
    
    if(aux3>20){
      aux4 = -0.5;
    }
      
    else if(aux3<-10){
      aux4 = 0.5;
    }
    
    if (botaoEscolhaArma1.isClicked()) {
      arma = 1;
      janela = 6;
    }
    botaoEscolhaArma2.update();
    if (botaoEscolhaArma2.isClicked()) {
      arma = 2;
      janela = 6;
    }

    botaoEscolhaArma3.update();
    if (botaoEscolhaArma3.isClicked()) {
      arma = 3;
      janela = 6;
    }

    botaoVoltarMenu.update();
    if (botaoVoltarMenu.isClicked()) {
      janela = 0;
    }
  } else if (janela == 6){
    image(img2, 0, 0);
    inimigosTela();
    fill(255, 255, 255);
    rect(400, 40, 800, 80);
    fill(0, 0, 0);
    text("score:", 80, 30);
    text(score, 160, 30);
    p.movimento();
    p.display();
    if (p.vida == 0){
      playerList.remove(p);
      
      //Loop que apaga os inimigos mortos
      for (int x = enemyList.size()-1; x>=0; x--) {
        Enemy anEnemy = enemyList.get(x);
        enemyList.remove(anEnemy);
      }
      p.reiniciar(450, 450, 1);
      music.stop();
      music(2);
      janela = 7;
    }

    // loop para todas bullet
    //Loop que percorre o vetor dos tiros; renderiza, movimenta e checa a colisão com a borda da tela e com inimigos
    for (Bullet aBullet : bulletList){
      aBullet.render();
      aBullet.move();
      aBullet.verificaValidez();

      //Percorre o vetor dos inimigos pra detectar a colisão com eles
      for (Enemy anEnemy : enemyList){
        aBullet.colisao(anEnemy);
      }
    }

    // Loop que apaga as balas invalidas(fora da tela ou que acertaram alguem)
    for (int i = bulletList.size()-1; i>=0; i--) {
      Bullet aBullet = bulletList.get(i);
      if (aBullet.valido == false) bulletList.remove(aBullet);
    }

    //Percorre o vetor dos inimigos e renderiza eles
    for (Enemy anEnemy : enemyList) {
      anEnemy.render(p.posX, p.posY);
    }

    //Loop que apaga os inimigos mortos
    for (int x = enemyList.size()-1; x>=0; x--) {
      Enemy anEnemy = enemyList.get(x);
      if (anEnemy.vivo == false)
      {
        enemyList.remove(anEnemy);
        score += 1;
      }
    }
  } else if (janela == 7){
    // Fim de jogo
    image(img, 0, 0);
    text("Você Morreu", 410, 120);
    text("Score:", 380, 180);
    text(score,480,180);
    botaoVoltarJogo.update();
    if (botaoVoltarJogo.isClicked()) {
      janela = 6;
      music2.stop();
      music(1);
      score = 0;
    }

    botaoVoltarMenu.update();
    if (botaoVoltarMenu.isClicked()) {
      janela = 0;
      music2.stop();
      music(1);
      score = 0;
    }

    translate((width/2)+15, height/2);  // Move o sistema de coordenadas para o centro da janela
    rotate(angulo);  // Rotaciona a imagem
    imageMode(CENTER);  // Define o modo de exibição da imagem como o centro
    image(img4, 0, 0);  // Exibe a imagem no centro da janela

    angulo += 0.01;  // Incrementa o ângulo de rotação

    if (angulo >= TWO_PI) {
      angulo = 0;  // Reinicia o ângulo quando uma volta completa for alcançada
    }
  } 
}

// Verifica se as teclas foram precionadas
void keyPressed() {
  
  if (key == 'w')
    p.cima = true;
  if (key == 'd')
    p.direita = true;
  if (key == 's')
    p.baixo = true;
  if (key == 'a')
    p.esquerda = true;

  switch(keyCode) {
  case 37:
    if (travaTiro == 0) {
      //Esquerda
      if (arma == 1) {
        bulletList.add(new Bullet(p.posX-56, p.posY-24, -velT, 0));
      } else if (arma == 2) {
        bulletList.add(new Bullet(p.posX-48, p.posY-24, -velT, (-velT/5)));
        bulletList.add(new Bullet(p.posX-48, p.posY-24, -velT, 0));
        bulletList.add(new Bullet(p.posX-48, p.posY-24, -velT, (velT/5)));
      } else {
        quadGun();
      }
      travaTiro = 1;
    }
    break;

  case 38:
    if (travaTiro == 0) {
      //Cima
      if (arma == 1) {
        bulletList.add(new Bullet(p.posX-20, p.posY-55, 0, -velT));
      } else if (arma == 2) {
        bulletList.add(new Bullet(p.posX-20, p.posY-55, (-velT/5), -velT));
        bulletList.add(new Bullet(p.posX-20, p.posY-55, 0, -velT));
        bulletList.add(new Bullet(p.posX-20, p.posY-55, (velT/5), -velT));
      } else {
        quadGun();
      }

      travaTiro = 1;
    }
    break;

  case 39:
    if (travaTiro == 0) {
      //Direita
      if (arma == 1) {
        bulletList.add(new Bullet(p.posX+7, p.posY-20, velT, 0));
      } else if (arma == 2) {
        bulletList.add(new Bullet(p.posX+7, p.posY-20, velT, (-velT)/5));
        bulletList.add(new Bullet(p.posX+7, p.posY-20, velT, 0));
        bulletList.add(new Bullet(p.posX+7, p.posY-20, velT, (velT)/5));
      } else {
        quadGun();
      }
    }
    break;

  case 40:
    if (travaTiro == 0) {
      //Baixo
      if (arma == 1) {
        bulletList.add(new Bullet(p.posX-20, p.posY+8, 0, +velT));
      } else if (arma == 2) {
        bulletList.add(new Bullet(p.posX-20, p.posY+8, (velT/5), velT));
        bulletList.add(new Bullet(p.posX-20, p.posY+8, 0, velT));
        bulletList.add(new Bullet(p.posX-20, p.posY+8, (-velT/5), velT));
      } else {
        quadGun();
      }

      travaTiro = 1;
    }
    break;
  }
}

// Verifica se as teclas foram liberadas
void keyReleased() {
  if (key == 'w')
    p.cima = false;
  if (key == 'd')
    p.direita = false;
  if (key == 's')
    p.baixo = false;
  if (key == 'a')
    p.esquerda = false;

  switch(keyCode) {
  case 37:
    travaTiro = 0;
    break;
  case 38:
    travaTiro = 0;
    break;
  case 39:
    travaTiro = 0;
    break;
  case 40:
    travaTiro = 0;
    break;
  }
}

void inimigosTela(){
  if (enemyList.size()< dificuldade + 1){
    criarInimigo();
  }
}

void criarInimigo(){
  
  randomA = random(8);

  switch((int)randomA) {
  case 0:
    enemySpawnX = -20;
    enemySpawnY = 400;
    break;
  case 1:
    enemySpawnX = 820;
    enemySpawnY = 400;
    break;
  case 2:
    enemySpawnX = 400;
    enemySpawnY = 760;
    break;
  case 3:
    enemySpawnX = 400;
    enemySpawnY = 80;
    break;
    case 4:
    enemySpawnX = -20;
    enemySpawnY = 100;
    break;
  case 5:
    enemySpawnX = -20;
    enemySpawnY = 700;
    break;
  case 6:
    enemySpawnX = 800;
    enemySpawnY = 100;
    break;
  case 7:
    enemySpawnX = 800;
    enemySpawnY = 700;
    break;
  }

  e.vivo = true;
  e = new Enemy(enemySpawnX, enemySpawnY, 32, 32, 3); //Cria o quadrado do inimigo
  enemyList.add(e);
}

void music(int x) {
  int opMusica = x;

  if (opMusica == 1) {
  music.loop();
}
  else if (opMusica == 2) music2.loop();
}

void quadGun(){
  
 bulletList.add(new Bullet(p.posX-48, p.posY-24, -velT, 0));
 bulletList.add(new Bullet(p.posX-20, p.posY-55, 0, -velT));
 bulletList.add(new Bullet(p.posX+7, p.posY-20, velT, 0));
 bulletList.add(new Bullet(p.posX-20, p.posY+8, 0, velT));
 
}
