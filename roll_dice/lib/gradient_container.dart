import 'package:flutter/material.dart';
import 'package:roll_dice/dice_roller.dart';

class GradientContiner extends StatelessWidget {
  const GradientContiner({required this.gradientColors, super.key});
  //final String message;
  final List<Color> gradientColors;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
      ),
      child: const Center(
        child: DiceRoller(),
      ),
    );
  }
}
