import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Asegúrate que la ruta a formatter.dart sea correcta
import 'package:listmaker/widget/formatter.dart';
import 'package:listmaker/bloc/calculator/calculator_bloc.dart';
import 'line_separator.dart';
import 'main_result.dart';
import 'package:listmaker/widget/break_points.dart';

class CalculateResult extends StatelessWidget {
  // Quita expressionFontSize del constructor si lo vas a determinar internamente
  // final double expressionFontSize;
  // const CalculateResult({super.key, this.expressionFontSize = 35.0});
  CalculateResult({super.key});
  final ScrollController _expressionScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // Envuelve el BlocBuilder con LayoutBuilder para obtener el ancho actual
    return LayoutBuilder(
      builder: (BuildContext layoutContext, BoxConstraints constraints) {
        final double currentWidth =
            constraints.maxWidth; // Ancho disponible para CalculateResult

        // --- DETERMINAR TAMAÑOS DE FUENTE BASADOS EN BREAKPOINTS ---
        double currentExpressionFontSize;
        double currentMainResultFontSize;
        double
        currenthorizontalPaddingForExpression; // Padding horizontal para la expresión
        final double expressionAreaHeight;

        // --- TAMAÑOS DE FUENTE Y PADDING ---
        if (currentWidth <= BreakPoints.xsmall) {
          currentExpressionFontSize =
              18; // Más pequeño para mejor scroll vertical
          // currentExpressionFontSize =
          //     58; // Más pequeño para mejor scroll vertical
          currentMainResultFontSize = 26;
          currenthorizontalPaddingForExpression =
              40.0; // Menos padding para má++9s espacio de texto
          expressionAreaHeight = currentExpressionFontSize * 1 * 1.5;
        } else if (currentWidth < BreakPoints.small) {
          currentExpressionFontSize = 25;
          // currentExpressionFontSize = 85;
          currentMainResultFontSize = 48;
          currenthorizontalPaddingForExpression = 20.0;
          expressionAreaHeight = currentExpressionFontSize * 2 * 2.9;
        } else if (currentWidth < BreakPoints.medium) {
          currentExpressionFontSize = 22;
          currentMainResultFontSize = 55;
          currenthorizontalPaddingForExpression = 20.0;
          expressionAreaHeight = currentExpressionFontSize * 1 * 1.5;
        } else {
          currentExpressionFontSize = 24;
          currentMainResultFontSize = 60;
          currenthorizontalPaddingForExpression = 25.0;
          expressionAreaHeight = currentExpressionFontSize * 1 * 1.5;
        }

        return BlocBuilder<CalculatorBloc, CalculatorState>(
          builder: (context, state) {
            final TextStyle defaultStyle = TextStyle(
              fontSize: currentExpressionFontSize, // Usar el tamaño dinámico
              color: Colors.black87, // Un poco más suave que negro puro
            );

            final TextStyle operatorStyle = TextStyle(
              fontSize: currentExpressionFontSize, // Usar el tamaño dinámico
              color: Colors.green,
            );

            // --- (Tu lógica para construir textSpans sigue igual) ---
            List<TextSpan> textSpans = [];
            bool showInitialZero =
                state.firstNumber.isEmpty &&
                state.secondNumber.isEmpty && /* ...etc... */
                state.mathResult == '0';

            if (showInitialZero) {
              textSpans.add(TextSpan(text: '0', style: defaultStyle));
            } else {
              if (state.firstNumber.isNotEmpty) {
                textSpans.add(
                  TextSpan(
                    text: formatNumberWithCommas(state.firstNumber),
                    style: defaultStyle,
                  ),
                );
              }
              if (state.firstNumber.isNotEmpty && state.operation1.isNotEmpty) {
                textSpans.add(
                  TextSpan(text: ' ${state.operation1} ', style: operatorStyle),
                );
                if (state.secondNumber.isNotEmpty) {
                  textSpans.add(
                    TextSpan(
                      text: formatNumberWithCommas(state.secondNumber),
                      style: defaultStyle,
                    ),
                  );
                  // ... continuar con la lógica para operation2, thirdNumber, etc.
                  if (state.operation2.isNotEmpty) {
                    textSpans.add(
                      TextSpan(
                        text: ' ${state.operation2} ',
                        style: operatorStyle,
                      ),
                    );
                    if (state.thirdNumber.isNotEmpty) {
                      textSpans.add(
                        TextSpan(
                          text: formatNumberWithCommas(state.thirdNumber),
                          style: defaultStyle,
                        ),
                      );
                      if (state.operation3.isNotEmpty) {
                        textSpans.add(
                          TextSpan(
                            text: ' ${state.operation3} ',
                            style: operatorStyle,
                          ),
                        );
                        if (state.fourthNumber.isNotEmpty) {
                          textSpans.add(
                            TextSpan(
                              text: formatNumberWithCommas(state.fourthNumber),
                              style: defaultStyle,
                            ),
                          );
                          if (state.operation4.isNotEmpty) {
                            textSpans.add(
                              TextSpan(
                                text: ' ${state.operation4} ',
                                style: operatorStyle,
                              ),
                            );
                            if (state.fifthNumber.isNotEmpty) {
                              textSpans.add(
                                TextSpan(
                                  text: formatNumberWithCommas(
                                    state.fifthNumber,
                                  ),
                                  style: defaultStyle,
                                ),
                              );
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
              if (textSpans.isEmpty) {
                if (state.mathResult.isNotEmpty && state.mathResult != '0') {
                  textSpans.add(
                    TextSpan(
                      text: formatNumberWithCommas(state.mathResult),
                      style: defaultStyle,
                    ),
                  );
                } else {
                  textSpans.add(TextSpan(text: '0', style: defaultStyle));
                }
              }
            }
            // --- FIN CONSTRUCCIÓN DE TEXTSPANS ---

            // final double expressionAreaHeight =
            //     currentExpressionFontSize * 1 * 1.5;

            return Container(
              // Contenedor opcional si necesitas padding general
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
              ), // Padding vertical ligero
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.end, // Empuja el contenido hacia abajo
                crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisSize: MainAxisSize.min, // Puede que no sea necesario si Column está en Expanded
                children: [
                  // --- Línea de Expresión ---
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: currenthorizontalPaddingForExpression,
                      vertical: 4.0,
                    ),
                    // Considera usar AutoSizeText.rich aquí también si la expresión puede desbordarse
                    child: SizedBox(
                      // Contenedor con altura fija para el área de scroll
                      height:
                          expressionAreaHeight, // Altura fija para el área de scroll
                      child: SingleChildScrollView(
                        controller: _expressionScrollController,
                        scrollDirection:
                            Axis.vertical, // Dirección del scroll: VERTICAL
                        child: RichText(
                          textAlign: TextAlign.end,
                          text: TextSpan(children: textSpans),
                          // softWrap: true (default) es necesario para que el texto salte de línea y pueda haber scroll vertical.
                          // overflow no debería ser ellipsis si quieres scroll.
                          // Si el RichText es más alto que el SizedBox, el SingleChildScrollView permitirá scroll.
                        ),
                      ),
                    ),
                  ),

                  // --- Espacio y Separador ---
                  // Aumentar el espacio alrededor del separador
                  const SizedBox(height: 12.0), // Más espacio antes
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ), // Padding para que no ocupe todo el ancho
                    child: LineSeparator(),
                  ),
                  const SizedBox(height: 12.0), // Más espacio después
                  // --- Línea de Resultado Principal ---
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 8.0,
                    ), // Ajustar padding para el Row
                    child: Row(
                      children: [
                        Expanded(
                          child: MainResultText(
                            text: formatNumberWithCommas(state.mathResult),
                            fontSize:
                                currentMainResultFontSize, // Pasar el tamaño de fuente dinámico
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.backspace_outlined,
                            color: Colors.red,
                            size: 28,
                          ),
                          padding: const EdgeInsets.all(
                            8.0,
                          ), // Asegurar área táctil
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            context.read<CalculatorBloc>().add(
                              DeleteLastEntry(),
                            );
                          },
                          tooltip: 'Borrar',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
