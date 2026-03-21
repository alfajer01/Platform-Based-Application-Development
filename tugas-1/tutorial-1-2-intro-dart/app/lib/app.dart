List<List<int>> buildNumberMatrix() {
  final matrix = <List<int>>[];

  final row1 = <int>[];
  for (var i = 0; i < 4; i++) {
    row1.add(6 + (i * 6));
  }
  matrix.add(row1);

  final row2 = <int>[];
  for (var i = 0; i < 5; i++) {
    row2.add(3 + (i * 2));
  }
  matrix.add(row2);

  final row3 = <int>[];
  for (var i = 4; i <= 9; i++) {
    row3.add(i * i * i);
  }
  matrix.add(row3);

  final row4 = <int>[];
  for (var i = 0; i < 7; i++) {
    row4.add(3 + (i * 7));
  }
  matrix.add(row4);

  return matrix;
}

int calculateGcd(int firstNumber, int secondNumber) {
  var a = firstNumber;
  var b = secondNumber;

  while (b != 0) {
    final remainder = a % b;
    a = b;
    b = remainder;
  }

  return a;
}