import 'package:flutter/material.dart';
import 'package:listmaker/widget/panel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:listmaker/providers/provider.dart';
import 'package:provider/provider.dart';

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
              // IconButton(
              //   icon: Icon(Icons.menu), // Primer ícono a la derecha
              //   iconSize: 35.0,
              //   onPressed: () {
              //     // Acción para notificaciones
              //   },
              // ),
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

              // ValueListenableBuilder(
              //   valueListenable: isDark,
              //   builder: (context, isDarkMode, child) {
              //     return Switch.adaptive(
              //       value: isDarkMode,
              //       onChanged: (value) {
              //         isDark.value = value;
              //         context.read<ThemeProvider>().togleTheme(value);
              //       },
              //     );
              //   },
              // ),
              IconButton(
                icon: Icon(
                  Icons.calculate_rounded,
                ), // Primer ícono a la derecha
                iconSize: 35.0,
                color: Colors.red[900],
                onPressed: () {
                  // Acción para notificaciones
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
