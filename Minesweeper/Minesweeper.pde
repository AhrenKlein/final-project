private Minefield m;
private final int cellSize = 40;

void setup(){
  size(800, 800);
  background(80);
  m = new Minefield(10);
}

void draw(){
  
}

void mousePressed(){
  if(mouseButton == LEFT){
    m.reveal(mouseX, mouseY);
  }
  if(mouseButton == RIGHT){
    m.flag(mouseX, mouseY);
  }
}
