import 'package:flutter/material.dart';

class ProductoItem extends StatelessWidget {
  final String nombre;
  final String peso;
  final String precio;
  final String imagenAsset;

  const ProductoItem({
    super.key,
    required this.nombre,
    required this.peso,
    required this.precio,
    required this.imagenAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior:
          Clip.none, // Permite que el avatar sobresalga del contenedor
      children: [
        Container(
          height: 80, // Aumenta la altura del contenedor
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.only(
            left: 50,
            right: 10,
          ), // Espacio para el contenido
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .center, // Centra el contenido verticalmente
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        nombre,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                    ),
                    Row(
                      // Agrupa precio y peso en una fila
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          peso,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                        const SizedBox(width: 80),
                        Text(
                          precio,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ), // Espacio entre precio y peso
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 9, // Ajusta la posición vertical del avatar
          left: -21, // Ajusta la posición horizontal del avatar
          child: CircleAvatar(
            radius: 41,
            backgroundImage: AssetImage(imagenAsset),
          ),
        ),
      ],
    );
  }
}
