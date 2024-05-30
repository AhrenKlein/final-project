private Minefield m;
private static final int cellSize = 45;
private static final int offset = 45;
private String difficulty = "EASY"; //edit this to change the difficulty
//"EASY" = easy (10 x 10), "MEDIUM" = medium (15 x 15), "HARD" = hard (20 x 20)
private int boardSize;

void setup(){ //implement difficulty
  if(difficulty.equals("EASY")){
    boardSize = 10;
  }
  else if(difficulty.equals("MEDIUM")){
    boardSize = 15;
  }
  else if(difficulty.equals("HARD")){
    boardSize = 20;
  }  
  windowResize(cellSize * boardSize, cellSize * boardSize + offset);
  background(80);
  m = new Minefield(boardSize);
}

void draw(){ //edit font and size later
  text(difficulty, 5, 15); 
  m.displayMines();
}

void mousePressed(){
  if(mouseY > offset){
    if(mouseButton == LEFT){
      m.reveal(mouseX, mouseY);
    }
    if(mouseButton == RIGHT){
      m.flag(mouseX, mouseY);
    }
  }
}
