
import 'dart:math';
import 'package:flutter/material.dart';

class VineView extends StatelessWidget {
  final double oil;
  final int fruit;
  const VineView({super.key, required this.oil, required this.fruit});

  @override
  Widget build(BuildContext context){
    return AspectRatio(
      aspectRatio: 16/9,
      child: CustomPaint(painter: _VinePainter(oil: oil, fruit: fruit)),
    );
  }
}

class _VinePainter extends CustomPainter {
  final double oil; final int fruit;
  _VinePainter({required this.oil, required this.fruit});

  @override
  void paint(Canvas c, Size s){
    final trunk = Paint()
      ..color = Color.lerp(Colors.brown.shade700, Colors.brown.shade300, oil/100)!
      ..strokeWidth = 10 ..style = PaintingStyle.stroke ..strokeCap = StrokeCap.round;
    final leaf = Paint()
      ..color = Color.lerp(Colors.green.shade800, Colors.green.shade300, oil/100)!
      ..style = PaintingStyle.fill;
    final grape = Paint()
      ..color = Color.lerp(Colors.purple.shade900, Colors.purple.shade400, fruit/100)!;

    final w=s.width, h=s.height;
    final p=Path()..moveTo(w*0.5,h*0.9)..cubicTo(w*0.5,h*0.6,w*0.48,h*0.4,w*0.5,h*0.2);
    c.drawPath(p,trunk);
    final b1=Path()..moveTo(w*0.5,h*0.4)..cubicTo(w*0.6,h*0.35,w*0.72,h*0.3,w*0.8,h*0.25);
    final b2=Path()..moveTo(w*0.5,h*0.35)..cubicTo(w*0.4,h*0.3,w*0.28,h*0.25,w*0.2,h*0.2);
    c.drawPath(b1,trunk); c.drawPath(b2,trunk);

    void leaves(double cx,double cy){
      for (var i=0;i<8;i++){
        final a=i/8*pi*2; final r=8+6*(oil/100);
        c.drawOval(Rect.fromCircle(center: Offset(cx+cos(a)*20, cy+sin(a)*12), radius: r), leaf);
      }
    }
    leaves(w*0.8,h*0.25); leaves(w*0.2,h*0.2);

    int clusters = max(1,(fruit/20).round());
    void grapes(double cx,double cy){
      final count=6+(fruit/15).round();
      for (var i=0;i<count;i++){
        final a=i/count*pi*2; final r=4+(fruit/100)*3;
        c.drawCircle(Offset(cx+cos(a)*10, cy+sin(a)*10), r, grape);
      }
    }
    if (clusters>=1) grapes(w*0.78,h*0.28);
    if (clusters>=2) grapes(w*0.22,h*0.18);
    if (clusters>=3) grapes(w*0.68,h*0.32);
  }

  @override
  bool shouldRepaint(covariant _VinePainter old)=> old.oil!=oil || old.fruit!=fruit;
}
