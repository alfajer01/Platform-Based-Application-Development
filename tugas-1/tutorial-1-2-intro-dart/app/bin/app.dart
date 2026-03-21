import 'dart:io';

import 'package:app/app.dart' as app;

void main() {
  final matrix = app.buildNumberMatrix();

  print('=== Soal 1: Array 2 Dimensi ===');
  print('Isi List:');
  for (final row in matrix) {
    print(row.join(' '));
  }

  print('');
  print('=== Soal 2: FPB ===');
  stdout.write('Masukkan bilangan 1: ');
  final firstNumber = int.parse(stdin.readLineSync()!);

  stdout.write('Masukkan bilangan 2: ');
  final secondNumber = int.parse(stdin.readLineSync()!);

  final gcdResult = app.calculateGcd(firstNumber, secondNumber);

  print('FPB $firstNumber dan $secondNumber = $gcdResult');
}