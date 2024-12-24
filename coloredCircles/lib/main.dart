import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class Circle {
  Color color;
  double top;
  double left;

  Circle({required this.color, required this.top, required this.left});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
  List<Circle> circles = [];
  Color rectangleColor = Colors.blue;
  int circleCount = 5;
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    _initializeCircles();
  }

  void _initializeCircles() {
    List<Color> colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.purple
    ];

    for (int i = 0; i < circleCount; i++) {
      circles.add(Circle(
        color: colors[i % colors.length],
        top: Random().nextDouble() * 300,
        left: Random().nextDouble() * 300,
      ));
    }
  }

  void _onCircleDropped(Color circleColor) {
    setState(() {
      rectangleColor = circleColor;
      circles.removeWhere((circle) => circle.color == circleColor);

      if (circles.isEmpty) {
        gameOver = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Circle Game"),
      ),
      body: Center(
        child: Stack(
          children: [
            ...circles.map((circle) {
              return Positioned(
                top: circle.top,
                left: circle.left,
                child: Draggable<Color>(
                  data: circle.color,
                  feedback: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: circle.color,
                    ),
                  ),
                  childWhenDragging: Container(),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: circle.color,
                    ),
                  ),
                ),
              );
            }),
            Positioned(
              top: 400,
              left: 100,
              child: DragTarget<Color>(
                onAcceptWithDetails: (details) {
                  _onCircleDropped(details.data);
                },
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    width: 200,
                    height: 100,
                    color: rectangleColor,
                    child: Center(
                      child: Text(
                        gameOver ? "Игра завершена!" : "Перетащите кружок",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
