import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/questions.dart';

class Results extends StatelessWidget {
  Results(this.givenAns, this.retest, {super.key});
  List<String> givenAns;
  void Function() retest;
  List<Map<String, Object>> get summary {
    final List<Map<String, Object>> ansSummury = [];
    for (int i = 0; i < givenAns.length; i++) {
      ansSummury.add({
        'index': i,
        'question': question_list[i].text,
        'answer': question_list[i].options[0],
        'choosen': givenAns[i],
        'correct': question_list[i].options[0] == givenAns[i],
      });
    }
    return ansSummury;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> givenSummary = summary;
    int score = summary
        .where(
          (element) => element['answer'] == element['choosen'],
        )
        .toList()
        .length;
    int total = question_list.length;
    return SizedBox(
      width: double.infinity,
      child: Container(
        //color: Colors.white,
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You answered $score out of $total Questions correct",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 500,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...givenSummary.map((e) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            //height: 50,
                            width: 30,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              //shape: BoxShape.circle,
                              color: e['correct'] as bool
                                  ? Colors.white
                                  : Colors.blueAccent,
                              borderRadius: BorderRadius.circular(150),
                            ),
                            child: Text(
                              e['index'].toString(),
                              style: TextStyle(fontSize: 28),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e['question'] as String,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                  //textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  e['answer'] as String,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          const Color.fromARGB(255, 3, 98, 6)),
                                ),
                                Text(
                                  e['choosen'] as String,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: const Color.fromARGB(
                                          255, 125, 11, 2)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    })
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton.icon(
              icon: Icon(
                Icons.refresh,
              ),
              label: const Text(
                "Retest",
                style: TextStyle(fontSize: 20),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: retest,
            ),
          ],
        ),
      ),
    );
  }
}
