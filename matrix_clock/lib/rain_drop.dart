import 'dart:async';
import 'dart:math';

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:matrix_clock/constants.dart';
import 'package:matrix_clock/matrix_model.dart';

class RainDrop extends StatefulWidget {
  final Point point;
  final MatrixModel model;
  final StreamController<Point> rainMaker;

  const RainDrop({Key key, this.point, this.model, this.rainMaker})
      : super(key: key);
  @override
  _RainDropState createState() => _RainDropState();
}

class _RainDropState extends State<RainDrop> with TickerProviderStateMixin {
  AnimationController controller;
  AnimationController colorController;
  Animation<double> fadeAnimation;
  Animation colorTween;
  String char;

  Timer timer;
  Point point;
  @override
  void initState() {
    super.initState();

    widget.rainMaker.stream.listen((point) {
      if (point.y == widget.point.y && point.x == widget.point.x) {
        controller
          ..reset()
          ..forward();
        colorController
          ..reset()
          ..forward();
      }
    });

    char = chars.split("")[Random().nextInt(chars.length - 1)];
    point = widget.point;
    controller = AnimationController(
        duration: Duration(milliseconds: 3500), vsync: this);
    colorController =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);

    fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(controller);
    colorTween = ColorTween(begin: Colors.white, end: Colors.greenAccent)
        .animate(colorController);

    Listenable.merge([controller, colorController]).addListener(() {
      setState(() {});
    });

    timer = Timer.periodic(
      Duration(milliseconds: 600 + Random().nextInt(2500)),
      (timer) {
        setState(() {
          var flip = Random().nextInt(2) == 1;
          if (flip) {
            char = chars.split("")[Random().nextInt(chars.length - 1)];
          }
        });
      },
    );

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          point = null;
        });
      }
    });

    widget.model.addListener(_updateModel);
  }

  _updateModel() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    colorController.dispose();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = ((MediaQuery.of(context).size.width / (5 / 3))) / rowCount;
    var isTheOne = widget.model.numberPoints.contains(widget.point);
    if (isTheOne) {
      return Container(
        height: height,
        child: Transform(
            transform: Matrix4.identity()..rotateY(math.pi),
            alignment: FractionalOffset.center,
            child: Text(
              char,
              style: TextStyle(
                color: Colors.white,
              ),
            )),
      );
    } else
      return Container(
        height: height,
        child: FadeTransition(
          opacity: isTheOne ? 1.0 : fadeAnimation,
          child: Transform(
              transform: Matrix4.identity()..rotateY(math.pi),
              alignment: FractionalOffset.center,
              child: Text(
                char,
                style: TextStyle(color: colorTween.value),
              )),
        ),
      );
  }
}
