import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const ColorTilesGame());
}

class ColorTilesGame extends StatelessWidget {
  const ColorTilesGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Color Tiles',
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static const int gridSize = 4;
  late List<List<bool>> grid;

  @override
  void initState() {
    super.initState();
    _initializeGrid();
  }

  void _initializeGrid() {
    final random = Random();
    setState(() {
      grid = List.generate(
        gridSize,
        (_) => List.generate(gridSize, (_) => random.nextBool()),
      );
    });
  }

  void _toggleCell(int row, int col) {
    setState(() {

      for (int i = 0; i < gridSize; i++) {
        grid[row][i] = !grid[row][i];
        grid[i][col] = !grid[i][col];
      }
      grid[row][col] = !grid[row][col];
    });
  }

  bool _checkWin() {
    final firstColor = grid[0][0];
    for (var row in grid) {
      for (var cell in row) {
        if (cell != firstColor) return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Tiles'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridSize,
                ),
                itemCount: gridSize * gridSize,
                itemBuilder: (context, index) {
                  final row = index ~/ gridSize;
                  final col = index % gridSize;
                  return GestureDetector(
                    onTap: () {
                      _toggleCell(row, col);
                      if (_checkWin()) {
                        _showWinDialog();
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4.0),
                      color: grid[row][col] ? Colors.white : Colors.black,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _initializeGrid,
                child: const Text('Restart Game'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Congratulations!'),
        content: const Text('You have made all tiles the same color!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _initializeGrid();
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }
}
