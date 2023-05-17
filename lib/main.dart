import 'package:flutter/material.dart';
import 'vue.dart';
import 'grille.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minesweeper',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Minesweeper'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{
  int gridWidth = 9, gridHeight = 12, mineNumber = 3;

  @override
  Widget build(BuildContext context)
  {
    double windowWidth = MediaQuery.of(context).size.width;

    double caseSize = windowWidth / 20;
    caseSize = caseSize > 24 ? 24 : caseSize;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              const Text("Minesweeper"),
              Expanded(child:
              Align(child:Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: GridDisplay(gridWidth, gridHeight, mineNumber, caseSize),
                )
              )
              )
          ]
      )
    );
  }
}