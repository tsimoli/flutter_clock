import 'dart:math';

const columnCount = 30;
const rowCount = 18;

const chars =
    """日ﾊﾐﾋｰｳｼﾅﾓﾆｻﾜﾂｵﾘｱﾎﾃﾏｹﾒｴｶｷﾑﾕﾗｾﾈｽﾀﾇﾍ012345789:・."=*+-<>¦｜çﾘ二コヤ╌FLUTTER""";

const one = """
001100
001100
001100
001100
001100
001100
001100
001100
001100
001100
""";

const two = """
111111
111111
000011
000011
111111
111111
110000
110000
111111
111111
""";

const three = """
111111
111111
000011
000011
111111
111111
000011
000011
111111
111111
""";

const four = """
110011
110011
110011
110011
111111
111111
000011
000011
000011
000011
""";

const five = """
111111
111111
110000
110000
111111
111111
000011
000011
111111
111111
""";

const six = """
111111
111111
110000
110000
111111
111111
110011
110011
111111
111111
""";

const seven = """
111111
111111
000011
000011
001100
001100
110000
110000
110000
110000
""";

const eight = """
111111
111111
110011
110011
111111
111111
110011
110011
111111
111111
""";

const nine = """
111111
111111
110011
110011
111111
111111
000011
000011
111111
111111
""";

const zero = """
111111
111111
110011
110011
110011
110011
110011
110011
111111
111111
""";

List<Point> numberToCoordinatePointsWithOffset(String number, int offSetX) {
  final bit = mapToBits(number);
  final lines = bit.split("\n");
  List<Point> points = [];
  for (var i = 0; i < lines.length; i++) {
    var bits = lines[i].split("");
    for (var j = 0; j < bits.length; j++) {
      if (bits[j] == "1") {
        points.add(Point(offSetX + j, 4 + i));
      }
    }
  }

  return points;
}

String mapToBits(String number) {
  switch (number) {
    case "1":
      return one;
    case "2":
      return two;
    case "3":
      return three;
    case "4":
      return four;
    case "5":
      return five;
    case "6":
      return six;
    case "7":
      return seven;
    case "8":
      return eight;
    case "9":
      return nine;
    case "0":
      return zero;
    default:
      return "";
  }
}
