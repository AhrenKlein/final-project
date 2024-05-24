
public class Minefield{
  private int rows, cols, cellSize, numFlags, time;
  private int[][] mines; /*
  consists of only 0s and 1s (1 = mine, 0 = no mine)
  reason why it's an int[][] is to calculate nearby mines easily
  */
  private boolean[][] flagged, revealed, endboard;
  
  public Minefield(int rows, int cols){
    this.rows = rows;
    this.cols = cols;
  }
  
  void placeMines(){
    for(int j = 0; j < mines.length; j++){
      for(int k = 0; k < mines[j].length; k++){
        float temp = random(1);
        if(temp < 0.2){ //mess around with this value to adjust density of mines
          mines[j][k] = 1;
        }
      }
    }
  }
  
  void reveal(int x, int y){
    
  }
  
  void flag(int x, int y){
    
  }
  
  void displayMines(){
    
  }
  
  void countMines(){
    
  }
  
  void gameOver(boolean winner){
    
  }
}
