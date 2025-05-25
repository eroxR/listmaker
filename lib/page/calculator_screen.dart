// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:listmaker/bloc/calculator/calculator_bloc.dart';
// import 'package:listmaker/widget/calc_button.dart';
// import 'package:listmaker/widget/calculate_result.dart';
// // import 'dart:math' as math;

// class CalculatorScreen extends StatelessWidget {
//   const CalculatorScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final calculatorBloc = BlocProvider.of<CalculatorBloc>(context);

//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           margin: EdgeInsets.symmetric(horizontal: 10),
//           child: Column(
//             children: [
//               Expanded(child: Container()),

//               CalculateResult(),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CalculatorButton(
//                     text: 'AC',
//                     bgColor: Color(0xffA5A5A5),
//                     textColor: Colors.red,
//                     onPressed: () => calculatorBloc.add(ResetAC()),
//                   ),
//                   CalculatorButton(
//                     text: '+/-',
//                     bgColor: Color(0xffA5A5A5),
//                     onPressed:
//                         () => calculatorBloc.add(ChangeNegativePositive()),
//                   ),
//                   CalculatorButton(
//                     text: '%',
//                     bgColor: Color(0xffA5A5A5),
//                     onPressed: () => calculatorBloc.add(PercentageInput()),
//                   ),
//                   CalculatorButton(
//                     text: '/',
//                     bgColor: Color(0xffF0A23B),
//                     onPressed: () => calculatorBloc.add(OperationEntry('/')),
//                   ),
//                 ],
//               ),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CalculatorButton(
//                     text: '7',
//                     textColor: Colors.white,
//                     onPressed: () => calculatorBloc.add(AddNumber('7')),
//                   ),
//                   CalculatorButton(
//                     text: '8',
//                     textColor: Colors.white,
//                     onPressed: () => calculatorBloc.add(AddNumber('8')),
//                   ),
//                   CalculatorButton(
//                     text: '9',
//                     textColor: Colors.white,
//                     onPressed: () => calculatorBloc.add(AddNumber('9')),
//                   ),
//                   CalculatorButton(
//                     text: 'X',
//                     bgColor: Color(0xffF0A23B),
//                     onPressed: () => calculatorBloc.add(OperationEntry('X')),
//                   ),
//                 ],
//               ),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CalculatorButton(
//                     text: '4',
//                     textColor: Colors.white,
//                     onPressed: () => calculatorBloc.add(AddNumber('4')),
//                   ),
//                   CalculatorButton(
//                     text: '5',
//                     textColor: Colors.white,
//                     onPressed: () => calculatorBloc.add(AddNumber('5')),
//                   ),
//                   CalculatorButton(
//                     text: '6',
//                     textColor: Colors.white,
//                     onPressed: () => calculatorBloc.add(AddNumber('6')),
//                   ),
//                   CalculatorButton(
//                     text: '-',
//                     bgColor: Color(0xffF0A23B),
//                     onPressed: () => calculatorBloc.add(OperationEntry('-')),
//                   ),
//                 ],
//               ),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CalculatorButton(
//                     text: '1',
//                     textColor: Colors.white,
//                     onPressed: () => calculatorBloc.add(AddNumber('1')),
//                   ),
//                   CalculatorButton(
//                     text: '2',
//                     textColor: Colors.white,
//                     onPressed: () => calculatorBloc.add(AddNumber('2')),
//                   ),
//                   CalculatorButton(
//                     text: '3',
//                     textColor: Colors.white,
//                     onPressed: () => calculatorBloc.add(AddNumber('3')),
//                   ),
//                   CalculatorButton(
//                     text: '+',
//                     bgColor: Color(0xffF0A23B),
//                     onPressed: () => calculatorBloc.add(OperationEntry('+')),
//                   ),
//                 ],
//               ),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CalculatorButton(
//                     text: '0',
//                     textColor: Colors.white,
//                     big: true,
//                     onPressed: () => calculatorBloc.add(AddNumber('0')),
//                   ),
//                   CalculatorButton(
//                     text: '.',
//                     textColor: Colors.white,
//                     onPressed: () => calculatorBloc.add(AddNumber('.')),
//                   ),
//                   CalculatorButton(
//                     text: '=',
//                     // textColor: Colors.green,
//                     bgColor: Color(0xffF0A23B),
//                     onPressed: () => print('='),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// calculator_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:listmaker/bloc/calculator/calculator_bloc.dart';
// import 'package:listmaker/widget/calc_button.dart';
// import 'package:listmaker/widget/calculate_result.dart';

