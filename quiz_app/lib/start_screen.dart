import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  StartScreen(this.screenSwitch, {super.key});
  void Function() screenSwitch;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/quiz-logo.png",
            width: 300,
            color: const Color.fromARGB(
                150, 255, 255, 255), // we can also use Opacity widget.
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Learn Flutter the fun way!",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            onPressed: screenSwitch,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 250, 58, 58),
              fixedSize: const Size(100, 50),
              textStyle: const TextStyle(fontSize: 16),
            ),
            label: const Text("Start"),
            icon: const Icon(
              Icons.arrow_right_alt,
            ),
          )
        ],
      ),
    );
  }
}
