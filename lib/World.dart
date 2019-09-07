import 'package:flutter/material.dart';

class World extends CustomPainter {
  Paint _paint;


  World(){
    _paint = Paint()..color = Colors.blue..strokeWidth = 10 ..strokeCap = StrokeCap.round;
  }
  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    var rect = Offset(0,0) & size;
    canvas.drawRect(rect, _paint);
//    canvas.drawImageNine(image, center, dst, paint)
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }


}
