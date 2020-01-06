import 'package:flutter_test/flutter_test.dart';
import 'package:matrix_clock/constants.dart';

void main() {
  test('Should return list of points', () {
    final result = numberToCoordinatePointsWithOffset("1", 1);

    expect(result.length, 24);
  });
}
