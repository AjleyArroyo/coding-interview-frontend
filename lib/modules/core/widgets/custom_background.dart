import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;
  const CustomBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final diameter = size.height;
    return Stack(
      children: [
        // Fondo blanco
        Container(color: Color(0xFFE4F7F9)),

        // Círculo desbordado a la derecha
        Positioned(
          top: -diameter * 0.15,
          right: -diameter / 1.3, // mueve hacia la derecha
          child: Container(
            width: diameter,
            height: diameter,
            decoration: BoxDecoration(
              color: Color(0xFFF4B53F),
              shape: BoxShape.circle,
            ),
          ),
        ),

        // Contenido de la pantalla
        child,
      ],
    );
  }
}
