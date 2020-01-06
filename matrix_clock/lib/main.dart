import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/customizer.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:matrix_clock/matrix_clock.dart';
import 'package:matrix_clock/matrix_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClockCustomizer(
      (ClockModel model) => MatrixClock(
        MatrixModel(model),
      ),
    );
  }
}
