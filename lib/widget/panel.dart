import 'package:flutter/material.dart';
import 'package:listmaker/widget/product_item.dart';
import 'package:listmaker/providers/provider.dart';

class Panel extends StatelessWidget {
  const Panel({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: context.color.card,
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: context.color.textdark, width: 1.0),
      ),
      child: Center(
        child: ListView(
          padding: EdgeInsets.all(25),
          children: [
            ProductoItem(
              nombre: 'LENTEJAS',
              peso: '500 gramos',
              precio: '\$3.500',
              imagenAsset: 'assets/lentejas.png', // usa tu URL o asset
            ),
            ProductoItem(
              nombre: 'FRIJOLES',
              peso: '500 gramos',
              precio: '\$3.500',
              imagenAsset: 'assets/frijoles.avif',
            ),
            ProductoItem(
              nombre: 'TOMATES',
              peso: '500 gramos',
              precio: '\$3.500',
              imagenAsset: 'assets/tomate.avif',
            ),
            ProductoItem(
              nombre: 'CEBOLLA CABEZONA',
              peso: '500 gramos',
              precio: '\$3.500',
              imagenAsset: 'assets/cebolla_cabezona.jpg', // usa tu URL o asset
            ),
            ProductoItem(
              nombre: 'ZANAHORIA',
              peso: '500 gramos',
              precio: '\$3.500',
              imagenAsset: 'assets/zanahoria.webp',
            ),
            ProductoItem(
              nombre: 'LENTEJAS',
              peso: '500 gramos',
              precio: '\$3.500',
              imagenAsset: 'assets/lentejas.png',
            ),
            ProductoItem(
              nombre: 'LENTEJAS',
              peso: '500 gramos',
              precio: '\$3.500',
              imagenAsset: 'assets/lentejas.png', // usa tu URL o asset
            ),
            ProductoItem(
              nombre: 'LENTEJAS',
              peso: '500 gramos',
              precio: '\$3.500',
              imagenAsset: 'assets/lentejas.png',
            ),
            ProductoItem(
              nombre: 'LENTEJAS',
              peso: '500 gramos',
              precio: '\$3.500',
              imagenAsset: 'assets/lentejas.png',
            ),
            ProductoItem(
              nombre: 'LENTEJAS',
              peso: '500 gramos',
              precio: '\$3.500',
              imagenAsset: 'assets/lentejas.png', // usa tu URL o asset
            ),
            ProductoItem(
              nombre: 'LENTEJAS',
              peso: '500 gramos',
              precio: '\$3.500',
              imagenAsset: 'assets/lentejas.png',
            ),
            ProductoItem(
              nombre: 'LENTEJAS',
              peso: '500 gramos',
              precio: '\$3.500',
              imagenAsset: 'assets/lentejas.png',
            ),
            ProductoItem(
              nombre: 'LENTEJAS',
              peso: '500 gramos',
              precio: '\$3.500',
              imagenAsset: 'assets/lentejas.png', // usa tu URL o asset
            ),
            ProductoItem(
              nombre: 'LENTEJAS',
              peso: '500 gramos',
              precio: '\$3.500',
              imagenAsset: 'assets/lentejas.png',
            ),
            ProductoItem(
              nombre: 'LENTEJAS',
              peso: '500 gramos',
              precio: '\$3.500',
              imagenAsset: 'assets/lentejas.png',
            ),
            ProductoItem(
              nombre: 'LENTEJAS',
              peso: '500 gramos',
              precio: '\$3.500',
              imagenAsset: 'assets/lentejas.png', // usa tu URL o asset
            ),
            ProductoItem(
              nombre: 'LENTEJAS',
              peso: '500 gramos',
              precio: '\$3.500',
              imagenAsset: 'assets/lentejas.png',
            ),
            ProductoItem(
              nombre: 'LENTEJAS',
              peso: '500 gramos',
              precio: '\$3.500',
              imagenAsset: 'assets/lentejas.png',
            ),
            ProductoItem(
              nombre: 'LENTEJAS',
              peso: '500 gramos',
              precio: '\$3.500',
              imagenAsset: 'assets/lentejas.png', // usa tu URL o asset
            ),
            ProductoItem(
              nombre: 'LENTEJAS',
              peso: '500 gramos',
              precio: '\$3.500',
              imagenAsset: 'assets/lentejas.png',
            ),
            ProductoItem(
              nombre: 'LENTEJAS',
              peso: '500 gramos',
              precio: '\$3.500',
              imagenAsset: 'assets/lentejas.png',
            ),
          ],
        ),
      ),
    );
  }
}
