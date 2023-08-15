import 'package:flutter/material.dart';
import 'package:quiz_app/quiz_screen.dart';
import 'package:quiz_app/result.dart';
import 'start_screen.dart';
import 'package:quiz_app/models/questions.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() {
    // TODO: implement createState
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  String? activeState;
  final List<String> selectedAnswers = [];
  @override
  void initState() {
    // TODO: implement initState
    activeState = "start-screen";
    super.initState();
  }

  void switchScreen() {
    setState(() {
      activeState = "quiz-screen";
      selectedAnswers.clear();
    });
  }

  void retest() {
    setState(() {
      activeState = 'start-screen';
      selectedAnswers.clear();
    });
  }

  void chooseAns(String ans) {
    selectedAnswers.add(ans);
    if (selectedAnswers.length == question_list.length) {
      setState(() {
        activeState = "result-screen";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget currScreen = StartScreen(switchScreen);
    if (activeState == "quiz-screen") {
      currScreen = QuizScreen(chooseAns);
    } else if (activeState == "result-screen") {
      currScreen = Results(selectedAnswers, retest);
    }
    return MaterialApp(
      title: "Quiz Me?",
      home: Scaffold(
        backgroundColor: Colors.purple,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 242, 26, 10),
                Color.fromARGB(255, 183, 87, 80)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: currScreen,
        ),
      ),
    );
  }
}
