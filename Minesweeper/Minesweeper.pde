private Minefield m;
private static final int cellSize = 45;
private static final int offset = 45;
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

void draw(){ //edit font and size later
  if(!m.gameOver){
    boolean alt = true;
    for(int y = offset; y < height; y += cellSize){ //creates a grid of alternating green color
      if(((y - offset) / cellSize) % 0.5 == 0){
        alt = !alt;
      }
      for(int x = 0; x < width; x += cellSize){
        int j = x / cellSize;
        int k = (y - offset) / cellSize;
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
        if(m.flagged[x / cellSize][(y - offset) / cellSize]){
          stroke(255);
          fill(255);
          square(x, y, 25);
        }
        alt = !alt;
      }
    }
    text(difficulty, 5, 15);
    toString(m.mines);
    println();
    //delay(500);
  }
  m.displayMines();
}

void mousePressed(){
  if(mouseY > offset){
    if(mouseButton == LEFT){
      if(firstClick){
       m.placeMines(mouseX, mouseY);
       firstClick = false;
      }
      m.reveal(mouseX / cellSize, (mouseY - offset) / cellSize);
    }
    if(mouseButton == RIGHT){
      m.flag(mouseX , mouseY);
    }
  }
}
