import 'dart:ui';
import 'package:flutter/material.dart';

class DashedBorderBox extends StatelessWidget {
  final Widget child;
  final double height;
  final Color borderColor;
  final BorderRadius borderRadius;
  

  const DashedBorderBox({
    super.key,
    required this.child,
    this.height = 200,
    this.borderColor = Colors.grey,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {

    
    return CustomPaint(
      painter: DashedBorderPainter(
        color: borderColor,
        dashLength: 6,
        dashGap: 4,
        strokeWidth: 2,
        borderRadius: borderRadius,
      ),
      child: SizedBox(
        height: height,
        child: Center(child: child),
      ),
    );
  }
}
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashGap;
  final BorderRadius borderRadius;

  DashedBorderPainter({
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.dashLength = 5.0,
    this.dashGap = 3.0,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final outerRRect = borderRadius.toRRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final path = Path()..addRRect(outerRRect);

    final dashedPath = _createDashedPath(path, dashLength, dashGap);
    canvas.drawPath(dashedPath, paint);
  }

  Path _createDashedPath(Path source, double dashLength, double dashGap) {
    final Path dashedPath = Path();
    final PathMetrics metrics = source.computeMetrics();

    for (final PathMetric metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final double next = distance + dashLength;
        dashedPath.addPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          Offset.zero,
        );
        distance = next + dashGap;
      }
    }

    return dashedPath;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
