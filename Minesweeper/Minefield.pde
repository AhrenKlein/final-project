public class Minefield{
  private int size, cellSize, offset, numFlags;
  private boolean gameOver = false;
  private int[][] mines; /*
  consists of only 0s and 1s (1 = mine, 0 = no mine)
  reason why it's an int[][] is to calculate nearby mines easily
  */
  private boolean[][] flagged, revealed, endboard;
  //NOTE: j and k are always 2D Array indices, x and y are always points on the screen (e.g. mouseX, mouseY)
  
  public Minefield(int size){
    this.size = size;
    cellSize = Minesweeper.cellSize;
    offset = Minesweeper.offset;
    mines = new int[size][size];
    flagged = new boolean[size][size];
    revealed = new boolean[size][size];
    endboard = new boolean[size][size];
  }
  
  private void placeMines(int y, int x){ //row, col
    int max = mines.length;
    int r = (y - offset) / cellSize;
    int c = x / cellSize;
    for(int j = 0; j < mines.length; j++){ //row
      for(int k = 0; k < mines[j].length; k++){ //col
        if(max == 0){
          break;
        }
        else{
          if(!(
              (k == c && j == r) ||
              (k == c && j == r + 1) ||
              (k == c && j == r - 1) ||
              (k == c + 1 && j == r) ||
              (k == c + 1 && j == r + 1) ||
              (k == c + 1 && j == r - 1) ||
              (k == c - 1 && j == r) ||
              (k == c - 1 && j == r + 1) ||
              (k == c - 1 && j == r - 1))){ //mine cannot be placed at or around the location of the first click
            float temp = random(1);
            if(temp < 0.2){ // adjust this value to change the density of mines (higher value = more dense);
              mines[j][k] = 1;
              numFlags++;
              max--;
            }
          }
        }
      }
    }
    for(int j = 0; j < endboard.length; j++){
      for(int k = 0; k < endboard[j].length; k++){
        if(mines[j][k] == 0){
          endboard[j][k] = true;
        }
      }
    }
  }
  
  void reveal(int j, int k){ //row, col
    if(flagged[j][k]){
      flagged[j][k] = false;
      numFlags++;
    }
    else{
      if(mines[j][k] == 1){
        gameOver = true;
        print("GAME OVER!");
      }
      else{
        revealed[j][k] = true;
      }
    }
  }
  
  void flag(int y, int x){
    if(numFlags > 0){
      int k = x / cellSize; //coordinate of the square at (x, y)
      int j = (y - offset) / cellSize;
      if(!revealed[j][k] && !flagged[j][k]){
        flagged[j][k] = true;
        numFlags--;
      }
    }
  }
  
  void displayMines(){
    for(int j = 0; j < revealed.length; j++){ //j = row, k = col
      for(int k = 0; k < revealed[j].length; k++){
        if(revealed[j][k]){
          int mines = countMines(j, k);
          fill(255);
          if(mines != 0){
            text(mines, k * cellSize + (cellSize / 2), j * cellSize + (cellSize / 2) + offset);
          }
          else{
            for(int r = j - 1; r <= j + 1; r++){
              for(int c = k - 1; c <= k + 1; c++){
                if(!(r < 0 || r >= size || c < 0 || c >= size || (r == j && c == k))){
                  reveal(r, c);
                }
              }
            }
          }
        }
        if(gameOver){ //show red squares revealing every mine if the game is lost
          if(mines[j][k] == 1){
            stroke(255, 0, 0);
            fill(240, 0, 0);
            square(k * cellSize + 10, j * cellSize + offset + 5, 25);
          }
        }
      }
    }
  }
  
  int countMines(int j, int k){ //row, col
    int ret = 0;
    for(int r = j - 1; r <= j + 1; r++){ //row
      for(int c = k - 1; c <= k + 1; c++){ //col
        if(!(r < 0 || r >= size || c < 0 || c >= size || (r == j && c == k))){
          ret += mines[r][c];
        }
      }
    }
    return ret;
  }
}
