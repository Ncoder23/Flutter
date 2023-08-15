class Questions {
  Questions({required this.text, required this.options});
  final String text;
  final List<String> options;

  List<String> getShuffledAnswers() {
    final shuffledList = List.of(options);
    shuffledList.shuffle();
    return shuffledList;
  }
}

List<Questions> question_list = [
  Questions(
    text: 'What are the main building blocks of Flutter UIs?',
    options: [
      'Widgets',
      'Components',
      'Blocks',
      'Functions',
    ],
  ),
  Questions(text: 'How are Flutter UIs built?', options: [
    'By combining widgets in code',
    'By combining widgets in a visual editor',
    'By defining widgets in config files',
    'By using XCode for iOS and Android Studio for Android',
  ]),
  Questions(
    text: 'What\'s the purpose of a StatefulWidget?',
    options: [
      'Update UI as data changes',
      'Update data as UI changes',
      'Ignore data changes',
      'Render UI that does not depend on data',
    ],
  ),
  Questions(
    text:
        'Which widget should you try to use more often: StatelessWidget or StatefulWidget?',
    options: [
      'StatelessWidget',
      'StatefulWidget',
      'Both are equally good',
      'None of the above',
    ],
  ),
  Questions(
    text: 'What happens if you change data in a StatelessWidget?',
    options: [
      'The UI is not updated',
      'The UI is updated',
      'The closest StatefulWidget is updated',
      'Any nested StatefulWidgets are updated',
    ],
  ),
  Questions(
    text: 'How should you update data inside of StatefulWidgets?',
    options: [
      'By calling setState()',
      'By calling updateData()',
      'By calling updateUI()',
      'By calling updateState()',
    ],
  ),
];
