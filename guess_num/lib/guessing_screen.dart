import 'package:flutter/material.dart';

class GuessingScreen extends StatefulWidget {
  final int min;
  final int max;

  const GuessingScreen({super.key, required this.min, required this.max});

  @override
  State<GuessingScreen> createState() => _GuessingScreenState();
}

class _GuessingScreenState extends State<GuessingScreen> {
  int? _currentGuess;
  late int _min;
  late int _max;

  @override
  void initState() {
    super.initState();
    _min = widget.min;
    _max = widget.max;
    _currentGuess = (_min + _max) ~/ 2;
  }

  void _higher() {
    setState(() {
      _min = _currentGuess! + 1;
      _currentGuess = (_min + _max) ~/ 2;
    });
  }

  void _lower() {
    setState(() {
      _max = _currentGuess! - 1;
      _currentGuess = (_min + _max) ~/ 2;
    });
  }

  void _correct() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ура!'),
          content: const Text('Я угадал ваше число!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Угадываю ваше число'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Мое предположение: $_currentGuess',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _higher,
                child: const Text('Моё число больше'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _lower,
                child: const Text('Моё число меньше'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _correct,
                child: const Text('Ты угадал!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
