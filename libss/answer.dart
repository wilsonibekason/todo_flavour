import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  const Answer(this.selectHandler, this.answerText, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // Set the background color using styleFrom
      ),
        onPressed: selectHandler(),
        child: Text(answerText),
      ),
    );
  }
}
