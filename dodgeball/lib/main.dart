import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:dodgeball/dodgeball.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.landscapeLeft);

  Dodgeball dodgeball = Dodgeball();
  runApp(dodgeball.widget);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = dodgeball.onTapDown;
  tapper.onTapUp = dodgeball.onTapUp;
  flameUtil.addGestureRecognizer(tapper);
}
