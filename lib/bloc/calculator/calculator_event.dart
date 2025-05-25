// part of 'calculator_bloc.dart';

// @immutable
// sealed class CalculatorEvent {}

// class ResetAC extends CalculatorEvent {}

// class AddNumber extends CalculatorEvent {
//   final String number;

//   AddNumber(this.number);
// }

// class ChangeNegativePositive extends CalculatorEvent {}

// class DeleteLastEntry extends CalculatorEvent {}

// class OparationEntry extends CalculatorEvent {
//   final String operation;
//   OparationEntry(this.operation);
// }

// class OperationResult extends CalculatorEvent {}

// part of 'calculator_bloc.dart';

// @immutable
// sealed class CalculatorEvent {}

// class ResetAC extends CalculatorEvent {}

// class AddNumber extends CalculatorEvent {
//   final String number;
//   AddNumber(this.number);
// }

// class ChangeNegativePositive extends CalculatorEvent {}

// class DeleteLastEntry extends CalculatorEvent {}

// class OperationEntry extends CalculatorEvent {
//   // Corregido: OparationEntry -> OperationEntry
//   final String operation;
//   OperationEntry(this.operation);
// }

// class ComputeResultEvent
//     extends
//         CalculatorEvent {} // Renombrado para claridad OperationResult -> CalculateResult

part of 'calculator_bloc.dart';

@immutable
sealed class CalculatorEvent {}

class ResetAC extends CalculatorEvent {}

class AddNumber extends CalculatorEvent {
  final String number;
  AddNumber(this.number);
}

class ChangeNegativePositive extends CalculatorEvent {}

class DeleteLastEntry extends CalculatorEvent {} // El evento sigue igual

class OperationEntry extends CalculatorEvent {
  // +, -, X, /
  final String operation;
  OperationEntry(this.operation);
}

class PercentageInput extends CalculatorEvent {} // Nuevo evento para %

class ComputeResultEvent extends CalculatorEvent {} // Para el botón =
