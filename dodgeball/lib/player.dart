import 'dart:ui';
import 'package:dodgeball/dodgeball.dart';

class Player {
  final Dodgeball dodgeball;
  Rect playerRect;
  bool isDead = false;
  String action = "idle";

  double speed = 10;

  Player(this.dodgeball) {
    final double width = 80;
    final double height = 140;
    double x = dodgeball.screenSize.width / 2 - 40;
    double y = dodgeball.screenSize.height - 30 - height;
    playerRect = Rect.fromLTWH(x, y, width, height);
  }

  void restart() {
    double x = dodgeball.screenSize.width / 2 - 40;
    double y = dodgeball.screenSize.height - 30 - 140;
    playerRect = Rect.fromLTWH(x, y, 80, 140);
  }

  void render(Canvas c) {
    Paint color = Paint()..color = Color(0xffc7a899);
    c.drawRect(playerRect, color);
  }

  void update(double t) {
    if (action == "duck") {
    } else if (action == "left") {
      playerRect = playerRect.shift(Offset.fromDirection(3.141592, speed));
    } else if (action == "right") {
      playerRect = playerRect.shift(Offset.fromDirection(0, speed));
    } else {
      // do nothing
    }
    if (dodgeball.ball.ballRect.overlaps(playerRect)) {
      dodgeball.changeRunning();
    }
  }
}
