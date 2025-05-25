// Reemplaza tu función existente con ESTA versión:
import 'package:intl/intl.dart';

String formatNumberWithCommas(String numberStr) {
  // Casos base y especiales
  if (numberStr.isEmpty || numberStr == '-') {
    return numberStr;
  }
  if (numberStr == '.') {
    return '0.';
  }
  if (numberStr == '-.') {
    return '-0.';
  }

  String integerPartString;
  String? decimalPartString;
  bool isNegative = numberStr.startsWith('-');

  // Quitar el signo negativo temporalmente para facilitar el split
  String stringToProcess = isNegative ? numberStr.substring(1) : numberStr;

  // Separar manualmente la parte entera de la decimal
  if (stringToProcess.contains('.')) {
    int dotIndex = stringToProcess.indexOf('.');
    integerPartString = stringToProcess.substring(0, dotIndex);
    // La parte decimal es todo lo que sigue al punto
    decimalPartString = stringToProcess.substring(dotIndex + 1);
  } else {
    integerPartString = stringToProcess;
    decimalPartString = null; // No hay parte decimal
  }

  // Si la parte entera está vacía (ej. el usuario escribió ".123"), trátala como "0"
  if (integerPartString.isEmpty && decimalPartString != null) {
    integerPartString = "0";
  }

  String formattedIntegerPart;
  if (integerPartString.isEmpty) {
    // Fallback por si acaso
    formattedIntegerPart = "0";
  } else {
    // Intentar parsear SOLO la parte entera
    double? integerValue = double.tryParse(integerPartString);
    if (integerValue == null) {
      // Fallback si la parte entera no es parseable
      return numberStr;
    }
    // Formatear SOLO la parte entera con comas, sin añadir decimales
    final integerFormatter = NumberFormat(
      '#,##0',
      'en_US',
    ); // Usa comas, sin ".0"
    formattedIntegerPart = integerFormatter.format(integerValue);
  }

  // Reconstruir el número
  String result = isNegative ? "-$formattedIntegerPart" : formattedIntegerPart;

  if (decimalPartString != null) {
    // Si había una parte decimal (incluso si estaba vacía, ej. "123."), añadir el punto y la parte decimal ORIGINAL
    result = '$result.$decimalPartString';
  } else if (stringToProcess.endsWith('.')) {
    // Si el número original terminaba con un punto pero no tenía parte decimal (ej. el usuario escribió "1234.")
    // Asegurarse de que el punto se mantenga.
    result = '$result.';
  }

  return result;
}
