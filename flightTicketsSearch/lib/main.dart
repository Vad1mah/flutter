import 'package:flutter/material.dart';
import 'flight_search_screen.dart';

void main() {
  runApp(const FlightSearchApp());
}

class FlightSearchApp extends StatelessWidget {
  const FlightSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const FlightSearchScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
