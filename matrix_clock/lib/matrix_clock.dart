import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:matrix_clock/constants.dart';
import 'package:matrix_clock/matrix_model.dart';
import 'package:matrix_clock/rain_column.dart';

class MatrixClock extends StatefulWidget {
  const MatrixClock(this.model);

  final MatrixModel model;

  @override
  _MatrixClockState createState() => _MatrixClockState();
}

class _MatrixClockState extends State<MatrixClock> {
  List<StreamController<Point>> _rainMakers;
  List<Widget> _rainColumns;

  @override
  void initState() {
    super.initState();
    _rainMakers =
        List.generate(columnCount, (x) => StreamController.broadcast());

    _rainColumns = List.generate(
      columnCount,
      (x) => Expanded(
        child: RainColumn(
            index: x, rainMaker: _rainMakers[x], model: widget.model),
      ),
    );

    _startTheRain();
  }

  void _startTheRain() {
    for (var i = 0; i < columnCount; i++) {
      _drop(i);
    }
  }

  void _drop(int i) {
    var count = 0;
    Future.delayed(Duration(milliseconds: Random().nextInt(7000)), () {
      Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
        _rainMakers[i].add(Point(i, count));
        count++;
        if (count == rowCount) {
          timer.cancel();
          _drop(i);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Row(
        children: _rainColumns,
      ),
    );
  }
}
