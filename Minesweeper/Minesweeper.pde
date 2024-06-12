private Minefield m;
private static final int cellSize = 45;
private static final int offset = 45;
private int time = 0;
private int timeOffSet = 0;
private String difficulty = "EASY"; //edit this to change the difficulty
//"EASY" = easy (10 x 10), "HARD" = hard (20 x 20)
private int boardSize;
private boolean firstClick = true;

void toString(int[][] mines){
    for(int j = 0; j < mines.length; j++){
      for(int k = 0; k < mines[j].length; k++){
        print(mines[j][k] + " ");
      }
      println();
    }
  }

void setup(){ //implement difficulty
  if(difficulty.equals("EASY")){
    boardSize = 10;
  }
  else if(difficulty.equals("HARD")){
    boardSize = 20;
  }  
  windowResize(cellSize * boardSize, cellSize * boardSize + offset);
  background(80);
  m = new Minefield(boardSize);
}

void draw(){
  if(!firstClick && isEqual(m.endboard, m.revealed)){
      m.gameOver = true;
      for(int y = offset; y < height; y += cellSize){
        for(int x = 0; x < width; x += cellSize){
          int k = x / cellSize;
          int j = (y - offset) / cellSize;
          if(m.revealed[j][k]){
            stroke(101, 216, 247);
            fill(101, 216, 247);
            square(x, y, cellSize);
          }
        }
      }
    }
  if(!m.gameOver){
      boolean alt = true;
      for(int y = offset; y < height; y += cellSize){ //creates a grid of alternating green color
        if(((y - offset) / cellSize) % 0.5 == 0){
          alt = !alt;
        }
        for(int x = 0; x < width; x += cellSize){
          int k = x / cellSize;
          int j = (y - offset) / cellSize;
          //stroke(50);
          if(m.revealed[j][k]){
            stroke(196, 164, 132); //gray
            fill(196, 164, 132);
          }
          else if(alt){
            stroke(124, 220, 10); //alternating green colors
            fill(124, 220, 10);
          }
          else{
            stroke(124, 190, 0);
            fill(124, 190, 0);
          }
          square(x, y, cellSize);
          if(m.flagged[(y - offset) / cellSize][x / cellSize]){
            stroke(255);
            fill(255);
            square(x, y, 25);
          }
          alt = !alt;
        }
      }
      println("mines: ");
      toString(m.mines);
      if(firstClick){
        time = 0;
      }
      else{
        time = (millis() - timeOffSet) / 1000;
      }
    }
  m.displayMines();
  stroke(80);
  fill(80);
  rect(0, 0, width, cellSize);
  
  textSize(20);
  fill(255);
  text(difficulty, 5, 20);
  text("flags: " + m.numFlags, cellSize * boardSize - 100, 20);
  text("time: "+ time, cellSize * boardSize / 2 - 20, 20);
}

boolean isEqual(boolean[][] first, boolean[][] second){
  String m1 = m.toString(first);
  String m2 = m.toString(second);
  return m1.equals(m2);
}

void mousePressed(){
  if(mouseY > offset){
    if(mouseButton == LEFT){
      if(firstClick){
       timeOffSet = millis();
       m.placeMines(mouseY, mouseX);
       firstClick = false;
      }
      m.reveal((mouseY - offset) / cellSize, mouseX / cellSize);
    }
    if(!firstClick && mouseButton == RIGHT){
      m.flag(mouseY , mouseX);
    }
  }
}
