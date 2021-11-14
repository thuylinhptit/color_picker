import 'dart:math' as math;

import 'package:flutter/material.dart';

class WheelPicker extends StatefulWidget {
  const WheelPicker({
    required this.color,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final HSVColor color;
  final ValueChanged<HSVColor> onChanged;

  @override
  _WheelPickerState createState() => _WheelPickerState();
}

class _WheelPickerState extends State<WheelPicker> {
  HSVColor get color => widget.color;

  final GlobalKey paletteKey = GlobalKey();
  Offset getOffset(Offset ratio) {
    final RenderBox? renderBox =
    paletteKey.currentContext?.findRenderObject() as RenderBox?;
    final Offset startPosition =
        renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
    return ratio - startPosition;
  }

  Size getSize() {
    final RenderBox? renderBox =
    paletteKey.currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.size ?? Size.zero;
  }
  void onPanStart(Offset offset) {
    final RenderBox? renderBox =
    paletteKey.currentContext?.findRenderObject() as RenderBox?;
    final Size size = renderBox?.size ?? Size.zero;
    final double radio = _WheelPainter.radio(size);
    final Offset startPosition =
        renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
   final Offset center = Offset(size.width / 2, size.height / 2);
    final Offset vector = offset - startPosition - center;
    widget.onChanged(
        color.withHue(
          _Wheel.vectorToHue(vector),
        ),
      );
  }

  void onPanUpdate(Offset offset) {
    final RenderBox? renderBox =
    paletteKey.currentContext?.findRenderObject() as RenderBox?;
    final Size size = renderBox?.size ?? Size.zero;

    final Offset startPosition =
        renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Offset vector = offset - startPosition - center;


      widget.onChanged(
        color.withHue(
          _Wheel.vectorToHue(vector),
        ),
      );

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (DragStartDetails details) =>
          onPanStart(details.globalPosition),
      onPanUpdate: (DragUpdateDetails details) =>
          onPanUpdate(details.globalPosition),
      child: Container(
        key: paletteKey,
        padding: const EdgeInsets.only(top: 12.0),
        width: 240,
        height: 240,
        child: CustomPaint(
          painter: _WheelPainter(color: color),
        ),
      ),
    );
  }
}

class _WheelPainter extends CustomPainter {
  const _WheelPainter({
    required this.color,
  }) : super();

  static double strokeWidth = 10;
  static double doubleStrokeWidth = 25;
  static double radio(Size size) =>
      math.min(size.width, size.height).toDouble() / 2 -
          _WheelPainter.strokeWidth;
  final HSVColor color;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radio = _WheelPainter.radio(size);
    // Wheel
    final Shader sweepShader = const SweepGradient(
      center: Alignment.bottomRight,
      colors: <Color>[
        Color.fromARGB(255, 255, 0, 0),
        Color.fromARGB(255, 255, 255, 0),
        Color.fromARGB(255, 0, 255, 0),
        Color.fromARGB(255, 0, 255, 255),
        Color.fromARGB(255, 0, 0, 255),
        Color.fromARGB(255, 255, 0, 255),
        Color.fromARGB(255, 255, 0, 0),
      ],
    ).createShader(
      Rect.fromLTWH(0, 0, radio, radio),
    );
    canvas.drawCircle(
      center,
      radio,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = _WheelPainter.doubleStrokeWidth
        ..shader = sweepShader,
    );
    canvas.drawCircle(
      center,
      radio + _WheelPainter.strokeWidth,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.grey,
    );

    // Thumb
    final Paint paintWhite = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    final Paint paintBlack = Paint()
      ..color = Colors.black
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;
    final Offset wheel = _Wheel.hueToVector(
        (color.hue + 360.0) * math.pi / 180.0, radio, center);
    canvas.drawCircle(wheel, 12, paintBlack);
    canvas.drawCircle(wheel, 12, paintWhite);
  }

  @override
  bool shouldRepaint(_WheelPainter other) => true;
}

class _Wheel {
  static double vectorToHue(Offset vector) =>
      (((math.atan2(vector.dy, vector.dx)) * 180.0 / math.pi) + 360.0) % 360.0;

  static Offset hueToVector(double h, double radio, Offset center) =>
      Offset(math.cos(h) * radio + center.dx, math.sin(h) * radio + center.dy);
}
