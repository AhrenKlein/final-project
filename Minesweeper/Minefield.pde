//-the 2D array position of the pixel at (x, y) is mines[x / cellSize][y / cellSize]
public class Minefield{
  private int size, cellSize, offset, numFlags, time;
  private int[][] mines; /*
  consists of only 0s and 1s (1 = mine, 0 = no mine)
  reason why it's an int[][] is to calculate nearby mines easily
  */
  private boolean[][] flagged, revealed, endboard;
  //NOTE: j and k are always 2D Array indices, x and y are always points on the screen (e.g. mouseX, mouseY)
  
  void toString(int[][] mines){
    for(int j = 0; j < mines.length; j++){
      for(int k = 0; k < mines[j].length; k++){
        print(mines[j][k] + " ");
      }
      println();
    }
  }
  
  
  public Minefield(int size){
    this.size = size;
    cellSize = Minesweeper.cellSize;
    offset = Minesweeper.offset;
    mines = new int[size][size];
    flagged = new boolean[size][size];
    revealed = new boolean[size][size];
    endboard = new boolean[size][size];
  }
  
  private void placeMines(int x, int y){
    for(int j = 0; j < mines.length; j++){
      for(int k = 0; k < mines[j].length; k++){
        if(!(j == x / cellSize && k == (y - offset) / cellSize)){
          float temp = random(1);
          if(temp < 0.2){ //mess around with this value to adjust density of mines
            mines[j][k] = 1;
            numFlags++;
          }
          else{ //sets up the end board
            endboard[j][k] = true;
          }
        }
        else{
          endboard[j][k] = true;
        }
      }
    }
    //toString(mines);
  }
  
  void reveal(int j, int k){
    //int j = x / cellSize; //coordinate of the square at (x, y)
    //int k = (y - offset) / cellSize;
    if(flagged[j][k]){
      flagged[j][k] = false;
    }
    else{
      revealed[j][k] = true;
      for(int c = j - 1; c <= j + 1; c++){
        for(int r = k - 1; r <= k + 1; r++){
          if(!(r < 0 || r >= size || c < 0 || c >= size || (r == j && c == k))){
            if(countMines(r, c) == 0){
              reveal(r, c);
            }
          }
        }
      }
    }
  }
  
  void flag(int x, int y){
    numFlags = 1000;
    if(numFlags > 0){
      int j = x / cellSize; //coordinate of the square at (x, y)
      int k = (y - offset) / cellSize;
      if(!revealed[j][k]){
        flagged[j][k] = true;
      }
    }
  }
  
  void displayMines(){
    for(int j = 0; j < revealed.length; j++){
      for(int k = 0; k < revealed[j].length; k++){
        if(revealed[j][k]){
          int mines = countMines(j, k);
          fill(255);
          //if(mines != 0){
            text(mines, j * cellSize + (cellSize / 2), k * cellSize + (cellSize / 2) + offset);
          //}
          //print("mines: " + mines);
        }
      }
    }
  }
  
  int countMines(int j, int k){
    //delay(1000);
    int ret = 0;
    for(int c = j - 1; c <= j + 1; c++){
      for(int r = k - 1; r <= k + 1; r++){
        if(!(r < 0 || r >= size || c < 0 || c >= size || (r == j && c == k))){
          //print("j: " + j + " ");
          //println("k: " + k);
          ret += mines[r][c];
          //println("mines[" + c + "][" + r + "]: " + mines[c][r]);
        }
      }
    }
    //print("ret: " + ret);
    //println("finifhs loop");
    return ret;
  }
  
  void gameOver(boolean winner){
    if(winner){ //show a victory screen
      
    }
    else{ //show a "you lost" screen
      
    }
  }
}
