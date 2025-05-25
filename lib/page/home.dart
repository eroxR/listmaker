import 'package:flutter/material.dart';
import 'package:listmaker/widget/panel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:listmaker/providers/provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter_bloc/flutter_bloc.dart'; // Necesario para BlocProvider
import 'package:listmaker/bloc/calculator/calculator_bloc.dart';
import 'calculator_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.isDark});
  final ValueNotifier isDark;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.card,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: context.color.textdark, width: 1.0),
            ),
          ),
          child: AppBar(
            backgroundColor: context.color.card,
            leading: IconButton(
              icon: Icon(
                Icons.menu_rounded,
              ), // Ícono de tres líneas para el menú
              iconSize: 35.0,
              color: context.color.textdark,
              onPressed: () {
                // Acción para el menú lateral
              },
            ),

            title: Center(
              child: GestureDetector(
                onTap: () {
                  // Acción opcional al hacer tap en el texto
                },
                child: Tooltip(
                  message: 'Lista de Productos', // Contenido del tooltip
                  child: Text(
                    'Lista de Productos',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      color: context.color.textdark,
                    ),
                  ),
                ),
              ),
            ),
            // backgroundColor: Colors.blue,
            actions: [
              ValueListenableBuilder<bool>(
                valueListenable: isDark as ValueNotifier<bool>,
                builder: (context, isDarkMode, child) {
                  return IconButton(
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder: (
                        Widget child,
                        Animation<double> animation,
                      ) {
                        return ScaleTransition(
                          scale: animation,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: Icon(
                        key: ValueKey<bool>(isDarkMode),
                        isDarkMode ? Icons.brightness_2 : Icons.wb_sunny,
                        color: context.color.textdark,
                        size: 30.0,
                      ),
                    ),
                    onPressed: () {
                      isDark.value = !isDarkMode;
                      context.read<ThemeProvider>().togleTheme(!isDarkMode);
                    },
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.calculate_rounded,
                ), // Primer ícono a la derecha
                iconSize: 35.0,
                color: Colors.red[900],
                onPressed: () {
                  calculator(context); // Acción para notificaciones
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.add_circle_rounded,
                ), // Segundo ícono a la derecha
                iconSize: 35.0,
                color: Colors.green, // Cambia el color del ícono a azul
                onPressed: () {
                  // Acción para configuración
                },
              ),
            ],
          ),
        ),
      ),
      body: SlidingUpPanel(
        color: Colors.transparent,
        minHeight: MediaQuery.of(context).size.height * 0.6,
        maxHeight: MediaQuery.of(context).size.height * 0.65,
        panel: Panel(),
        body: Stack(
          children: [
            // Contenido principal del cuerpo
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Espaciado debajo del AppBar
                SizedBox(height: kToolbarHeight + 5),
                // Texto grande centrado
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'TOTAL ', // Texto estático
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width *
                                0.08, // Tamaño de fuente grande
                            fontWeight: FontWeight.bold, // Negrita
                            color:
                                context
                                    .color
                                    .textdark, // Color del texto estático
                          ),
                        ),
                        TextSpan(
                          text: '1.585.698', // Texto dinámico
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width *
                                0.08, // Tamaño de fuente grande
                            fontWeight: FontWeight.bold, // Negrita
                            color: Colors.green, // Color verde para los números
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Texto "150 Productos" y el ícono de ordenamiento encima del panel
            Positioned(
              top: MediaQuery.of(context).size.height * 0.19,
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '150 Productos',
                    style: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.width *
                          0.09, // Tamaño de fuente grande
                      fontWeight: FontWeight.bold,
                      color: context.color.textdark, // Negrita
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      CupertinoIcons.sort_down_circle_fill,
                      color: Colors.deepPurpleAccent,
                    ), // Ícono de ordenamiento
                    iconSize: MediaQuery.of(context).size.width * 0.1,
                    onPressed: () {
                      // Acción para el botón de ordenamiento
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void calculator(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: BlocProvider(
          create: (context) => CalculatorBloc(),
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(dialogContext).size.width * 0.9,
                height: MediaQuery.of(dialogContext).size.height * 0.75,
                child: CalculatorScreen(),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          // TextButton(
          //   onPressed: () {
          //     Navigator.pop(dialogContext); // Usa dialogContext aquí
          //   },
          //   child: Text('Cerrar Calculadora'), // Cambiado para más claridad
          // ),
        ],
      );
    },
  );
}

// void calculator(BuildContext context) {
//   showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         contentPadding: EdgeInsets.zero, // Elimina el padding predeterminado
//         content: Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 40), // Espacio para el botón de cierre
//                   Text(
//                     'Hola',
//                     // style: Theme.of(context).textTheme.headline6,
//                   ),
//                   SizedBox(height: 16),
//                   Text('¿Qué haces?'),
//                 ],
//               ),
//             ),
//             Positioned(
//               right: 8,
//               top: 8,
//               child: IconButton(
//                 icon: Icon(Icons.close, color: Colors.red),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text('Salir'),
//           ),
//         ],
//       );
//     },
//   );
// }
