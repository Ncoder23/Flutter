import 'package:flutter/material.dart';
import 'dart:math';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});
  @override
  State<DiceRoller> createState() {
    // TODO: implement createState
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  Random rand = Random();
  int curr_dice = 1;
  void dice_roll() {
    setState(() {
      curr_dice = rand.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/dice-$curr_dice.png',
          width: 200,
        ),
        TextButton(
          onPressed: dice_roll,
          child: const Text(
            "Roll Dice",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        )
      ],
    );
  }
}
