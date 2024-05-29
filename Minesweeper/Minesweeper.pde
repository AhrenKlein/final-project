private Minefield m;
private static final int cellSize = 45;
private String difficulty = "MEDIUM"; //edit this to change the difficulty
//"EASY" = easy, "MEDIUM" = medium, "HARD" = hard

void setup(){
  size(450, 450);
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
