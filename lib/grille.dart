import 'settings.dart';
import 'dart:math';

class Grid
{
  int width;
  int height;
  late List<List<int>> grid;
  int nbBombs;

  Grid(this.width, this.height, this.nbBombs)
  {
    grid = List.generate(height, (_) => List.generate(width, (_) => Cases.EMPTY));
    initializeGrid();
  }

  void resetGrid()
  {
    for(int i = 0; i < height; ++i)
    {
      for(int j = 0; j < width; ++j)
      {
        grid[i][j] = 0;
      }
    }
  }

  void initializeGrid()
  {
    Random random = Random();
    for(int i = 0; i < nbBombs; ++i)
      {
        int line = random.nextInt(height);
        int col = random.nextInt(width);
        while(grid[line][col] == Cases.BOMB)
          {
            line = random.nextInt(height);
            col = random.nextInt(width);
          }
          grid[line][col] = Cases.BOMB;
      }
  }
}
