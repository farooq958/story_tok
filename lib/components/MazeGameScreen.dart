import 'dart:math';
import 'package:flutter/material.dart';

class MazeGameScreen extends StatefulWidget {
  @override
  _MazeGameScreenState createState() => _MazeGameScreenState();
}

class _MazeGameScreenState extends State<MazeGameScreen> {
  int rows = 15;
  int columns = 20;
  List<List<int>> maze;

  @override
  void initState() {
    super.initState();
    maze = generateMaze();
  }

  List<List<int>> generateMaze() {
    List<List<int>> newMaze = List.generate(rows, (i) => List(columns));
    Random random = Random();

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        newMaze[i][j] = random.nextInt(2);
      }
    }
    return newMaze;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  int row = index ~/ columns;
                  int col = index % columns;

                  return Container(
                    color: maze[row][col] == 1
                        ? Colors.black
                        : Colors.transparent,
                    child: Center(
                      child: Text(
                        "$row, $col",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: rows * columns,
              ),
            ),
            RaisedButton(
              child: Text("Generate New Maze"),
              onPressed: () {
                setState(() {
                  maze = generateMaze();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}