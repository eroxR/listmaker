// Contenido del archivo: main_result.dart

import 'package:flutter/material.dart';

class MainResultText extends StatelessWidget {
  final String text;
  final double fontSize;
  // Hacemos el tamaño de fuente inicial configurable, con 50 como valor por defecto
  // para coincidir con tu código original.
  final double initialFontSize;

  const MainResultText({
    super.key,
    required this.text,
    required this.fontSize,
    this.initialFontSize = 50.0, // Tu tamaño de fuente original era 50
  });

  @override
  Widget build(BuildContext context) {
    // Tu Container original con el margin y la alineación.
    // width: double.infinity no es estrictamente necesario aquí si el Container
    // es hijo de un Expanded (como en calculate_result.dart), ya que Expanded
    // le dará las restricciones de ancho. Pero no hace daño mantenerlo.
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      alignment:
          Alignment
              .centerRight, // Alinea el FittedBox a la derecha dentro del Container
      child: FittedBox(
        fit:
            BoxFit
                .scaleDown, // Esto es lo clave: escala hacia abajo si es necesario
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            // El tamaño que intentará usar antes de escalar
            // Podrías querer añadir otros estilos aquí, como fontWeight o color
            // fontWeight: FontWeight.w300,
            // color: Colors.white, // O el color que corresponda a tu tema
          ),
          maxLines:
              1, // Importante para que FittedBox funcione correctamente con Text
          textAlign:
              TextAlign
                  .end, // Alinea el texto dentro de sus propios límites (útil si FittedBox no escala)
        ),
      ),
    );
  }
}
