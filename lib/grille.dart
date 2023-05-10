
class Grid
{
  int width;
  int height;
  List<List<int>>? grid;

  Grid(this.width, this.height)
  {
    grid = List.generate(height, (_) => List.generate(width, (_) => 0));
  }

  void resetGrid()
  {
    for(int i = 0; i < height; ++i)
    {
      for(int j = 0; j < width; ++j)
      {
        grid![i][j] = 0;
      }
    }
  }

  void initializeGrid()
  {
    for(int i = 0; i < height; ++i)
      {
        for(int j = 0; j < width; ++j)
          {

          }
      }
  }
}
