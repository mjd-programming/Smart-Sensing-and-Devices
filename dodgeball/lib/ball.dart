import 'dart:ui';
import 'package:dodgeball/dodgeball.dart';

class Ball {
  final Dodgeball dodgeball;
  Rect ballRect;

  double x = 0;
  double y = 0;

  double gravity = 5;
  double speed = 1;

  double xMovementDouble = 0;

  Ball(this.dodgeball, double xPos, double yPos) {
    final double width = 60;
    final double height = 60;
    x = xPos;
    y = yPos;
    speed = 1;
    ballRect = Rect.fromLTWH(x, y, width, height);
  }

  void restart() {
    final double width = 60;
    final double height = 60;
    x = 200;
    y = 200;
    speed = 1;
    ballRect = Rect.fromLTWH(x, y, width, height);
  }

  void render(Canvas c) {
    Paint color = Paint()..color = Color(0xffd43535);
    c.drawRect(ballRect, color);
  }

  void update(double t) {
    speed += gravity;
    y += speed;
    if (ballRect.bottom > dodgeball.screenSize.height - 30) speed = -60;
    Offset yMovement = Offset.fromDirection(1.5708, speed);
    if (ballRect.left < 0) xMovementDouble = 0;
    if (ballRect.right > dodgeball.screenSize.width) xMovementDouble = 3.1415;
    Offset xMovement = Offset.fromDirection(xMovementDouble, 9);
    ballRect = ballRect.shift(yMovement).shift(xMovement);
  }
}
