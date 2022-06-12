import 'package:flutter/material.dart';

class PaintChair extends StatelessWidget {
  final Color color;

  const PaintChair(
      {Key? key,
      this.color = const Color(
        0xff4D525A,
      )})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0, bottom: 5.0),
      height: 12,
      width: 12,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(3.0)),
    );
  }
}

class _PainterChair extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xff21242C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();
/*
    path.moveTo(0, size.height * .2);
    path.lineTo(size.width * .2, size.height * .25);
    /* path.lineTo(size.width * .2, size.height * .7);
    path.lineTo(size.width * .1, size.height);
    path.lineTo(size.width * .2, size.height * .7);
    path.lineTo(size.width * .8, size.height * .7);
    path.lineTo(size.width * .95, size.height);
    path.lineTo(size.width * .8, size.height * .7);
    path.lineTo(size.width * .8, size.height * .25);*/
    path.lineTo(size.width, size.height * .2);
*/
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _UpsidePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xff21242C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();

    path.moveTo(size.width * .1, 0);
    path.lineTo(size.width * .2, size.height * .25);
    path.lineTo(size.width * .2, size.height * .7);
    path.lineTo(0, size.height * .75);

    path.moveTo(size.width * .2, size.height * .25);
    path.lineTo(size.width * .8, size.height * .25);
    path.lineTo(size.width * .95, 0);
    path.moveTo(size.width * .8, size.height * .25);
    path.lineTo(size.width * .8, size.height * .7);
    path.lineTo(size.width, size.height * .75);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
