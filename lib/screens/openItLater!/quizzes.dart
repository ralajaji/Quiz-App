import 'package:flutter/material.dart';
import '../quizzes/rootQuiz.dart';

class Quizzez extends StatefulWidget {
  @override
  State<Quizzez> createState() => QuizzezState();
}

class QuizzezState extends State<Quizzez> {
  var index = -1;

  @override
  Widget build(BuildContext context) {
    void setIndex(int i) {
      setState(() {
        index = i;
      });
    }

    void _resetQuiz() {
      setState(() {
        index = -1;
      });
    }

    return index == -1
        ? ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Text(''),
              Container(
                height: 50,
                color: Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                child: RaisedButton(
                  child: Text('quiz 1'),
                  color: Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  onPressed: () => setIndex(0),
                ),
              ),
              Text(''),
              Container(
                height: 50,
                color: Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                child: RaisedButton(
                  child: Text('quiz 2'),
                  color: Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                  onPressed: () => setIndex(1),
                ),
              ),
              Text(''),
              Container(
                height: 50,
                color: Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                child: RaisedButton(
                  child: Text('quiz 3'),
                  color: Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  onPressed: () => setIndex(2),
                ),
              ),
              Text(''),
              Container(
                height: 50,
                color: Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                child: RaisedButton(
                  child: Text('quiz 4'),
                  color: Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                  onPressed: () => setIndex(3),
                ),
              ),
            ],
          )
        : RootQuiz(index, _resetQuiz);
  }
}
