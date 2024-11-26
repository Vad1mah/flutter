import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SnowfallScreen(),
    );
  }
}

class SnowfallScreen extends StatefulWidget {
  const SnowfallScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SnowfallScreenState createState() => _SnowfallScreenState();
}

class _SnowfallScreenState extends State<SnowfallScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Snowflake> _snowflakes = [];
  final int _numSnowflakes = 100;
  final List<ui.Image> _images = [];
  bool _isLoaded = false; // Флаг загрузки данных

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _loadImages().then((_) {
      setState(() {
        _snowflakes = List.generate(
          _numSnowflakes,
          (index) => Snowflake(
            x: Random().nextDouble() * 400,
            y: Random().nextDouble() * 800,
            size: Random().nextDouble() * 5 + 5,
            speed: Random().nextDouble() * 2 + 1,
            sway: Random().nextDouble() * 2 - 1,
            swaySpeed: Random().nextDouble() * 2 + 1,
            image: _images[index % _images.length],
          ),
        );
        _isLoaded = true; // Устанавливаем, что данные загружены
      });
    });
  }

  Future<void> _loadImages() async {
    final List<String> assetPaths = [
      'assets/images/snowflake1.png',
      'assets/images/snowflake2.png',
      'assets/images/snowflake3.png',
      'assets/images/snowflake4.png',
    ];

    for (var path in assetPaths) {
      // ignore: use_build_context_synchronously
      final data = await DefaultAssetBundle.of(context).load(path);
      final bytes = data.buffer.asUint8List();
      final image = await decodeImageFromList(bytes);
      _images.add(image);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: _isLoaded
          ? AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                for (var snowflake in _snowflakes) {
                  snowflake.update();
                }
                return CustomPaint(
                  painter: SnowfallPainter(_snowflakes),
                  child: Container(),
                );
              },
            )
          : const Center(child: CircularProgressIndicator()), // Пока данные не готовы
    );
  }
}

class Snowflake {
  double x;
  double y;
  double size;
  double speed;
  double sway;
  double swaySpeed;
  double swayOffset = 0.0;
  final ui.Image image;

  Snowflake({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.sway,
    required this.swaySpeed,
    required this.image,
  });

  void update() {
    y += speed;
    swayOffset += swaySpeed;
    x += sin(swayOffset) * sway;

    if (y > 800) {
      y = 0;
      x = Random().nextDouble() * 400;
    }
  }
}

class SnowfallPainter extends CustomPainter {
  final List<Snowflake> snowflakes;

  SnowfallPainter(this.snowflakes);

  @override
  void paint(Canvas canvas, Size size) {
    for (var snowflake in snowflakes) {
      final rect = Rect.fromCenter(
        center: Offset(snowflake.x, snowflake.y),
        width: snowflake.size,
        height: snowflake.size,
      );
      final paint = Paint();
      canvas.drawImageRect(
        snowflake.image,
        Rect.fromLTWH(
          0,
          0,
          snowflake.image.width.toDouble(),
          snowflake.image.height.toDouble(),
        ),
        rect,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
