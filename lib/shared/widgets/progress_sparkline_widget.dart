import 'package:flutter/material.dart';

import 'package:behavior_bridge/app/theme/brand_palette.dart';

class ProgressSparklineWidget extends StatelessWidget {
  const ProgressSparklineWidget({
    super.key,
    required this.values,
    required this.goal,
    this.width = 80,
    this.height = 32,
  });

  final List<int> values;
  final int goal;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) return SizedBox(width: width, height: height);
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _SparklinePainter(
          values: values,
          goal: goal,
          accentColor: context.brand.accent,
          okColor: context.brand.ok,
          warnColor: context.brand.warn,
        ),
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter({
    required this.values,
    required this.goal,
    required this.accentColor,
    required this.okColor,
    required this.warnColor,
  });

  final List<int> values;
  final int goal;
  final Color accentColor;
  final Color okColor;
  final Color warnColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) return;
    final maxY =
        values.reduce((a, b) => a > b ? a : b).toDouble().clamp(goal + 1, 999);
    final n = values.length;
    final linePaint = Paint()
      ..color = accentColor.withOpacity(0.7)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double xAt(int i) => (i / (n - 1)) * size.width;
    double yAt(int v) => size.height - (v / maxY) * size.height;

    final path = Path();
    for (var i = 0; i < n; i++) {
      final x = xAt(i);
      final y = yAt(values[i]);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, linePaint);

    for (var i = 0; i < n; i++) {
      final color = values[i] >= goal ? okColor : warnColor;
      final dotPaint = Paint()..color = color..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(xAt(i), yAt(values[i])), 2.0, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_SparklinePainter old) =>
      old.values != values || old.goal != goal;
}
