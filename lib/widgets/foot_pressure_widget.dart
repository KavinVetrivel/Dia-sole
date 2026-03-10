import 'package:flutter/material.dart';

class FootPressureWidget extends StatelessWidget {
  final double pressureLeftHeel;
  final double pressureLeftToe;
  final double pressureRightHeel;
  final double pressureRightToe;

  const FootPressureWidget({
    super.key,
    this.pressureLeftHeel = 0.5,
    this.pressureLeftToe = 0.3,
    this.pressureRightHeel = 0.8, // High pressure example
    this.pressureRightToe = 0.4,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: CustomPaint(
        painter: FootPressurePainter(
          pressureLeftHeel: pressureLeftHeel,
          pressureLeftToe: pressureLeftToe,
          pressureRightHeel: pressureRightHeel,
          pressureRightToe: pressureRightToe,
        ),
      ),
    );
  }
}

class FootPressurePainter extends CustomPainter {
  final double pressureLeftHeel;
  final double pressureLeftToe;
  final double pressureRightHeel;
  final double pressureRightToe;

  FootPressurePainter({
    required this.pressureLeftHeel,
    required this.pressureLeftToe,
    required this.pressureRightHeel,
    required this.pressureRightToe,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint footPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final double footWidth = size.width * 0.35;
    final double footHeight = size.height * 0.9;
    final double spacing = size.width * 0.1;
    final double centerX = size.width / 2;

    // Left Foot
    final Rect leftFootRect = Rect.fromCenter(
      center: Offset(centerX - footWidth / 2 - spacing / 2, size.height / 2),
      width: footWidth,
      height: footHeight,
    );
    final RRect leftFoot = RRect.fromRectAndRadius(
      leftFootRect,
      Radius.circular(footWidth / 2),
    );

    // Right Foot
    final Rect rightFootRect = Rect.fromCenter(
      center: Offset(centerX + footWidth / 2 + spacing / 2, size.height / 2),
      width: footWidth,
      height: footHeight,
    );
    final RRect rightFoot = RRect.fromRectAndRadius(
      rightFootRect,
      Radius.circular(footWidth / 2),
    );

    canvas.drawRRect(leftFoot, footPaint);
    canvas.drawRRect(leftFoot, borderPaint);

    canvas.drawRRect(rightFoot, footPaint);
    canvas.drawRRect(rightFoot, borderPaint);

    // Draw Pressure Heatmaps
    _drawPressure(
      canvas,
      leftFootRect.center.translate(0, -footHeight * 0.25),
      pressureLeftToe,
    ); // Toe
    _drawPressure(
      canvas,
      leftFootRect.center.translate(0, footHeight * 0.3),
      pressureLeftHeel,
    ); // Heel

    _drawPressure(
      canvas,
      rightFootRect.center.translate(0, -footHeight * 0.25),
      pressureRightToe,
    ); // Toe
    _drawPressure(
      canvas,
      rightFootRect.center.translate(0, footHeight * 0.3),
      pressureRightHeel,
    ); // Heel

    // Draw Sensors (Blue Dots)
    final sensorPaint = Paint()..color = Colors.blue;
    final double sensorRadius = 4;

    // Left sensors
    canvas.drawCircle(
      leftFootRect.center.translate(0, -footHeight * 0.35),
      sensorRadius,
      sensorPaint,
    ); // Top
    canvas.drawCircle(
      leftFootRect.center.translate(0, -footHeight * 0.15),
      sensorRadius,
      sensorPaint,
    ); // Ball
    canvas.drawCircle(
      leftFootRect.center.translate(0, footHeight * 0.1),
      sensorRadius,
      sensorPaint,
    ); // Arch
    canvas.drawCircle(
      leftFootRect.center.translate(0, footHeight * 0.35),
      sensorRadius,
      sensorPaint,
    ); // Heel

    // Right sensors
    canvas.drawCircle(
      rightFootRect.center.translate(0, -footHeight * 0.35),
      sensorRadius,
      sensorPaint,
    );
    canvas.drawCircle(
      rightFootRect.center.translate(0, -footHeight * 0.15),
      sensorRadius,
      sensorPaint,
    );
    canvas.drawCircle(
      rightFootRect.center.translate(0, footHeight * 0.1),
      sensorRadius,
      sensorPaint,
    );
    canvas.drawCircle(
      rightFootRect.center.translate(0, footHeight * 0.35),
      sensorRadius,
      sensorPaint,
    );

    // Labels
    TextPainter(
        text: const TextSpan(
          text: 'LEFT FOOT',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )
      ..layout()
      ..paint(
        canvas,
        Offset(leftFootRect.center.dx - 25, leftFootRect.bottom + 10),
      );

    TextPainter(
        text: const TextSpan(
          text: 'RIGHT FOOT',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )
      ..layout()
      ..paint(
        canvas,
        Offset(rightFootRect.center.dx - 25, rightFootRect.bottom + 10),
      );
  }

  void _drawPressure(Canvas canvas, Offset center, double intensity) {
    if (intensity <= 0) return;

    // intensity 0.0 to 1.0
    // Color map: Yellow -> Orange -> Red
    // We use RadialGradient
    final double radius = 60 * intensity;

    final Paint paint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.red.withValues(alpha: 0.9 * intensity),
          Colors.orange.withValues(alpha: 0.6 * intensity),
          Colors.yellow.withValues(alpha: 0.3 * intensity),
          Colors.transparent,
        ],
        stops: const [0.0, 0.4, 0.7, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
