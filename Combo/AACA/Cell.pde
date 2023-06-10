class Cell {
  // laver arrays til celler og regler
  int[][] board;
  int columns;
  int rows;

  int w = 20; //angiver størrelse

  Cell() {

    columns = width/w;
    rows = height/w;

    board = new int[columns][rows];
    for (int x = 0; x < columns; x++) {
      for (int y = 0; y < rows; y++) {
        int temp = int(random(100)); // gør så man kan lve forskellige chancer for forskellige gamestates credit: Morgan
        if (temp < 15) { //har 15% chance for at være vand
          board[x][y] = 3;
        } else if (temp > 80) { // har 20% chance for at være græs
          board[x][y] = 1;
        } else if (temp > 15 && temp < 25) { //har 25% chance for at være sump
          board[x][y] = 6;
        } else { // bliver til jord hvis den ikke bliver nogle af de andre
          board[x][y] = 0;
        }
       // println(board[x][y]); // Printer værdien af cellerne i starten til bug fixing
      }
    }
  }

  void generate() {
    int[][] next = new int[columns][rows];
    //går igennem hver celle
    for (int x = 1; x < columns-1; x++) { 
      for (int y = 1; y < rows-1; y++) { 
        //resetter alle naboer, vand og sump
        int neighboors = 0; 
        int water = 0;
        int swamp = 0;
        // går så igennem naboerne
        for (int i = -1; i <= 1; i++) {
          for (int j = -1; j <= 1; j++) {
            neighboors += board[x+i][y+j]; 
            if (board[x+i][y+j] == 3) { // tjekker hvor mange vand naboer der er 
              water++;
            }
            if (board[x+i][y+j] == 6) { // tjekker hvor mange sump naboer der er 
              swamp++;
            }
          }
        }
        neighboors -= board[x][y];
        //Regler:
        //Græs
        if      ((board[x][y] > 0) && (neighboors <  2) && (board[x][y] < 3)) next[x][y] = 0;
        else if ((board[x][y] > 0) && (neighboors >  3) && (board[x][y] < 3)) next[x][y] = 1;
        else if ((board[x][y] == 0) && (neighboors == 3) && (board[x][y] < 3)) next[x][y] = int(random(1, 3));
        

        //Vand
        else if ((board[x][y] > 0) && (water <  2)) next[x][y] = 0;
        else if ((board[x][y] > 0) && (water >  3)) next[x][y] = 3;
        else if ((board[x][y] == 0) && (water == 3)) next[x][y] = 3;

        //Sump
        else if ((board[x][y] > 0) && (swamp <  4)) next[x][y] = 6;
        else if ((board[x][y] > 0) && (swamp >  2)) next[x][y] = 6;
        else if ((board[x][y] == 0) && (swamp == 3)) next[x][y] = 6;
        
       
      }
    }
    board = next; //laver det næste board der er blevet udregnet til det nuværende board der bliver displayet
  }

  void cellDraw() {
    //tjekker alle celler og giver dem farver alt efter hvad de er
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
        if (board[i][j] == 1) { //græs
          //fill(#4CCE2A);
          fill(#40AA23);
        } else if (board[i][j] == 2) { //groende græs
          fill(#6BE54A);
          //fill(#DE0000); //til debug n shit af græs
        } else if (board[i][j] == 3) { //Vand
          fill(#338CFC);
        } else if (board[i][j] == 6) { //sump
          fill(#29890A);
        } else if (board[i][j] == 0){ //jord
          fill(#90630D);
        }
        stroke(0);

        rect(i*w, j*w, w, w);
      }
    }
  }
}
