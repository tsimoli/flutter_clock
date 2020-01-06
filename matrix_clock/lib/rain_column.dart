import 'package:flutter/widgets.dart';
import 'package:matrix_clock/constants.dart';
import 'package:matrix_clock/matrix_model.dart';
import 'dart:async';
import 'dart:math';
import 'package:matrix_clock/rain_drop.dart';

class RainColumn extends StatefulWidget {
  final int index;
  final StreamController<Point> rainMaker;
  final MatrixModel model;

  const RainColumn({Key key, this.index, this.rainMaker, this.model})
      : super(key: key);

  @override
  _RainColumnState createState() => _RainColumnState();
}

class _RainColumnState extends State<RainColumn> {
  var rainDrops = List<Widget>();

  @override
  void initState() {
    super.initState();
    rainDrops = List.generate(
      rowCount,
      (x) => Expanded(
        child: RainDrop(
            point: Point(widget.index, x),
            model: widget.model,
            rainMaker: widget.rainMaker),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: rainDrops);
  }
}
