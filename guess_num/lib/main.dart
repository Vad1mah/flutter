import 'package:dishes_app/range_input_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const NumberGuessApp());
}

class NumberGuessApp extends StatelessWidget {
  const NumberGuessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Угадайка',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RangeInputScreen(), // Первый экран
    );
  }
}
