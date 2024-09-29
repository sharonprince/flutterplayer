// Function to create gradient text
import 'package:flutter/material.dart';

Widget buildGradientText(String text, Gradient gradient, double fontSize) {
  return ShaderMask(
    shaderCallback: (bounds) => gradient.createShader(
      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white, // This will be overridden by the gradient
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
