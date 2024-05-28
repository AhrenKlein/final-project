
public class Minefield{
  private int size, cellSize, numFlags, time;
  private int[][] mines; /*
  consists of only 0s and 1s (1 = mine, 0 = no mine)
  reason why it's an int[][] is to calculate nearby mines easily
  */
  private boolean[][] flagged, revealed, endboard;
  
  public Minefield(int size){
    this.size = size;
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
        }
        else{ //sets up the end board
          endboard[j][k] = true;
        }
      }
    }
  }
  
  void reveal(int x, int y){
    //stroke(0);
    //fill(0);
    //circle(x, y, 50);
  }
  
  void flag(int x, int y){
    //stroke(255);
    //fill(255);
    //circle(x, y, 50);
  }
  
  void displayMines(){
    for(int j = 0; j < revealed.length; j++){
      for(int k = 0; k < revealed[j].length; k++){
        if(revealed[j][k]){
          int mines = countMines(j, k);
          //print the value at the square (not sure how to do that yet)
        }  
      }
    }
  }
  
  int countMines(int x, int y){
    int ret = 0;
    for(int j = x - 1; j <= x + 1; j++){
      for(int k = y - 1; k <= y + 1; k++){
        if(!(j < 0 || j >= size || y < 0 || y >= size)){
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
