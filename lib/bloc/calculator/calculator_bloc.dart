import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart'; // Para formateo con comas

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  static const int maxNumberLength = 15;
  final NumberFormat _resultFormatter = NumberFormat(
    '#,##0.##########',
    'en_US',
  );

  CalculatorBloc() : super(const CalculatorState()) {
    on<ResetAC>(_onResetAC);
    on<AddNumber>(_onAddNumber);
    on<DeleteLastEntry>(_onDeleteLastEntry);
    on<OperationEntry>(_onOperationEntry);
    on<ComputeResultEvent>(_onComputeResult);
    on<PercentageInput>(_onPercentageInput);
    on<ChangeNegativePositive>(_onChangeNegativePositive);
  }

  // Función auxiliar para mapear operadores de display a operadores de cálculo
  String _mapOperator(String displayOperator) {
    switch (displayOperator) {
      case 'X': // Asumiendo que usas 'X' para multiplicar en OperationEntry
        return '*';
      case '÷': // Si usas '÷' para dividir
        return '/';
      // Añade otros mapeos si son necesarios (ej. de tu botón '%' si es un operador binario)
      default:
        return displayOperator; // Para +, - que suelen ser iguales
    }
  }

  String _cleanNumberString(String numberStr) {
    return numberStr.replaceAll(',', '');
  }

  void _onResetAC(ResetAC event, Emitter<CalculatorState> emit) {
    emit(
      const CalculatorState(
        mathResult: '0',
        firstNumber: '',
        // secondNumber: '',
        // thirdNumber: '',
        // fourthNumber: '',
        // fifthNumber: '',
        // operation1: '',
        // operation2: '',
        // operation3: '',
        // operation4: '',
      ),
    );
  }

  void _onAddNumber(AddNumber event, Emitter<CalculatorState> emit) {
    final String numberToAdd = event.number;
    String currentActiveNumber = '';
    CalculatorState newState = state;
    String resultToShow = '';
    int numberIndex = 0;

    if (state.operation1.isEmpty) {
      numberIndex = 1;
      currentActiveNumber = _cleanNumberString(state.firstNumber);
    } else if (state.operation2.isEmpty) {
      numberIndex = 2;
      currentActiveNumber = _cleanNumberString(state.secondNumber);
    } else if (state.operation3.isEmpty) {
      numberIndex = 3;
      currentActiveNumber = _cleanNumberString(state.thirdNumber);
    } else if (state.operation4.isEmpty) {
      numberIndex = 4;
      currentActiveNumber = _cleanNumberString(state.fourthNumber);
    } else {
      numberIndex = 5;
      currentActiveNumber = _cleanNumberString(state.fifthNumber);
    }

    if (numberToAdd == '.' && currentActiveNumber.contains('.')) return;
    if (currentActiveNumber.replaceAll(',', '').length >= maxNumberLength &&
        numberToAdd != '.')
      return;

    if (currentActiveNumber == '0' && numberToAdd != '.') {
      currentActiveNumber = numberToAdd;
    } else if (currentActiveNumber.isEmpty && numberToAdd == '.') {
      currentActiveNumber = '0.';
    } else {
      currentActiveNumber += numberToAdd;
    }

    switch (numberIndex) {
      case 1:
        // MODIFICACIÓN: mathResult refleja directamente firstNumber mientras se escribe,
        // para que "123." se muestre como "123." y no "123" por el formateador.
        resultToShow = currentActiveNumber;
        newState = state.copyWith(
          firstNumber: currentActiveNumber,
          mathResult: resultToShow,
        );
        break;
      case 2:
        resultToShow = _calculatePartialResult(
          state,
          currentActiveNumber,
          numberIndex,
        );
        newState = state.copyWith(
          secondNumber: currentActiveNumber,
          mathResult: resultToShow,
        );
        break;
      case 3:
        resultToShow = _calculatePartialResult(
          state,
          currentActiveNumber,
          numberIndex,
        );
        newState = state.copyWith(
          thirdNumber: currentActiveNumber,
          mathResult: resultToShow,
        );
        break;
      case 4:
        resultToShow = _calculatePartialResult(
          state,
          currentActiveNumber,
          numberIndex,
        );
        newState = state.copyWith(
          fourthNumber: currentActiveNumber,
          mathResult: resultToShow,
        );
        break;
      case 5:
        resultToShow = _calculatePartialResult(
          state,
          currentActiveNumber,
          numberIndex,
        );
        newState = state.copyWith(
          fifthNumber: currentActiveNumber,
          mathResult: resultToShow,
        );
        break;
    }
    emit(newState);
  }

  void _onOperationEntry(OperationEntry event, Emitter<CalculatorState> emit) {
    final String operation = event.operation;
    final String cleanedFirstNumber = _cleanNumberString(state.firstNumber);
    final String cleanedSecondNumber = _cleanNumberString(state.secondNumber);
    final String cleanedThirdNumber = _cleanNumberString(state.thirdNumber);
    final String cleanedFourthNumber = _cleanNumberString(state.fourthNumber);

    if (cleanedFirstNumber.isEmpty || cleanedFirstNumber == 'Error') return;

    CalculatorState newState = state;

    // MODIFICACIÓN: Se elimina la actualización de mathResult en copyWith.
    // mathResult solo se actualizará en _onAddNumber o _onComputeResult.

    if (state.operation1.isEmpty ||
        (state.operation1.isNotEmpty && cleanedSecondNumber.isEmpty)) {
      if (double.tryParse(cleanedFirstNumber) == null &&
          cleanedFirstNumber != "0." &&
          !cleanedFirstNumber.endsWith('.'))
        return; // Permite "123."
      newState = state.copyWith(
        operation1: operation,
        // mathResult: ...  <-- ELIMINADO
      );
    } else if (cleanedSecondNumber.isNotEmpty &&
        (state.operation2.isEmpty ||
            (state.operation2.isNotEmpty && cleanedThirdNumber.isEmpty))) {
      if (double.tryParse(cleanedSecondNumber) == null &&
          cleanedSecondNumber != "0." &&
          !cleanedSecondNumber.endsWith('.'))
        return;
      newState = state.copyWith(
        operation2: operation,
        // mathResult: ...  <-- ELIMINADO
      );
    } else if (cleanedThirdNumber.isNotEmpty &&
        (state.operation3.isEmpty ||
            (state.operation3.isNotEmpty && cleanedFourthNumber.isEmpty))) {
      if (double.tryParse(cleanedThirdNumber) == null &&
          cleanedThirdNumber != "0." &&
          !cleanedThirdNumber.endsWith('.'))
        return;
      newState = state.copyWith(
        operation3: operation,
        // mathResult: ...  <-- ELIMINADO
      );
    } else if (cleanedFourthNumber.isNotEmpty &&
        (state.operation4.isEmpty ||
            (state.operation4.isNotEmpty && state.fifthNumber.isEmpty))) {
      if (double.tryParse(cleanedFourthNumber) == null &&
          cleanedFourthNumber != "0." &&
          !cleanedFourthNumber.endsWith('.'))
        return;
      newState = state.copyWith(
        operation4: operation,
        // mathResult: ...  <-- ELIMINADO
      );
    } else {
      return;
    }
    emit(newState);
  }

  void _onComputeResult(
    ComputeResultEvent event,
    Emitter<CalculatorState> emit,
  ) {
    if (_prepareNumberForEvaluation(state.firstNumber).isEmpty &&
        state.firstNumber != "0") {
      // Si firstNumber (después de preparación) es vacío y no era "0" originalmente (que se prepararía a "0"),
      // no hay nada que calcular o es un error.
      // El caso de "0" es válido.
      if (state.firstNumber.isEmpty || state.firstNumber == 'Error') {
        emit(state.copyWith(mathResult: '0')); // O simplemente return
        return;
      }
    }

    String exprFn = _prepareNumberForEvaluation(state.firstNumber);
    if (exprFn.isEmpty && state.firstNumber.isNotEmpty) {
      // Si la preparación lo volvió vacío (ej. inválido)
      emit(state.copyWith(mathResult: 'Error'));
      return;
    }
    if (exprFn.isEmpty)
      exprFn = "0"; // Si firstNumber era "", tratarlo como "0" para cálculo

    String expressionString = exprFn;
    String lastValidNumberForAutoComplete = exprFn;

    if (state.operation1.isNotEmpty) {
      String exprSn = _prepareNumberForEvaluation(state.secondNumber);
      if (state.secondNumber.isNotEmpty && exprSn.isNotEmpty) {
        expressionString += '${_mapOperator(state.operation1)}$exprSn';
        lastValidNumberForAutoComplete = exprSn;
      } else {
        // Autocompletar con el último número válido
        expressionString +=
            '${_mapOperator(state.operation1)}$lastValidNumberForAutoComplete';
      }
    }

    if (state.operation2.isNotEmpty) {
      String exprTn = _prepareNumberForEvaluation(state.thirdNumber);
      if (state.thirdNumber.isNotEmpty && exprTn.isNotEmpty) {
        expressionString += '${_mapOperator(state.operation2)}$exprTn';
        lastValidNumberForAutoComplete = exprTn;
      } else {
        expressionString +=
            '${_mapOperator(state.operation2)}$lastValidNumberForAutoComplete';
      }
    }

    if (state.operation3.isNotEmpty) {
      String exprFon = _prepareNumberForEvaluation(state.fourthNumber);
      if (state.fourthNumber.isNotEmpty && exprFon.isNotEmpty) {
        expressionString += '${_mapOperator(state.operation3)}$exprFon';
        lastValidNumberForAutoComplete = exprFon;
      } else {
        expressionString +=
            '${_mapOperator(state.operation3)}$lastValidNumberForAutoComplete';
      }
    }

    if (state.operation4.isNotEmpty) {
      String exprFiN = _prepareNumberForEvaluation(state.fifthNumber);
      if (state.fifthNumber.isNotEmpty && exprFiN.isNotEmpty) {
        expressionString += '${_mapOperator(state.operation4)}$exprFiN';
        // No necesitamos actualizar lastValidNumberForAutoComplete aquí
      } else {
        expressionString +=
            '${_mapOperator(state.operation4)}$lastValidNumberForAutoComplete';
      }
    }

    // Si después de todo esto, la expressionString es solo un número que fue "0" por defecto.
    if (expressionString == "0" &&
        state.firstNumber.isEmpty &&
        state.operation1.isEmpty) {
      emit(const CalculatorState(mathResult: "0")); // Reset si era "" =
      return;
    }
    // Si la expresión es solo un número (sin operadores)
    if (double.tryParse(expressionString) != null &&
        !RegExp(r'[*\/+\-]').hasMatch(expressionString.substring(1))) {
      // No hacer nada, ya es un número. El parser lo manejará.
    } else if (RegExp(r'[*\/+\-]$').hasMatch(expressionString)) {
      // Esto no debería suceder con la lógica de autocompletado.
      // Si sucede, es un error.
      emit(state.copyWith(mathResult: 'Error: Incomplete'));
      return;
    }

    try {
      Parser p = Parser();
      Expression exp = p.parse(expressionString);
      ContextModel cm = ContextModel();
      double evalResult = exp.evaluate(EvaluationType.REAL, cm);

      String finalResultStr = _formatResult(evalResult);
      String resultForStorage =
          (finalResultStr == 'Error' || finalResultStr.contains('Overflow'))
              ? '0' // O el valor anterior de mathResult si es un error, o "0"
              : _cleanNumberString(
                finalResultStr,
              ); // Guardar limpio para la próxima vez

      emit(
        CalculatorState(
          // Estado después de un cálculo
          mathResult: finalResultStr,
          firstNumber:
              resultForStorage, // El resultado se convierte en el nuevo firstNumber
          secondNumber: '', // Limpiar los demás campos
          thirdNumber: '',
          fourthNumber: '',
          fifthNumber: '',
          operation1: '',
          operation2: '',
          operation3: '',
          operation4: '',
        ),
      );
    } catch (e) {
      // print('Error en _onComputeResult: $e\nExpression: "$expressionString"');
      emit(state.copyWith(mathResult: 'Error'));
    }
  }

  void _onDeleteLastEntry(
    DeleteLastEntry event,
    Emitter<CalculatorState> emit,
  ) {
    CalculatorState newState =
        state; // El estado que finalmente se emitirá, se actualiza progresivamente
    String newMathResult = state.mathResult; // El mathResult que se actualizará

    // 1. ¿Hay algo en fifthNumber?
    if (state.fifthNumber.isNotEmpty) {
      String updatedFifth = state.fifthNumber.substring(
        0,
        state.fifthNumber.length - 1,
      );
      newState = newState.copyWith(fifthNumber: updatedFifth);
      if (updatedFifth.isEmpty || updatedFifth == "-") {
        // N5 se vació. Queremos resultado de N1 op1 N2 op2 N3 op3 N4.
        CalculatorState stateForCalc = CalculatorState(
          firstNumber: state.firstNumber,
          operation1: state.operation1,
          secondNumber: state.secondNumber,
          operation2: state.operation2,
          thirdNumber: state.thirdNumber,
          operation3: state.operation3,
          fourthNumber: state.fourthNumber,
          operation4: '', // op4 y N5 vacíos para el cálculo
          fifthNumber: '',
          mathResult: state.mathResult,
        );
        if (stateForCalc.fourthNumber.isNotEmpty &&
            stateForCalc.operation3.isNotEmpty) {
          // Chequear hasta op3 para N4
          newMathResult = _calculatePartialResult(
            stateForCalc,
            _cleanNumberString(stateForCalc.fourthNumber),
            4,
          );
        } else {
          /* ... fallbacks más profundos si son necesarios, o default a 0 ... */
          newMathResult = "0";
        }
      } else {
        newMathResult = _calculatePartialResult(newState, updatedFifth, 5);
      }
    }
    // 2. ¿fifthNumber está vacío PERO operation4 existe?
    else if (state.operation4.isNotEmpty) {
      newState = state.copyWith(operation4: ''); // op4 borrado
      // Resultado hasta N4. newState ya tiene op4 borrado.
      newMathResult = _calculatePartialResult(
        newState,
        _cleanNumberString(state.fourthNumber),
        4,
      );
    }
    // 3. ¿Hay algo en fourthNumber?
    else if (state.fourthNumber.isNotEmpty) {
      String updatedFourth = state.fourthNumber.substring(
        0,
        state.fourthNumber.length - 1,
      );
      newState = newState.copyWith(fourthNumber: updatedFourth);
      if (updatedFourth.isEmpty || updatedFourth == "-") {
        // N4 se vació. Queremos resultado de N1 op1 N2 op2 N3.
        CalculatorState stateForCalc = CalculatorState(
          firstNumber: state.firstNumber,
          operation1: state.operation1,
          secondNumber: state.secondNumber,
          operation2: state.operation2,
          thirdNumber: state.thirdNumber,
          operation3: '', // op3 y N4 vacíos para el cálculo
          fourthNumber: '',
          fifthNumber: '',
          operation4: '',
          mathResult: state.mathResult,
        );
        if (stateForCalc.thirdNumber.isNotEmpty &&
            stateForCalc.operation2.isNotEmpty) {
          // Chequear hasta op2 para N3
          newMathResult = _calculatePartialResult(
            stateForCalc,
            _cleanNumberString(stateForCalc.thirdNumber),
            3,
          );
        } else {
          /* ... fallbacks ... */
          newMathResult = "0";
        }
      } else {
        newMathResult = _calculatePartialResult(newState, updatedFourth, 4);
      }
    }
    // 4. ¿fourthNumber está vacío PERO operation3 existe?
    else if (state.operation3.isNotEmpty) {
      newState = state.copyWith(operation3: ''); // op3 borrado
      // Resultado hasta N3.
      newMathResult = _calculatePartialResult(
        newState,
        _cleanNumberString(state.thirdNumber),
        3,
      );
    }
    // 5. ¿Hay algo en thirdNumber?
    else if (state.thirdNumber.isNotEmpty) {
      String updatedThird = state.thirdNumber.substring(
        0,
        state.thirdNumber.length - 1,
      );
      newState = newState.copyWith(thirdNumber: updatedThird);
      if (updatedThird.isEmpty || updatedThird == "-") {
        // N3 se vació. Queremos resultado de N1 op1 N2.
        CalculatorState stateForCalc = CalculatorState(
          firstNumber: state.firstNumber,
          operation1: state.operation1,
          secondNumber: state.secondNumber,
          operation2: '', // op2 y N3 vacíos para el cálculo
          thirdNumber: '',
          fourthNumber: '',
          operation3: '',
          fifthNumber: '',
          operation4: '',
          mathResult: state.mathResult,
        );
        if (stateForCalc.secondNumber.isNotEmpty &&
            stateForCalc.operation1.isNotEmpty) {
          // Chequear hasta op1 para N2
          newMathResult = _calculatePartialResult(
            stateForCalc,
            _cleanNumberString(stateForCalc.secondNumber),
            2,
          );
        } else {
          /* ... fallbacks ... */
          newMathResult = "0";
        }
      } else {
        newMathResult = _calculatePartialResult(newState, updatedThird, 3);
      }
    }
    // 6. ¿thirdNumber está vacío PERO operation2 existe?
    else if (state.operation2.isNotEmpty) {
      newState = state.copyWith(operation2: '');
      // Resultado hasta N2.
      newMathResult = _calculatePartialResult(
        newState,
        _cleanNumberString(state.secondNumber),
        2,
      );
    }
    // 7. ¿Hay algo en secondNumber?
    else if (state.secondNumber.isNotEmpty) {
      String updatedSecond = state.secondNumber.substring(
        0,
        state.secondNumber.length - 1,
      );
      newState = newState.copyWith(secondNumber: updatedSecond);
      if (updatedSecond.isEmpty || updatedSecond == "-") {
        // N2 se vació. Queremos mostrar N1.
        CalculatorState stateForCalc = CalculatorState(
          firstNumber: state.firstNumber,
          operation1: '', // op1 y N2 vacíos para el cálculo
          secondNumber: '',
          // ... resto vacío ...
          mathResult: state.mathResult,
        );
        if (stateForCalc.firstNumber.isNotEmpty) {
          newMathResult = _calculatePartialResult(
            stateForCalc,
            _cleanNumberString(stateForCalc.firstNumber),
            1,
          );
        } else {
          newMathResult = "0";
        }
      } else {
        newMathResult = _calculatePartialResult(newState, updatedSecond, 2);
      }
    }
    // 8. ¿secondNumber está vacío PERO operation1 existe?
    else if (state.operation1.isNotEmpty) {
      newState = state.copyWith(operation1: '');
      // mathResult muestra el firstNumber.
      // _calculatePartialResult con índice 1 y op1 vacío en newState se encarga.
      newMathResult = _calculatePartialResult(
        newState,
        _cleanNumberString(state.firstNumber),
        1,
      );
    }
    // 9. ¿Hay algo en firstNumber?
    else if (state.firstNumber.isNotEmpty) {
      String updatedFirst = state.firstNumber.substring(
        0,
        state.firstNumber.length - 1,
      );
      newState = state.copyWith(firstNumber: updatedFirst);
      if (updatedFirst.isEmpty || updatedFirst == "-") {
        newMathResult = "0";
      } else {
        // mathResult refleja firstNumber directamente cuando no hay operaciones.
        // Usamos _calculatePartialResult con un estado sin op1 para el formateo.
        CalculatorState tempState = newState.copyWith(operation1: '');
        newMathResult = _calculatePartialResult(tempState, updatedFirst, 1);
      }
    }
    // 10. Si todo está vacío y mathResult no es "0", ponerlo a "0".
    else if (state.firstNumber.isEmpty &&
        state.operation1.isEmpty &&
        state.secondNumber.isEmpty &&
        state.operation2.isEmpty &&
        state.thirdNumber.isEmpty &&
        state.operation3.isEmpty &&
        state.fourthNumber.isEmpty &&
        state.operation4.isEmpty &&
        state.fifthNumber.isEmpty &&
        state.mathResult != "0") {
      // No necesitamos `copyWith` aquí si solo actualizamos newMathResult
      // y luego hacemos un `copyWith` final.
      newMathResult = "0";
    }
    // Evitar emitir si no hubo cambios y ya está en estado base
    else if (newState.firstNumber == state.firstNumber &&
        newState.secondNumber == state.secondNumber &&
        newState.thirdNumber == state.thirdNumber &&
        newState.fourthNumber == state.fourthNumber &&
        newState.fifthNumber == state.fifthNumber &&
        newState.operation1 == state.operation1 &&
        newState.operation2 == state.operation2 &&
        newState.operation3 == state.operation3 &&
        newState.operation4 == state.operation4 &&
        newMathResult ==
            state.mathResult && // Comparamos el newMathResult calculado
        state.mathResult == "0" &&
        state.firstNumber.isEmpty) {
      return;
    }

    // Asegurar que el mathResult final que se va a emitir sea el calculado `newMathResult`.
    // `newState` ya tiene los números/operaciones actualizados.
    newState = newState.copyWith(mathResult: newMathResult);

    emit(newState);
  }

  void _onPercentageInput(
    PercentageInput event,
    Emitter<CalculatorState> emit,
  ) {
    String currentNumberStr = '';
    int activeNumberIndex = 0;
    CalculatorState tempState =
        state; // Usar una copia temporal para determinar el número activo

    // Determinar cuál es el número activo que se convertirá a porcentaje
    // Similar a la lógica de _onChangeNegativePositive o _onAddNumber
    if (tempState.operation1.isEmpty) {
      activeNumberIndex = 1;
      currentNumberStr = _cleanNumberString(tempState.firstNumber);
    } else if (tempState.operation2.isEmpty) {
      activeNumberIndex = 2;
      currentNumberStr = _cleanNumberString(tempState.secondNumber);
    } else if (tempState.operation3.isEmpty) {
      activeNumberIndex = 3;
      currentNumberStr = _cleanNumberString(tempState.thirdNumber);
    } else if (tempState.operation4.isEmpty) {
      activeNumberIndex = 4;
      currentNumberStr = _cleanNumberString(tempState.fourthNumber);
    } else {
      activeNumberIndex = 5;
      currentNumberStr = _cleanNumberString(tempState.fifthNumber);
    }

    // Si no hay un número activo ingresado o es "0" o "Error", no hacer nada.
    if (currentNumberStr.isEmpty ||
        currentNumberStr == '0' ||
        currentNumberStr == '0.' ||
        currentNumberStr == 'Error') {
      // Excepción: si es el firstNumber y es '0', permitir que se convierta en '0' (0% = 0)
      if (!(activeNumberIndex == 1 &&
          (currentNumberStr == '0' || currentNumberStr == '0.'))) {
        return;
      }
    }

    // Convertir el número a su valor decimal de porcentaje
    double? numericValue = double.tryParse(
      currentNumberStr.endsWith('.')
          ? currentNumberStr.substring(0, currentNumberStr.length - 1)
          : currentNumberStr,
    );

    if (numericValue == null) {
      return; // No es un número válido para convertir
    }

    double percentageValue = numericValue / 100.0;

    // Formatear el valor del porcentaje para guardarlo y mostrarlo.
    // Usar un formato que evite la notación científica para números pequeños si es posible,
    // y que maneje suficientes decimales.
    // NumberFormat para el valor interno, puede ser sin comas.
    NumberFormat internalPercentageFormatter = NumberFormat(
      '0.##########',
      'en_US',
    );
    String percentageString = internalPercentageFormatter.format(
      percentageValue,
    );

    // Limitar la longitud si es necesario, aunque para porcentajes suele ser corto.
    if (_cleanNumberString(percentageString).length > maxNumberLength) {
      // Manejar overflow, quizás mostrar error o truncar de forma inteligente.
      // Por ahora, lo dejamos, pero podría ser un problema con números muy pequeños.
      // Ejemplo: 0.000000000000001 %
      try {
        percentageString = _formatResult(
          percentageValue,
        ); // Usar el formateador general de resultados
      } catch (e) {
        emit(state.copyWith(mathResult: "Error"));
        return;
      }
    }

    CalculatorState newState = state;
    String newMathResult = state.mathResult;

    // Actualizar el número activo en el estado con su valor de porcentaje
    switch (activeNumberIndex) {
      case 1:
        newState = state.copyWith(firstNumber: percentageString);
        newMathResult =
            percentageString; // mathResult refleja firstNumber directamente
        break;
      case 2:
        newState = state.copyWith(secondNumber: percentageString);
        // Recalcular el resultado parcial con este nuevo secondNumber
        newMathResult = _calculatePartialResult(newState, percentageString, 2);
        break;
      case 3:
        newState = state.copyWith(thirdNumber: percentageString);
        newMathResult = _calculatePartialResult(newState, percentageString, 3);
        break;
      case 4:
        newState = state.copyWith(fourthNumber: percentageString);
        newMathResult = _calculatePartialResult(newState, percentageString, 4);
        break;
      case 5:
        newState = state.copyWith(fifthNumber: percentageString);
        newMathResult = _calculatePartialResult(newState, percentageString, 5);
        break;
      default: // No debería ocurrir si currentNumberStr no estaba vacío
        return;
    }

    // Actualizar mathResult en el estado
    // Si el número convertido termina en punto (poco probable para un porcentaje calculado),
    // o si es solo "-", mathResult lo muestra tal cual.
    // De lo contrario, usa el newMathResult (que ya está formateado por _calculatePartialResult o es el string directo)
    if (percentageString.endsWith('.') || percentageString == "-") {
      newState = newState.copyWith(mathResult: percentageString);
    } else {
      newState = newState.copyWith(mathResult: newMathResult);
    }

    emit(newState);
  }

  void _onChangeNegativePositive(
    ChangeNegativePositive event,
    Emitter<CalculatorState> emit,
  ) {
    String numberToChange = '';
    int activeNumberIndex =
        0; // 0 para resultado/mathResult, 1 para N1, 2 para N2, etc.
    bool isOperatingOnResult = false;

    // Determinar qué número se está editando o si es el resultado
    // Caso 1: Se está escribiendo un número (no se ha presionado un operador después de él, o es el primer número)
    if (state.operation1.isEmpty) {
      // Editando firstNumber
      activeNumberIndex = 1;
      numberToChange = _cleanNumberString(state.firstNumber);
    } else if (state.operation2.isEmpty) {
      // Editando secondNumber o firstNumber (si secondNumber está vacío)
      if (state.secondNumber.isNotEmpty) {
        activeNumberIndex = 2;
        numberToChange = _cleanNumberString(state.secondNumber);
      } else {
        // Se presionó op1, no se ha ingresado secondNumber. Operar sobre firstNumber.
        activeNumberIndex =
            1; // Técnicamente operamos sobre el "resultado" de firstNumber
        numberToChange = _cleanNumberString(state.firstNumber);
        isOperatingOnResult =
            true; // Lo tratamos como un resultado para el flujo de abajo
      }
    } else if (state.operation3.isEmpty) {
      // Editando thirdNumber o secondNumber
      if (state.thirdNumber.isNotEmpty) {
        activeNumberIndex = 3;
        numberToChange = _cleanNumberString(state.thirdNumber);
      } else {
        activeNumberIndex = 2;
        numberToChange = _cleanNumberString(state.secondNumber);
        isOperatingOnResult = true;
      }
    } else if (state.operation4.isEmpty) {
      // Editando fourthNumber o thirdNumber
      if (state.fourthNumber.isNotEmpty) {
        activeNumberIndex = 4;
        numberToChange = _cleanNumberString(state.fourthNumber);
      } else {
        activeNumberIndex = 3;
        numberToChange = _cleanNumberString(state.thirdNumber);
        isOperatingOnResult = true;
      }
    } else {
      // Editando fifthNumber o fourthNumber
      if (state.fifthNumber.isNotEmpty) {
        activeNumberIndex = 5;
        numberToChange = _cleanNumberString(state.fifthNumber);
      } else {
        activeNumberIndex = 4;
        numberToChange = _cleanNumberString(state.fourthNumber);
        isOperatingOnResult = true;
      }
    }

    // Si no se encontró un número activo para cambiar (ej. estado inicial "0" sin inputs)
    // o si el número a cambiar está vacío (ej. después de un operador, antes de ingresar el siguiente número)
    // o si es "Error"
    if (numberToChange.isEmpty || numberToChange == 'Error') {
      // Podríamos intentar operar sobre mathResult si es un número válido y no "0"
      if (state.mathResult != '0' &&
          state.mathResult != 'Error' &&
          double.tryParse(_cleanNumberString(state.mathResult)) != null) {
        numberToChange = _cleanNumberString(state.mathResult);
        activeNumberIndex =
            0; // Indica que operamos sobre mathResult/resultado final
        isOperatingOnResult = true;
      } else {
        return; // No hacer nada si es 0 o error
      }
    }

    // No cambiar signo de "0" o "0."
    if (numberToChange == '0' || numberToChange == '0.') return;

    String newNumber;
    if (numberToChange.startsWith('-')) {
      newNumber = numberToChange.substring(1); // Quitar el "-"
    } else {
      newNumber = '-$numberToChange'; // Añadir el "-"
    }

    // Si el número original terminaba en punto, y ahora es negativo, el nuevo número debe mantenerlo
    // Ej: "123." -> "-123." y "-123." -> "123."
    // La lógica actual de `_cleanNumberString` y `_prepareNumberForEvaluation` maneja esto
    // al reconstruir o parsear. Aquí `newNumber` es la cadena base.

    CalculatorState newState = state;
    String newMathResult = state.mathResult;

    if (isOperatingOnResult || activeNumberIndex == 0) {
      // Se operó sobre un resultado (mathResult o un operando anterior porque se presionó operador)
      // El resultado se convierte en el nuevo firstNumber, y se resetean las operaciones.
      newState = CalculatorState(
        // Reset más agresivo
        mathResult:
            newNumber.endsWith('.')
                ? newNumber
                : _formatResult(double.parse(newNumber)),
        firstNumber: newNumber, // Guardar con el posible punto para edición
        // Limpiar los demás campos
      );
      newMathResult = newState.mathResult; // Actualizar newMathResult
    } else {
      // Se está editando un número en curso
      switch (activeNumberIndex) {
        case 1:
          newState = state.copyWith(
            firstNumber: newNumber,
            mathResult: newNumber,
          );
          newMathResult = newNumber;
          break;
        case 2:
          newState = state.copyWith(secondNumber: newNumber);
          // Recalcular mathResult con el nuevo secondNumber
          newMathResult = _calculatePartialResult(newState, newNumber, 2);
          newState = newState.copyWith(mathResult: newMathResult);
          break;
        case 3:
          newState = state.copyWith(thirdNumber: newNumber);
          newMathResult = _calculatePartialResult(newState, newNumber, 3);
          newState = newState.copyWith(mathResult: newMathResult);
          break;
        case 4:
          newState = state.copyWith(fourthNumber: newNumber);
          newMathResult = _calculatePartialResult(newState, newNumber, 4);
          newState = newState.copyWith(mathResult: newMathResult);
          break;
        case 5:
          newState = state.copyWith(fifthNumber: newNumber);
          newMathResult = _calculatePartialResult(newState, newNumber, 5);
          newState = newState.copyWith(mathResult: newMathResult);
          break;
      }
    }

    // Asegurar que el mathResult no exceda la longitud (si es un número formateado)
    // y que si el newNumber termina en punto, mathResult lo refleje.
    if (newNumber.endsWith('.')) {
      newState = newState.copyWith(mathResult: newNumber);
    } else {
      // Si no termina en punto, y es un número, formatearlo
      final double? parsedVal = double.tryParse(newNumber);
      if (parsedVal != null) {
        // Si el número activo era el primero, mathResult debe ser igual a newNumber
        // Si era un número posterior, newMathResult ya fue calculado por _calculatePartialResult
        if (activeNumberIndex == 1 && !isOperatingOnResult) {
          newState = newState.copyWith(mathResult: newNumber);
        } else if (parsedVal == 0 && newNumber.startsWith('-')) {
          newState = newState.copyWith(mathResult: "-0"); // Caso especial -0
        }
        // else: newMathResult ya está correcto por _calculatePartialResult o por el reseteo.
      } else {
        // Si newNumber no es parseable (ej. solo "-"), mostrarlo tal cual.
        newState = newState.copyWith(mathResult: newNumber);
      }
    }

    // Control de longitud para mathResult si no es un fragmento como "123."
    if (!newState.mathResult.endsWith('.')) {
      final cleanedMathResult = _cleanNumberString(newState.mathResult);
      if (cleanedMathResult.length > maxNumberLength) {
        // Manejar overflow, por ahora lo dejamos, _formatResult podría hacerlo
      }
    }

    emit(newState);
  }

  // Función auxiliar para calcular el resultado parcial

  // ... (otros métodos de la clase) ...

  String _calculatePartialResult(
    CalculatorState
    currentState, // Este será el estado "podado" en algunos casos desde _onDeleteLastEntry
    String currentActiveNumberStr,
    int currentNumberIndex,
  ) {
    // Caso 1: El objetivo es solo mostrar/procesar el firstNumber.
    // Esto ocurre si currentNumberIndex es 1 Y no hay operation1 en el estado actual.
    // O si _onDeleteLastEntry lo llama con un estado podado donde op1 fue eliminado.
    if (currentNumberIndex <= 1 && currentState.operation1.isEmpty) {
      String numToShow = _cleanNumberString(
        currentActiveNumberStr,
      ); // Usar el que se está editando/pasando

      if (numToShow.endsWith('.') || numToShow == "-") {
        return numToShow; // Mostrar fragmentos tal cual
      }
      if (numToShow.isEmpty) {
        return "0"; // Si N1 se borró, mostrar 0
      }
      final numParsed = double.tryParse(_prepareNumberForEvaluation(numToShow));
      return numParsed != null
          ? _formatResult(numParsed)
          : numToShow; // Formatear si es completo
    }

    // Preparación de números del estado
    String fn = _prepareNumberForEvaluation(currentState.firstNumber);
    // Si fn está vacío (porque N1 original era "" o solo "."), y no es el foco (index > 1),
    // tratarlo como "0" para la expresión. Si es el foco (index == 1), ya se manejó arriba.
    if (fn.isEmpty && currentNumberIndex > 1) fn = "0";

    String sn = _prepareNumberForEvaluation(currentState.secondNumber);
    String tn = _prepareNumberForEvaluation(currentState.thirdNumber);
    String fon = _prepareNumberForEvaluation(currentState.fourthNumber);
    // No necesitamos fifthNumber preparado aquí, ya que numToAppendForExpression lo manejará si currentNumberIndex es 5.

    // Número activo que se está añadiendo/completando para la expresión
    String numToAppendForExpression = _prepareNumberForEvaluation(
      currentActiveNumberStr,
    );

    // Guardias para el número que se está escribiendo activamente (si no es un fragmento evaluable)
    if (currentActiveNumberStr == "." || currentActiveNumberStr == "-") {
      return currentActiveNumberStr;
    }
    // Si numToAppend se vació y el original no era solo un punto, es un fragmento
    if (numToAppendForExpression.isEmpty &&
        currentActiveNumberStr.isNotEmpty &&
        currentActiveNumberStr != ".") {
      final tempParse = double.tryParse(currentActiveNumberStr); // ej. "-."
      if (tempParse == null &&
          (currentActiveNumberStr.contains('.') ||
              currentActiveNumberStr.contains('-'))) {
        return currentActiveNumberStr;
      }
      // Si era un número válido que _prepare lo vació (raro), o era "" originalmente.
      // Si currentActiveNumberStr era "" y numToAppendForExpression es "", puede ser que se borró todo.
      // El código de llamada en _onDeleteLastEntry debería manejar el mathResult en ese caso.
      // Aquí, si numToAppend es vacío, no lo añadimos a la expresión.
    }

    String expressionString = '';

    try {
      // Iniciar con el primer número
      if (fn.isEmpty) {
        // Si fn sigue vacío (N1 original era "" y currentNumberIndex <=1)
        // Si currentNumberIndex es 1, se manejó arriba.
        // Si currentNumberIndex > 1 y fn es vacío, es un estado inválido para calcular.
        return currentActiveNumberStr; // O "Error"
      }
      expressionString = fn;

      // Operación 1 y Segundo Número
      if (currentState.operation1.isNotEmpty) {
        expressionString += _mapOperator(currentState.operation1);
        if (currentNumberIndex == 2) {
          // Estamos construyendo/completando N2
          if (numToAppendForExpression.isEmpty) {
            // N2 se vació
            // La expresión es solo "N1 op1". Devolver N1 formateado.
            return _formatResult(
              double.parse(fn),
            ); // fn no debería estar vacío aquí
          }
          expressionString += numToAppendForExpression;
        } else if (sn.isNotEmpty) {
          // Usar N2 ya existente
          expressionString += sn;
        } else {
          // op1 existe, pero no estamos en N2 y sn está vacío -> expresión incompleta
          return currentActiveNumberStr; // O el resultado hasta fn.
        }
      } else if (currentNumberIndex > 1) {
        // No hay op1, pero intentamos operar con N2 o más. Imposible.
        return currentActiveNumberStr; // Devuelve el número actual (que sería N1 en este estado)
      }

      // Operación 2 y Tercer Número
      // Solo añadir si op2 existe Y (estamos en N3 o más allá, O si N2 ya está completo)
      if (currentState.operation2.isNotEmpty) {
        if (RegExp(r'[*\/+\-]$').hasMatch(expressionString) && sn.isEmpty)
          return _formatResult(double.parse(fn)); // Era "N1 op1" y sn se vació
        expressionString += _mapOperator(currentState.operation2);
        if (currentNumberIndex == 3) {
          // Estamos construyendo/completando N3
          if (numToAppendForExpression.isEmpty) {
            // N3 se vació
            // La expresión es "N1 op1 N2 op2". Devolver resultado de "N1 op1 N2".
            // Esto requiere un parseo intermedio o una lógica más compleja.
            // Por ahora, asumimos que _onDeleteLastEntry pasa un estado podado.
            // Si el estado no está podado y N3 se vació, parseamos "N1 op1 N2".
            String exprHastaN2 =
                "$fn${_mapOperator(currentState.operation1)}$sn";
            Parser pTemp = Parser();
            Expression expTemp = pTemp.parse(exprHastaN2);
            ContextModel cmTemp = ContextModel();
            return _formatResult(expTemp.evaluate(EvaluationType.REAL, cmTemp));
          }
          expressionString += numToAppendForExpression;
        } else if (tn.isNotEmpty) {
          // Usar N3 ya existente
          expressionString += tn;
        } else {
          return currentActiveNumberStr;
        }
      } else if (currentNumberIndex > 2) {
        return currentActiveNumberStr;
      }

      // Operación 3 y Cuarto Número
      if (currentState.operation3.isNotEmpty) {
        if (RegExp(r'[*\/+\-]$').hasMatch(expressionString) && tn.isEmpty) {
          /* similar a arriba, parsear N1 op1 N2 op2 N3 */
        }
        expressionString += _mapOperator(currentState.operation3);
        if (currentNumberIndex == 4) {
          if (numToAppendForExpression.isEmpty) {
            String exprHastaN3 =
                "$fn${_mapOperator(currentState.operation1)}$sn${_mapOperator(currentState.operation2)}$tn";
            Parser pTemp = Parser();
            Expression expTemp = pTemp.parse(exprHastaN3);
            ContextModel cmTemp = ContextModel();
            return _formatResult(expTemp.evaluate(EvaluationType.REAL, cmTemp));
          }
          expressionString += numToAppendForExpression;
        } else if (fon.isNotEmpty) {
          expressionString += fon;
        } else {
          return currentActiveNumberStr;
        }
      } else if (currentNumberIndex > 3) {
        return currentActiveNumberStr;
      }

      // Operación 4 y Quinto Número
      if (currentState.operation4.isNotEmpty) {
        if (RegExp(r'[*\/+\-]$').hasMatch(expressionString) && fon.isEmpty) {
          /* similar, parsear hasta N4 */
        }
        expressionString += _mapOperator(currentState.operation4);
        if (currentNumberIndex == 5) {
          if (numToAppendForExpression.isEmpty) {
            String exprHastaN4 =
                "$fn${_mapOperator(currentState.operation1)}$sn${_mapOperator(currentState.operation2)}$tn${_mapOperator(currentState.operation3)}$fon";
            Parser pTemp = Parser();
            Expression expTemp = pTemp.parse(exprHastaN4);
            ContextModel cmTemp = ContextModel();
            return _formatResult(expTemp.evaluate(EvaluationType.REAL, cmTemp));
          }
          expressionString += numToAppendForExpression;
        }
        // No hay "else if (fifthNum.isNotEmpty)" porque N5 es el último operando posible para esta función.
        // Si currentNumberIndex < 5 pero op4 existe, significa que N5 no se está editando.
        // El estado podado desde _onDeleteLastEntry debería asegurar que no lleguemos aquí si el objetivo era N4.
        else if (currentNumberIndex < 5) {
          // op4 existe, pero no estamos editando N5, y N5 no está en el estado
          return currentActiveNumberStr; // O la expresión hasta op4 si fon está vacío
        }
      } else if (currentNumberIndex > 4) {
        return currentActiveNumberStr;
      }

      // Si la expresión, después de toda la construcción, termina en un operador,
      // significa que el último operando esperado (basado en currentNumberIndex) estaba vacío.
      // En este caso, no se puede evaluar. Se debería haber manejado arriba.
      // Pero como última guarda:
      if (RegExp(r'[*\/+\-]$').hasMatch(expressionString)) {
        // Esto indica que, por ejemplo, se esperaba N3 (currentNumberIndex=3),
        // se añadió op2, pero N3 (numToAppendForExpression) era vacío.
        // Devolver el resultado de la expresión ANTES de ese último operador.
        String lastOp = _mapOperator(
          currentState.operation4.isNotEmpty
              ? currentState.operation4
              : currentState.operation3.isNotEmpty
              ? currentState.operation3
              : currentState.operation2.isNotEmpty
              ? currentState.operation2
              : currentState.operation1.isNotEmpty
              ? currentState.operation1
              : "",
        );
        if (lastOp.isNotEmpty && expressionString.endsWith(lastOp)) {
          String exprBeforeLastOp = expressionString.substring(
            0,
            expressionString.length - lastOp.length,
          );
          if (exprBeforeLastOp.isEmpty ||
              RegExp(r'[*\/+\-]$').hasMatch(exprBeforeLastOp)) {
            // Si quitar el último operador deja otra cosa inválida, o vacía.
            // Buscar el último número válido.
            if (fon.isNotEmpty) return _formatResult(double.parse(fon));
            if (tn.isNotEmpty) return _formatResult(double.parse(tn));
            if (sn.isNotEmpty) return _formatResult(double.parse(sn));
            if (fn.isNotEmpty) return _formatResult(double.parse(fn));
            return "0";
          }
          // Intentar parsear la expresión sin el último operador
          try {
            Parser pTest = Parser();
            Expression expTest = pTest.parse(exprBeforeLastOp);
            ContextModel cmTest = ContextModel();
            return _formatResult(expTest.evaluate(EvaluationType.REAL, cmTest));
          } catch (e) {
            return exprBeforeLastOp; // Devuelve la cadena si el parseo falla
          }
        }
        return currentActiveNumberStr; // Fallback si no se puede resolver
      }

      if (expressionString.isEmpty) return "0";

      Parser p = Parser();
      Expression exp = p.parse(expressionString);
      ContextModel cm = ContextModel();
      double evalResult = exp.evaluate(EvaluationType.REAL, cm);

      return _formatResult(evalResult);
    } catch (e) {
      // print('Error calculando parcialmente: $e\nExpression: "$expressionString"\ncurrentActive: "$currentActiveNumberStr"');
      // Si hay un error de sintaxis en la expresión construida, es más seguro devolver el número actual.
      // Esto puede pasar si un operando intermedio es inválido y no se detectó antes.
      return currentActiveNumberStr;
    }
  }

  // NUEVA FUNCIÓN AUXILIAR A NIVEL DE CLASE
  String _prepareNumberForEvaluation(String rawNumberStr) {
    String numStr = _cleanNumberString(rawNumberStr); // Quita comas

    if (numStr.isEmpty) return "";
    if (numStr == ".")
      return "0"; // ¡Importante! Si es solo ".", tratar como "0".

    // Añadir "0" si empieza con "."
    if (numStr.startsWith('.')) {
      numStr = '0$numStr'; // ".5" -> "0.5"
    }

    // Quitar "." al final
    if (numStr.endsWith('.')) {
      numStr = numStr.substring(
        0,
        numStr.length - 1,
      ); // "123." -> "123", "0." -> "0"
    }

    // Si después de quitar el punto final, quedó vacío (ej. era "0." o solo ".")
    // y el numStr original era solo ".", ya lo manejamos arriba.
    // Si era "0.", numStr ahora es "0".
    if (numStr.isEmpty) {
      // Si _cleanNumberString(rawNumberStr) era ".", ya se manejó (se volvió "0").
      // Si _cleanNumberString(rawNumberStr) era "0.", numStr es "0".
      // Si _cleanNumberString(rawNumberStr) era "", ya se manejó.
      // Este caso es si el original era, por ejemplo, solo comas (ya vacío) o si se redujo a ""
      // de una forma no esperada. Devolver "0" como un fallback seguro si no era vacío originalmente.
      if (_cleanNumberString(rawNumberStr).isNotEmpty)
        return "0"; // Si no era vacío, default a "0"
      return ""; // Si era vacío, sigue vacío.
    }

    return numStr; // Devuelve el número procesado, puede ser "" si el original era inválido y se redujo a nada.
  }

  String _formatResult(double value) {
    if (value.isInfinite || value.isNaN) {
      return 'Error';
    }
    String formatted = _resultFormatter.format(value);
    if (formatted.replaceAll(RegExp(r'[.,-]'), '').length > maxNumberLength) {
      if (value.abs() > 999999999999999 ||
          (value.abs() < 0.0000000000001 && value != 0)) {
        return value.toStringAsExponential(7);
      }
      return 'Error: Overflow';
    }
    return formatted;
  }
}