// class BreakPoints {
//   // Manteniendo tu clase BreakPoints
//   static const double xsmall = 320.0;
//   static const double small = 576.0;
//   static const double medium = 768.0;
//   static const double large = 992.0;
//   static const double xlarge = 1200.0;
// }

// class CalculatorScreen extends StatelessWidget {
//   const CalculatorScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final calculatorBloc = BlocProvider.of<CalculatorBloc>(context);

//     // Estos son los márgenes que definiste en CalculatorButton
//     const double buttonHorizontalInnerMargin = 3.0; // left: 3, right: 3
//     const double buttonVerticalInnerMargin =
//         6.0; // bottom: 6 (este es el espacio entre filas)

//     return Scaffold(
//       backgroundColor:
//           Colors.transparent, // Para que se vea el fondo del AlertDialog
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints constraints) {
//             final screenWidth = constraints.maxWidth;
//             // final screenHeight = constraints.maxHeight; // Útil para el aspect ratio general

//             double buttonDiameter; // Usaremos diámetro ya que son circulares
//             double fontSize;
//             double zeroButtonWidth;
//             int crossAxisCount = 4;

//             // Margen horizontal del contenedor principal de la calculadora (ej: 5% de cada lado)
//             final double calculatorHorizontalPadding =
//                 screenWidth * 0.08; // Un poco menos de margen general

//             // Ancho disponible para la cuadrícula de botones
//             final double availableWidthForGrid =
//                 screenWidth - calculatorHorizontalPadding;

//             // El espacio total ocupado por los márgenes horizontales *entre* los botones en una fila.
//             // Si hay 4 botones, hay 3 espacios entre ellos.
//             // Cada espacio es (right margin de un botón + left margin del siguiente)
//             // Pero como CalculatorButton tiene sus propios márgenes left/right,
//             // el cálculo es más simple:
//             // anchoTotal = N*diametro + (N*margenIzquierdo) + (N*margenDerecho)
//             // disponible = N*diametro + N*(3+3)
//             // disponible = N*diametro + N*6
//             // N*diametro = disponible - N*6
//             // diametro = (disponible - N*6) / N = (disponible/N) - 6
//             buttonDiameter =
//                 (availableWidthForGrid / crossAxisCount) -
//                 (buttonHorizontalInnerMargin * 2);

//             // --- Lógica de Breakpoints y Tamaños (simplificada para buttonDiameter) ---
//             if (screenWidth < BreakPoints.xsmall) {
//               // Móviles
//               // buttonDiameter ya calculado arriba es probablemente bueno.
//               fontSize = buttonDiameter * 0.40; // Ajusta este factor
//             } else if (screenWidth < BreakPoints.small) {
//               // Móviles
//               // buttonDiameter ya calculado arriba es probablemente bueno.
//               fontSize = buttonDiameter * 0.40; // Ajusta este factor
//             } else if (screenWidth < BreakPoints.medium) {
//               // Tablets pequeñas / Móviles landscape
//               fontSize = buttonDiameter * 0.38;
//             } else {
//               // Tablets y más grandes
//               fontSize = buttonDiameter * 0.35;
//             }

//             // Clamping
//             buttonDiameter = buttonDiameter.clamp(
//               50.0,
//               90.0,
//             ); // Ajusta estos límites
//             fontSize = fontSize.clamp(20.0, 40.0); // Ajusta estos límites

//             // Ancho del botón '0'
//             // Ocupa el espacio de dos botones y el espacio de margen entre ellos.
//             // Espacio de dos botones: 2 * buttonDiameter
//             // Márgenes asociados a esos dos botones: (2 * buttonHorizontalInnerMargin * 2)
//             // El botón '0' tiene sus propios márgenes (3 izq, 3 der).
//             // Queremos que el SizedBox interno del botón '0' cubra:
//             // DiámetroBtn1 + MargenDerBtn1 + MargenIzqBtn2 + DiámetroBtn2
//             // = buttonDiameter + buttonHorizontalInnerMargin + buttonHorizontalInnerMargin + buttonDiameter
//             zeroButtonWidth =
//                 (buttonDiameter * 2) + (buttonHorizontalInnerMargin * 2);

//             return Padding(
//               // Usar Padding en lugar de Margin para el contenedor principal
//               padding: EdgeInsets.symmetric(
//                 horizontal: calculatorHorizontalPadding / 2,
//                 vertical: screenWidth * 0.02,
//               ),
//               child: Column(
//                 // mainAxisAlignment: MainAxisAlignment.end, // Para empujar todo hacia abajo
//                 children: [
//                   Expanded(
//                     flex: 3, // Espacio para el resultado
//                     child: CalculateResult(),
//                   ),
//                   // Column para los botones, para controlar mejor el espaciado vertical
//                   // No usar Expanded aquí si queremos que las filas se agrupen
//                   Column(
//                     // No es necesario MainAxisAlignment.spaceEvenly si los márgenes de los botones lo manejan
//                     children: [
//                       // SizedBox para simular el espaciado que daría MainAxisAligment.spaceEvenly o .end
//                       // if (screenHeight > MIN_CALCULATOR_HEIGHT) // Condicional si quieres
//                       // Spacer(), // Empuja las filas de botones hacia abajo si hay espacio extra
//                       _buildButtonRow(
//                         context,
//                         calculatorBloc,
//                         buttonDiameter,
//                         fontSize,
//                         [
//                           ButtonConfig(
//                             'AC',
//                             bgColor: const Color(0xffA5A5A5),
//                             textColor: Colors.red,
//                             action: ResetAC(),
//                           ),
//                           ButtonConfig(
//                             '+/-',
//                             bgColor: const Color(0xffA5A5A5),
//                             action: ChangeNegativePositive(),
//                           ),
//                           ButtonConfig(
//                             '%',
//                             bgColor: const Color(0xffA5A5A5),
//                             action: PercentageInput(),
//                           ),
//                           ButtonConfig(
//                             '/',
//                             bgColor: const Color(0xffF0A23B),
//                             action: OperationEntry('/'),
//                           ),
//                         ],
//                       ),
//                       _buildButtonRow(
//                         context,
//                         calculatorBloc,
//                         buttonDiameter,
//                         fontSize,
//                         [
//                           ButtonConfig('7', action: AddNumber('7')),
//                           ButtonConfig('8', action: AddNumber('8')),
//                           ButtonConfig('9', action: AddNumber('9')),
//                           ButtonConfig(
//                             'X',
//                             bgColor: const Color(0xffF0A23B),
//                             action: OperationEntry('X'),
//                           ),
//                         ],
//                       ),
//                       _buildButtonRow(
//                         context,
//                         calculatorBloc,
//                         buttonDiameter,
//                         fontSize,
//                         [
//                           ButtonConfig('4', action: AddNumber('4')),
//                           ButtonConfig('5', action: AddNumber('5')),
//                           ButtonConfig('6', action: AddNumber('6')),
//                           ButtonConfig(
//                             '-',
//                             bgColor: const Color(0xffF0A23B),
//                             action: OperationEntry('-'),
//                           ),
//                         ],
//                       ),
//                       _buildButtonRow(
//                         context,
//                         calculatorBloc,
//                         buttonDiameter,
//                         fontSize,
//                         [
//                           ButtonConfig('1', action: AddNumber('1')),
//                           ButtonConfig('2', action: AddNumber('2')),
//                           ButtonConfig('3', action: AddNumber('3')),
//                           ButtonConfig(
//                             '+',
//                             bgColor: const Color(0xffF0A23B),
//                             action: OperationEntry('+'),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         // Última fila, manejo especial para el botón '0'
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           CalculatorButton(
//                             text: '0',
//                             width:
//                                 zeroButtonWidth, // Ancho calculado para el '0'
//                             height: buttonDiameter,
//                             fontSize: fontSize,
//                             textColor:
//                                 Colors
//                                     .white, // Asumiendo que el botón '0' es oscuro
//                             onPressed: () => calculatorBloc.add(AddNumber('0')),
//                           ),
//                           CalculatorButton(
//                             text: '.',
//                             width: buttonDiameter,
//                             height: buttonDiameter,
//                             fontSize: fontSize,
//                             textColor:
//                                 Colors
//                                     .white, // Asumiendo que el botón '.' es oscuro
//                             onPressed: () => calculatorBloc.add(AddNumber('.')),
//                           ),
//                           CalculatorButton(
//                             text: '=',
//                             bgColor: const Color(0xffF0A23B),
//                             width: buttonDiameter,
//                             height: buttonDiameter,
//                             fontSize: fontSize,
//                             textColor:
//                                 Colors
//                                     .white, // Asumiendo que el botón '=' es naranja
//                             onPressed:
//                                 () => calculatorBloc.add(ComputeResultEvent()),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildButtonRow(
//     BuildContext context,
//     CalculatorBloc bloc,
//     double buttonDiameter,
//     double fontSize,
//     List<ButtonConfig> configs,
//   ) {
//     return Row(
//       mainAxisAlignment:
//           MainAxisAlignment.center, // Centra los botones en la fila
//       children:
//           configs.map((config) {
//             Color defaultTextColor =
//                 Colors.white; // Default para botones oscuros o naranjas
//             if (config.bgColor == const Color(0xffA5A5A5) &&
//                 config.textColor == null) {
//               defaultTextColor =
//                   Colors
//                       .black; // Texto negro para botones gris claro, a menos que se especifique
//             }

//             return CalculatorButton(
//               text: config.text,
//               bgColor:
//                   config
//                       .bgColor, // Si es null, CalculatorButton usa su default (oscuro)
//               textColor: config.textColor ?? defaultTextColor,
//               width: buttonDiameter,
//               height: buttonDiameter, // Para que sean circulares
//               fontSize: fontSize,
//               onPressed: () => bloc.add(config.action),
//             );
//           }).toList(),
//     );
//   }
// }

// // Clase auxiliar ButtonConfig (mantenla como la tenías)
// class ButtonConfig {
//   final String text;
//   final Color? bgColor;
//   final Color? textColor;
//   final CalculatorEvent action;

//   ButtonConfig(this.text, {this.bgColor, this.textColor, required this.action});
// }

// calculator_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listmaker/bloc/calculator/calculator_bloc.dart';
import 'package:listmaker/widget/calc_button.dart';
import 'package:listmaker/widget/calculate_result.dart';
import 'package:listmaker/widget/break_points.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final calculatorBloc = BlocProvider.of<CalculatorBloc>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final screenWidth = constraints.maxWidth;
            // final screenHeight = constraints.maxHeight; // Para referencia vertical

            // --- Variables dinámicas para tamaños y espaciados ---
            double currentButtonDiameter;
            double currentFontSize;
            double currentZeroButtonWidth;
            EdgeInsets
            currentButtonMargins; // Márgenes DENTRO de CalculatorButton
            double
            currentCalculatorHorizontalPadding; // Padding DEL CONTENEDOR de la calculadora
            int crossAxisCount = 4;
            int resultFlex = 3; // Flex para el área de resultado
            // Puedes ajustar el flex para el área de botones si es necesario,
            // pero a menudo es mejor que se ajuste a su contenido.

            // --- Lógica de Breakpoints ---
            if (screenWidth <= BreakPoints.xsmall) {
              // Usar <= para incluir el límite
              // --- Configuración específica para XSMALL ---
              resultFlex = 2; // Menos espacio para el resultado
              currentCalculatorHorizontalPadding =
                  screenWidth * 0.04; // Menos padding general
              currentButtonMargins = const EdgeInsets.only(
                bottom: 0.1,
                right: 1,
                left: 4,
              ); // Márgenes más pequeños ENTRE botones

              final double availableWidthForGrid =
                  screenWidth - currentCalculatorHorizontalPadding;
              // Cálculo del diámetro: (AnchoDisponible - SumaDeMárgenesHorizontalesEntreBotones) / NumBotones
              // SumaDeMárgenesHorizontalesEntreBotones = (crossAxisCount - 1) * (currentButtonMargins.left + currentButtonMargins.right)
              currentButtonDiameter =
                  (availableWidthForGrid -
                      ((crossAxisCount - 1) *
                          (currentButtonMargins.left +
                              currentButtonMargins.right))) /
                  crossAxisCount;

              // Clamping agresivo para xsmall
              currentButtonDiameter = currentButtonDiameter.clamp(
                38.0,
                55.0,
              ); // Reduce el mínimo y máximo
              currentFontSize =
                  currentButtonDiameter * 0.38; // Factor de fuente más pequeño
              currentFontSize = currentFontSize.clamp(
                12.0,
                18.0,
              ); // Fuente más pequeña

              currentZeroButtonWidth =
                  (currentButtonDiameter * 2) +
                  (currentButtonMargins.left + currentButtonMargins.right);
            } else if (screenWidth < BreakPoints.small) {
              // Móviles (por encima de xsmall)
              resultFlex = 3;
              currentCalculatorHorizontalPadding = screenWidth * 0.10;
              currentButtonMargins = const EdgeInsets.only(
                bottom: 1,
                right: 1,
                left: 1,
              );

              final double availableWidthForGrid =
                  screenWidth - currentCalculatorHorizontalPadding;
              currentButtonDiameter =
                  (availableWidthForGrid -
                      ((crossAxisCount - 1) *
                          (currentButtonMargins.left +
                              currentButtonMargins.right))) /
                  crossAxisCount;

              currentButtonDiameter = currentButtonDiameter.clamp(40.0, 80.0);
              currentFontSize = currentButtonDiameter * 0.40;
              currentFontSize = currentFontSize.clamp(20.0, 40.0);

              currentZeroButtonWidth =
                  (currentButtonDiameter * 2) +
                  (currentButtonMargins.left + currentButtonMargins.right);
            } else {
              // Tablets y más grandes (simplificado, puedes añadir más breakpoints aquí)
              resultFlex = 3;
              currentCalculatorHorizontalPadding = screenWidth * 0.1;
              currentButtonMargins = const EdgeInsets.only(
                bottom: 8,
                right: 4,
                left: 4,
              );

              final double availableWidthForGrid =
                  screenWidth - currentCalculatorHorizontalPadding;
              currentButtonDiameter =
                  (availableWidthForGrid -
                      ((crossAxisCount - 1) *
                          (currentButtonMargins.left +
                              currentButtonMargins.right))) /
                  crossAxisCount;

              currentButtonDiameter = currentButtonDiameter.clamp(60.0, 100.0);
              currentFontSize = currentButtonDiameter * 0.35;
              currentFontSize = currentFontSize.clamp(22.0, 42.0);

              currentZeroButtonWidth =
                  (currentButtonDiameter * 2) +
                  (currentButtonMargins.left + currentButtonMargins.right);
            }

            // --- Construcción de la UI ---
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: currentCalculatorHorizontalPadding / 2,
                vertical: screenWidth * 0.03,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: resultFlex,
                    child:
                        CalculateResult(), // Asegúrate que CalculateResult también sea responsivo (ej. tamaño de fuente)
                  ),
                  // El Column para los botones no necesita ser Expanded si queremos que ocupe solo lo necesario
                  // y así poder detectar si hay overflow más fácilmente.
                  // Si la altura es un problema, considera envolver este Column en un SingleChildScrollView
                  // aunque idealmente todo debería caber.
                  Column(
                    children: [
                      _buildButtonRow(
                        context,
                        calculatorBloc,
                        currentButtonDiameter,
                        currentFontSize,
                        currentButtonMargins,
                        [
                          ButtonConfig(
                            'AC',
                            bgColor: const Color(0xffA5A5A5),
                            textColor: Colors.red,
                            action: ResetAC(),
                          ),
                          ButtonConfig(
                            '+/-',
                            bgColor: const Color(0xffA5A5A5),
                            action: ChangeNegativePositive(),
                          ),
                          ButtonConfig(
                            '%',
                            bgColor: const Color(0xffA5A5A5),
                            action: PercentageInput(),
                          ),
                          ButtonConfig(
                            '/',
                            bgColor: const Color(0xffF0A23B),
                            action: OperationEntry('/'),
                          ),
                        ],
                      ),
                      _buildButtonRow(
                        context,
                        calculatorBloc,
                        currentButtonDiameter,
                        currentFontSize,
                        currentButtonMargins,
                        [
                          ButtonConfig('7', action: AddNumber('7')),
                          ButtonConfig('8', action: AddNumber('8')),
                          ButtonConfig('9', action: AddNumber('9')),
                          ButtonConfig(
                            'X',
                            bgColor: const Color(0xffF0A23B),
                            action: OperationEntry('X'),
                          ),
                        ],
                      ),
                      _buildButtonRow(
                        context,
                        calculatorBloc,
                        currentButtonDiameter,
                        currentFontSize,
                        currentButtonMargins,
                        [
                          ButtonConfig('4', action: AddNumber('4')),
                          ButtonConfig('5', action: AddNumber('5')),
                          ButtonConfig('6', action: AddNumber('6')),
                          ButtonConfig(
                            '-',
                            bgColor: const Color(0xffF0A23B),
                            action: OperationEntry('-'),
                          ),
                        ],
                      ),
                      _buildButtonRow(
                        context,
                        calculatorBloc,
                        currentButtonDiameter,
                        currentFontSize,
                        currentButtonMargins,
                        [
                          ButtonConfig('1', action: AddNumber('1')),
                          ButtonConfig('2', action: AddNumber('2')),
                          ButtonConfig('3', action: AddNumber('3')),
                          ButtonConfig(
                            '+',
                            bgColor: const Color(0xffF0A23B),
                            action: OperationEntry('+'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CalculatorButton(
                            text: '0',
                            width: currentZeroButtonWidth,
                            height: currentButtonDiameter,
                            fontSize: currentFontSize,
                            buttonMargin:
                                currentButtonMargins, // Pasar márgenes
                            textColor: Colors.white,
                            onPressed: () => calculatorBloc.add(AddNumber('0')),
                          ),
                          CalculatorButton(
                            text: '.',
                            width: currentButtonDiameter,
                            height: currentButtonDiameter,
                            fontSize: currentFontSize,
                            buttonMargin:
                                currentButtonMargins, // Pasar márgenes
                            textColor: Colors.white,
                            onPressed: () => calculatorBloc.add(AddNumber('.')),
                          ),
                          CalculatorButton(
                            text: '=',
                            bgColor: const Color(0xffF0A23B),
                            width: currentButtonDiameter,
                            height: currentButtonDiameter,
                            fontSize: currentFontSize,
                            buttonMargin:
                                currentButtonMargins, // Pasar márgenes
                            textColor: Colors.white,
                            onPressed:
                                () => calculatorBloc.add(ComputeResultEvent()),
                          ),
                        ],
                      ),
                      SizedBox(
                        height:
                            currentButtonMargins.bottom > 2
                                ? currentButtonMargins.bottom / 2
                                : 2,
                      ), // Pequeño espacio final
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildButtonRow(
    BuildContext context,
    CalculatorBloc bloc,
    double buttonDiameter,
    double fontSize,
    EdgeInsets buttonMargins, // Aceptar márgenes dinámicos
    List<ButtonConfig> configs,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          configs.map((config) {
            Color defaultTextColor = Colors.white;
            if (config.bgColor == const Color(0xffA5A5A5) &&
                config.textColor == null) {
              defaultTextColor = Colors.black;
            }

            return CalculatorButton(
              text: config.text,
              bgColor: config.bgColor,
              textColor: config.textColor ?? defaultTextColor,
              width: buttonDiameter,
              height: buttonDiameter,
              fontSize: fontSize,
              buttonMargin: buttonMargins, // Usar márgenes pasados
              onPressed: () => bloc.add(config.action),
            );
          }).toList(),
    );
  }
}

// (ButtonConfig class aquí)
class ButtonConfig {
  final String text;
  final Color? bgColor;
  final Color? textColor;
  final CalculatorEvent action;
  ButtonConfig(this.text, {this.bgColor, this.textColor, required this.action});
}

// (Eventos del BLoC aquí)
// abstract class CalculatorEvent {}
// class ResetAC extends CalculatorEvent {}
// class ChangeNegativePositive extends CalculatorEvent {}
// class PercentageInput extends CalculatorEvent {}
// class OperationEntry extends CalculatorEvent { final String operation; OperationEntry(this.operation); }
// class AddNumber extends CalculatorEvent { final String number; AddNumber(this.number); }
// class ComputeResultEvent extends CalculatorEvent {}
