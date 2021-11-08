import 'package:flutter/material.dart';

import '../constants.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: deviceSize.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: ElevatedButton(
          child: Text(
            answerText,
            style: TextStyle(color: Colors.white),
          ),
          onPressed: selectHandler,
          style: ElevatedButton.styleFrom(
              primary: kPrimaryColor,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}
