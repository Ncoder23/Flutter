import 'package:flutter/material.dart';
import 'package:quiz_app/button.dart';
import 'package:quiz_app/models/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen(this.selectAns, {super.key});
  final Function selectAns;
  @override
  State<QuizScreen> createState() {
    // TODO: implement createState
    return _QuizScreenState();
  }
}

class _QuizScreenState extends State<QuizScreen> {
  _QuizScreenState();
  int currIndex = 0;
  void onTap(String selectedAns) {
    setState(() {
      if (currIndex < question_list.length) {
        currIndex++;
        widget.selectAns(selectedAns);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currQue = question_list[currIndex];
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currQue.text,
              textAlign: TextAlign.center,
              style: GoogleFonts.aBeeZee(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ...currQue.getShuffledAnswers().map(
                  (e) => StyledButton(e, onTap),
                )
          ],
        ),
      ),
    );
  }
}
