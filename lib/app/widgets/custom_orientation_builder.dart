import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

class CustomOrientationBuilder extends StatefulWidget {
  final Widget Function(BuildContext, CustomOrientation) builder;
  final bool isVideosRecording;

  const CustomOrientationBuilder({required this.builder, required this.isVideosRecording, super.key});

  @override
  State<CustomOrientationBuilder> createState() => _CustomOrientationBuilderState();
}

class _CustomOrientationBuilderState extends State<CustomOrientationBuilder> {
  late StreamSubscription<AccelerometerEvent> accelerometerSubscription;
  CustomOrientation cameraOrientation = CustomOrientation.portrait;

  @override
  void initState() {
    super.initState();
    orientation();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, cameraOrientation);
  }

  orientation() {
    try {
      accelerometerSubscription = accelerometerEventStream().listen((AccelerometerEvent event) {
        if (!widget.isVideosRecording) {
          setState(() {
            if (event.z < -8.0) {
              cameraOrientation = CustomOrientation.portrait;
            } else if (event.x > 5.0) {
              cameraOrientation = CustomOrientation.rightLandScape;
            } else if (event.x < -5.0) {
              cameraOrientation = CustomOrientation.leftLandScape;
            } else {
              cameraOrientation = CustomOrientation.portrait;
            }
          });
        }
      });
    } on PlatformException catch (e) {
      print("Error: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    accelerometerSubscription.cancel();
  }
}

enum CustomOrientation { portrait, leftLandScape, rightLandScape }
