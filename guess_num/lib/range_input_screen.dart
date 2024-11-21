import 'package:flutter/material.dart';
import 'guessing_screen.dart'; // Импортируем второй экран

class RangeInputScreen extends StatefulWidget {
  const RangeInputScreen({super.key});

  @override
  State<RangeInputScreen> createState() => _RangeInputScreenState();
}

class _RangeInputScreenState extends State<RangeInputScreen> {
  final TextEditingController minController = TextEditingController();
  final TextEditingController maxController = TextEditingController();

  void _startGuessingGame(BuildContext context) {
    final int? min = int.tryParse(minController.text);
    final int? max = int.tryParse(maxController.text);

    if (min != null && max != null && min < max) {
      // Переходим ко второму экрану, передавая диапазон
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GuessingScreen(min: min, max: max),
        ),
      );
    } else {
      // Если диапазон невалидный
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Ошибка'),
            content: const Text('Пожалуйста, введите корректный диапазон чисел.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Загадайте число'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: minController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Минимальное число',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: maxController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Максимальное число',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _startGuessingGame(context),
              child: const Text('Начать угадывание'),
            ),
          ],
        ),
      ),
    );
  }
}
