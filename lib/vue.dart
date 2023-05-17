import 'package:flutter/material.dart';
import 'settings.dart';
import 'grille.dart';

class GridDisplay extends StatefulWidget
{
  int width;
  int height;
  int difficulty = Difficulty.MEDIUM;
  int mineNumber;
  double caseSize = 12;
  GridDisplay(this.width, this.height, this.mineNumber, this.caseSize);

  @override
  State<StatefulWidget> createState() => _GridDisplay(width, height, mineNumber, caseSize);
}

class _GridDisplay extends State<GridDisplay>
{
  int width;
  int height;
  int difficulty = Difficulty.MEDIUM;
  int mineNumber;
  double caseSize = 12;
  late final Grid minesweeper;
  late List<CaseDisplay> cases;

  _GridDisplay(this.width, this.height, this.mineNumber, this.caseSize)
  {
    minesweeper = Grid(width, height, difficulty);
    initGrid();
  }

  void callback(int caseIndex, bool isBomb)
  {
    print("CALLBACK CALLED");
    if(isBomb)
    {
      cases[caseIndex].displayedNumber = Cases.ACTIVATED_BOMB;
      int size = width * height;
      for(int i = 0; i < size; ++i)
      {
        if(cases[i].containMine)
        {
          cases[i].state.unHide();
        }
      }
    }
    cases[caseIndex].state.unHide();
  }
  void initGrid()
  {
    cases = [];
    cases = List.generate(height * width, (index) => CaseDisplay(index, false, 0, callback, caseSize));
    for(int i = 0; i < height; ++i)
      {
        for (int j = 0; j < width; ++j)
          {
            initCaseNumber(i, j);
            cases[i * width + j].containMine = minesweeper.grid[i][j] == Cases.BOMB;
          }
      }
  }

  void initCaseNumber(int line, int col)
  {
    int counter = 0;
    if (line != 0)
      {
        counter += (minesweeper.grid[line-1][col] == Cases.BOMB) ? 1 : 0;
        if (col != 0)
          counter += (minesweeper.grid[line-1][col-1] == Cases.BOMB) ? 1 : 0;
        if (col != width - 1)
          counter += (minesweeper.grid[line-1][col+1] == Cases.BOMB) ? 1 : 0;
      }
    if (col != 0)
      counter += (minesweeper.grid[line][col-1] == Cases.BOMB) ? 1 : 0;
    if (col != width - 1)
      counter += (minesweeper.grid[line][col+1] == Cases.BOMB) ? 1 : 0;
    if (line != height - 1)
    {
      counter += (minesweeper.grid[line+1][col] == Cases.BOMB) ? 1 : 0;
      if (col != 0)
        counter += (minesweeper.grid[line+1][col-1] == Cases.BOMB) ? 1 : 0;
      if (col != width - 1)
        counter += (minesweeper.grid[line+1][col+1] == Cases.BOMB) ? 1 : 0;
    }
    cases[line * width + col].displayedNumber = counter;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: width,
        children: cases
    );
  }
}

class CaseDisplay extends StatefulWidget
{
  int caseIndex;
  bool containMine;
  int displayedNumber;
  final callback;
  double size;
  late _CaseDisplayState state;

  CaseDisplay(
      this.caseIndex,
      this.containMine,
      this.displayedNumber,
      this.callback,
      this.size,
      );

  @override
  State<StatefulWidget> createState()
  {
    state = _CaseDisplayState();
    return state;
  }
}

class _CaseDisplayState extends State<CaseDisplay> {
  bool isFlagged = false;
  bool isHidden = true;

  void unHide()
  {
    setState(()
    {
      isHidden = false;
    });
  }

  void changeFlagState()
  {
    setState(()
    {
      isFlagged = !isFlagged;
    });
  }

  @override
  Widget build(BuildContext context) {
    String toDisplay = isHidden ? " " : widget.displayedNumber.toString();

    return Container(
      color: const Color(0xFFBBBBBB),
      child: ElevatedButton(
        onPressed: () {
          widget.callback(widget.caseIndex, widget.containMine);
        },
        child: Text(
          toDisplay,
          style: TextStyle(fontSize: widget.size, color: Colors.red),
        ),
      ),
    );
  }
}
