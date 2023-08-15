import 'package:flutter/material.dart';
import 'package:roll_dice/gradient_container.dart';

void main() {
  runApp(const MyApp());
}

//const String message = "Hello Nil";

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(context) {
    return const MaterialApp(
      home: Scaffold(
        //backgroundColor: Colors.deepPurple,
        body: GradientContiner(gradientColors: [
          Color.fromARGB(255, 47, 8, 113),
          Color.fromARGB(255, 40, 33, 109)
        ]),
      ),
    );
  }
}
