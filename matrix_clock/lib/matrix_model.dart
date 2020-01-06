import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:matrix_clock/constants.dart';
import 'package:intl/intl.dart';

class MatrixModel extends ChangeNotifier {
  List<Point> _numberPoints = List();
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  final ClockModel model;

  MatrixModel(this.model) {
    model.addListener(() {
      _updateTime();
    });
    _updateTime();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  List<Point> get numberPoints => _numberPoints;

  void setNumberPoints(DateTime dt) {
    final hour = DateFormat(model.is24HourFormat ? 'HH' : 'hh').format(dt);
    final minute = DateFormat('mm').format(dt);
    final hours = hour.split("");
    final minutes = minute.split("");

    final first = numberToCoordinatePointsWithOffset(hours[0], 1);
    final second = numberToCoordinatePointsWithOffset(hours[1], 8);
    final third = numberToCoordinatePointsWithOffset(minutes[0], 16);
    final fourth = numberToCoordinatePointsWithOffset(minutes[1], 23);

    _numberPoints = first..addAll(second)..addAll(third)..addAll(fourth);

    notifyListeners();
  }

  void _updateTime() {
    _dateTime = DateTime.now();
    setNumberPoints(_dateTime);
    _timer = Timer(
      Duration(minutes: 1) -
          Duration(seconds: _dateTime.second) -
          Duration(milliseconds: _dateTime.millisecond),
      _updateTime,
    );
  }
}
