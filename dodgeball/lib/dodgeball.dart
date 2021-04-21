import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:dodgeball/player.dart';
import 'package:dodgeball/ball.dart';

import 'package:sensors/sensors.dart';

class Dodgeball extends Game {
  Size screenSize;

  Player player;
  Ball ball;

  bool running = true;

  bool camera = false;

  Dodgeball() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    player = Player(this);
    ball = Ball(this, 200, 200);
    running = true;
  }

  void resize(Size size) {
    screenSize = size;
    super.resize(size);
  }

  void onTapDown(TapDownDetails d) {
    if (d.globalPosition.dx < 50 && d.globalPosition.dy < 50) {
      camera = !camera;
    }
    if (!running) {
      player.restart();
      ball.restart();
      running = true;
    } else {
      if (d.globalPosition.dx < screenSize.width / 2) {
        player.action = "left";
      } else {
        player.action = "right";
      }
    }
  }

  void onTapUp(TapUpDetails d) {
    if (running) {
      player.action = "idle";
    }
  }

  String getCameraText() {
    if (camera)
      return 'Camera';
    else
      return 'Tilt';
  }

  void render(Canvas canvas) {
    Rect floor = Rect.fromLTWH(
        0, screenSize.height - 60, screenSize.width, screenSize.height);
    Rect wall = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height - 60);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xffffaa00);
    canvas.drawRect(floor, bgPaint);
    bgPaint.color = Color(0xff00aaff);
    canvas.drawRect(wall, bgPaint);
    player.render(canvas);
    ball.render(canvas);
    TextSpan cameraSpan = new TextSpan(
        style: new TextStyle(color: Colors.black), text: getCameraText());
    TextPainter cameraPainter =
        new TextPainter(text: cameraSpan, textAlign: TextAlign.left);
    cameraPainter.textDirection = TextDirection.ltr;
    cameraPainter.layout();
    cameraPainter.paint(canvas, new Offset(30, 10));
    if (!running) {
      TextSpan span = new TextSpan(
          style: new TextStyle(color: Colors.black),
          text: 'Game Over\nTap Screen to Restart');
      TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.center);
      tp.textDirection = TextDirection.ltr;
      tp.layout();
      tp.paint(canvas, new Offset(screenSize.width / 2, screenSize.height / 2));
    }
  }

  void changeRunning() {
    running = !running;
    if (running) {}
  }

  void update(double t) {
    if (running) {
      if (!camera) {
        accelerometerEvents.listen((AccelerometerEvent event) {
          if (event.y < -2) {
            player.action = "left";
          } else if (event.y > 2) {
            player.action = "right";
          } else {
            player.action = "idle";
          }
        });
      } else {
        // camera stuff in here
        // force the camera to detect HEAVY left and right positions so the user
        // can comfortably stay still in the middle without the camera
        // detecting slight movement
        //
        // if (camera detects left) { player.action = "left";}
        // if (camera detects right) { player.action = "right";}
        // else player.action = "idle";
      }
      player.update(t);
      ball.update(t);
    }
  }
}
