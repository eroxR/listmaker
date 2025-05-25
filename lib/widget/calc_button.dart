// import 'package:flutter/material.dart';
// // import 'dart:math' as math;

// class CalculatorButton extends StatelessWidget {
//   final Color bgColor;
//   final bool big;
//   final String text;
//   final Color textColor;

//   final Function onPressed;
//   // final double baseButtonWidth;

//   CalculatorButton({
//     super.key,
//     bgColor,
//     this.big = false,
//     required this.text,
//     required this.onPressed,
//     this.textColor = Colors.black,
//     // required this.baseButtonWidth,
//   }) : bgColor = bgColor ?? Color(0xff333333);

//   @override
//   Widget build(BuildContext context) {
//     final buttonStyle = TextButton.styleFrom(
//       backgroundColor: bgColor,
//       shape: const StadiumBorder(),
//       padding: EdgeInsets.zero,
//     );

//     return Container(
//       margin: EdgeInsets.only(bottom: 10, right: 5, left: 5),
//       child: TextButton(
//         style: buttonStyle,
//         child: SizedBox(
//           width: big ? 150 : 65,
//           height: 65,
//           child: Center(
//             child: Text(
//               text,
//               style: TextStyle(
//                 color: textColor,
//                 fontSize: 30,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ),
//         onPressed: () => onPressed(),
//       ),
//     );
//   }
// }

// // widget/calc_button.dart
// import 'package:flutter/material.dart';

// class CalculatorButton extends StatelessWidget {
//   final Color bgColor;
//   final String text;
//   final Color textColor;
//   final Function onPressed;
//   final double width; // Nuevo: Ancho dinámico
//   final double height; // Nuevo: Alto dinámico
//   final double fontSize; // Nuevo: Tamaño de fuente dinámico

//   CalculatorButton({
//     super.key,
//     Color? bgColor, // Hacerlo nullable para usar el default abajo
//     required this.text,
//     required this.onPressed,
//     this.textColor = Colors.black,
//     required this.width,
//     required this.height,
//     required this.fontSize,
//   }) : bgColor = bgColor ?? const Color(0xff333333);

//   @override
//   Widget build(BuildContext context) {
//     final buttonStyle = TextButton.styleFrom(
//       backgroundColor: bgColor,
//       shape: const StadiumBorder(),
//       padding: EdgeInsets.zero,
//     );

//     return Container(
//       margin: const EdgeInsets.only(bottom: 1, right: 3, left: 3),
//       child: TextButton(
//         style: buttonStyle,
//         onPressed: () => onPressed(),
//         child: SizedBox(
//           width: width, // Usar ancho dinámico
//           height: height, // Usar alto dinámico
//           child: Center(
//             child: Text(
//               text,
//               style: TextStyle(
//                 color: textColor,
//                 fontSize: fontSize, // Usar tamaño de fuente dinámico
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// widget/calc_button.dart
import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final Color bgColor;
  final String text;
  final Color textColor;
  final Function onPressed;
  final double width;
  final double height;
  final double fontSize;
  final EdgeInsets buttonMargin; // Nuevo: para márgenes dinámicos

  CalculatorButton({
    super.key,
    Color? bgColor,
    required this.text,
    required this.onPressed,
    this.textColor = Colors.black,
    required this.width,
    required this.height,
    required this.fontSize,
    // Proporcionar un valor por defecto si no se pasa
    this.buttonMargin = const EdgeInsets.only(bottom: 6, right: 3, left: 3),
  }) : bgColor = bgColor ?? const Color(0xff333333);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = TextButton.styleFrom(
      backgroundColor: bgColor,
      shape: const StadiumBorder(),
      padding: EdgeInsets.zero,
      minimumSize: Size(width, height),
      fixedSize: Size(width, height),
    );

    return Container(
      margin: buttonMargin, // Usar el margen dinámico
      child: TextButton(
        style: buttonStyle,
        onPressed: () => onPressed(),
        child: SizedBox(
          width: width,
          height: height,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight:
                    FontWeight.w500, // Considera FontWeight.normal o w400
              ),
            ),
          ),
        ),
      ),
    );
  }
}
