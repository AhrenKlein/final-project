//-the 2D array position of the pixel at (x, y) is mines[x / cellSize][y / cellSize]
public class Minefield{
  private int size, cellSize, offset, numFlags, time;
  private int[][] mines; /*
  consists of only 0s and 1s (1 = mine, 0 = no mine)
  reason why it's an int[][] is to calculate nearby mines easily
  */
  private boolean[][] flagged, revealed, endboard;
  
  public Minefield(int size){
    this.size = size;
    cellSize = Minesweeper.cellSize;
    offset = Minesweeper.offset;
    mines = new int[size][size];
    flagged = new boolean[size][size];
    revealed = new boolean[size][size];
    endboard = new boolean[size][size];
    placeMines();
  }
  
  private void placeMines(){
    for(int j = 0; j < mines.length; j++){
      for(int k = 0; k < mines[j].length; k++){
        float temp = random(1);
        if(temp < 0.2){ //mess around with this value to adjust density of mines
          mines[j][k] = 1;
          numFlags++;
        }
        else{ //sets up the end board
          endboard[j][k] = true;
        }
      }
    }
  }
  
  void reveal(int x, int y){
    int j = x / cellSize; //coordinate of the square at (x, y)
    int k = (y - offset) / cellSize;
    revealed[j][k] = true;
    stroke(50);
    fill(0);
    square(j * cellSize, k * cellSize + offset, 45);
    //println("x: " + x / 45);
    //println("y: " + y / 45);
  }
  
  void flag(int x, int y){
    numFlags = 1000;
    if(numFlags > 0){
      int j = x / cellSize; //coordinate of the square at (x, y)
      int k = y / cellSize;
      flagged[j][k] = true;
      //temporary shape 
      stroke(255);
      fill(255);
      square(j * cellSize, k * cellSize, 25);
    }
  }
  
  void displayMines(){
    for(int j = 0; j < revealed.length; j++){
      for(int k = 0; k < revealed[j].length; k++){
        if(revealed[j][k]){
          int mines = countMines(j, k);
          fill(255);
          text(mines, j * cellSize + (cellSize / 2), k * cellSize + (cellSize / 2) + offset);
          //print("mines: " + mines);
        }  
      }
    }
  }
  
  int countMines(int x, int y){
    int ret = 0;
    for(int j = x - 1; j <= x + 1; j++){
      for(int k = y - 1; k <= y + 1; k++){
        if(!(j < 0 || j >= size || k < 0 || k >= size)){
          print("j: " + j + " ");
          println("k: " + k);
          ret += mines[j][k];
        }
      }
    }
    return ret;
  }
  
  void gameOver(boolean winner){
    if(winner){ //show a victory screen
      
    }
    else{ //show a "you lost" screen
      
    }
  }
}
