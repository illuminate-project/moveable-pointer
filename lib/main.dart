import 'package:flutter/material.dart';

class MovingCircle extends StatefulWidget {
  const MovingCircle({Key? key}) : super(key: key);

  @override
  State<MovingCircle> createState() {
    return _MovingCircleState();
  }
}

class _MovingCircleState extends State<MovingCircle> {
  Offset _offset = const Offset(0, 0);
  double _radius = 30;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Offset: (${_offset.dx.toStringAsFixed(1)}, ${_offset.dy.toStringAsFixed(1)})"),
        const SizedBox(height: 16),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanUpdate: (details) {
            setState(() {
              _offset += details.delta;
            });
          },
          child: CustomPaint(
            painter: CirclePainter(offset: _offset, radius: _radius),
            size: const Size(100, 100),
          ),
        ),
      ],
    );
  }
}


class CirclePainter extends CustomPainter {
  final Offset offset;
  final double radius;

  CirclePainter({required this.offset, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center + offset, radius, paint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.offset != offset || oldDelegate.radius != radius;
  }
}


void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: MovingCircle(),
        ),
      ),
    ),
  );
}
