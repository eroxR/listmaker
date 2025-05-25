part of 'calculator_bloc.dart';

class CalculatorState {
  final String mathResult;
  final String firstNumber;
  final String secondNumber;
  final String thirdNumber;
  final String fourthNumber;
  final String fifthNumber;
  final String operation1;
  final String operation2;
  final String operation3;
  final String operation4;

  const CalculatorState({
    this.mathResult = '0',
    this.firstNumber = '',
    this.secondNumber = '',
    this.thirdNumber = '',
    this.fourthNumber = '',
    this.fifthNumber = '',
    this.operation1 = '',
    this.operation2 = '',
    this.operation3 = '',
    this.operation4 = '',
  });

  CalculatorState copyWith({
    String? mathResult,
    String? firstNumber,
    String? secondNumber,
    String? thirdNumber,
    String? fourthNumber,
    String? fifthNumber,
    String? operation1,
    String? operation2,
    String? operation3,
    String? operation4,
  }) => CalculatorState(
    mathResult: mathResult ?? this.mathResult,
    firstNumber: firstNumber ?? this.firstNumber,
    secondNumber: secondNumber ?? this.secondNumber,
    thirdNumber: thirdNumber ?? this.thirdNumber,
    fourthNumber: fourthNumber ?? this.fourthNumber,
    fifthNumber: fifthNumber ?? this.fifthNumber,
    operation1: operation1 ?? this.operation1,
    operation2: operation2 ?? this.operation2,
    operation3: operation3 ?? this.operation3,
    operation4: operation4 ?? this.operation4,
  );
}
