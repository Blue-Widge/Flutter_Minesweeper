import 'package:flutter/material.dart';

class GridDisplay extends StatelessWidget {
  int width;
  int height;
  int mineNumber;
  final callback;
  int caseSize = 12;

  late List<CaseDisplay> cases;

  GridDisplay(this.width, this.height, this.mineNumber, this.callback, this.caseSize) {
    initGrid();
  }

  void initGrid()
  {
    cases = [];
    cases = List.generate(height * width, (_) => CaseDisplay(false, false, 0, callback, caseSize));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: width,
        children: cases
    );
  }
}

class CaseDisplay extends StatelessWidget
{
  bool containMine;
  bool isFlagged;
  bool isHidden = true;
  int displayedNumber;
  final callback;
  final size;

  CaseDisplay(this.containMine, this.isFlagged, this.displayedNumber, this.callback, this.size);

  void unHide() => isHidden = false;
  void changeFlagState() => isFlagged = !isFlagged;

  @override
  Widget build(BuildContext context)
  {
    return ElevatedButton(onPressed: callback, child: Text(displayedNumber.toString(), style: TextStyle(fontSize : size, color : Colors.red)));
  }

}