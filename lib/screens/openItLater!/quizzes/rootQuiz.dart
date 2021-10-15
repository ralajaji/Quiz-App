import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

class RootQuiz extends StatefulWidget {
  final int index;
  final Function _resetQuiz;
  RootQuiz(this.index, this._resetQuiz);
  @override
  State<StatefulWidget> createState() {
    return _QuizState(index, _resetQuiz);
  }
}

class _QuizState extends State<RootQuiz> {
  final int index;
  final Function _resetQuiz;
  _QuizState(this.index, this._resetQuiz);
  void setIndex() {
    if (index == 0) {
      setState(() {
        _questions = const [
          {
            'questionText': 'who is your uncle?',
            'answers': [
              {'text': 'Mohammed', 'score': 1},
              {'text': 'Rayyan', 'score': 0},
              {'text': 'Ried', 'score': 0},
              {'text': 'fahad', 'score': 0},
            ],
          },
          {
            'questionText': 'do you love me?',
            'answers': [
              {'text': 'yes', 'score': 1},
              {'text': 'no', 'score': 0},
              {'text': 'some times', 'score': 0},
              {'text': 'IDK', 'score': 0},
            ],
          },
          {
            'questionText': 'Who\'s your favorite player?',
            'answers': [
              {'text': 'Cristiano Ronaldo', 'score': 1},
              {'text': 'no one', 'score': 0},
              {'text': 'IDK', 'score': 0},
              {'text': 'Debrune', 'score': 0},
            ],
          },
        ];
      });
    } else if (index == 1) {
      setState(() {
        _questions = const [
          {
            'questionText': 'test 1 ?',
            'answers': [
              {'text': 'right answer', 'score': 1},
              {'text': 'Rayyan', 'score': 0},
              {'text': 'Ried', 'score': 0},
              {'text': 'fahad', 'score': 0},
            ],
          },
          {
            'questionText': 'test 1 ?',
            'answers': [
              {'text': 'right answer', 'score': 1},
              {'text': 'no', 'score': 0},
              {'text': 'some times', 'score': 0},
              {'text': 'IDK', 'score': 0},
            ],
          },
          {
            'questionText': 'test 1 ?',
            'answers': [
              {'text': 'right answer', 'score': 1},
              {'text': 'no one', 'score': 0},
              {'text': 'IDK', 'score': 0},
              {'text': 'Debrune', 'score': 0},
            ],
          },
        ];
      });
    } else if (index == 2) {
      setState(() {
        _questions = const [
          {
            'questionText': 'test 2 ?',
            'answers': [
              {'text': 'right answer', 'score': 1},
              {'text': 'Rayyan', 'score': 0},
              {'text': 'Ried', 'score': 0},
              {'text': 'fahad', 'score': 0},
            ],
          },
          {
            'questionText': 'test 2 ?',
            'answers': [
              {'text': 'right answer', 'score': 1},
              {'text': 'no', 'score': 0},
              {'text': 'some times', 'score': 0},
              {'text': 'IDK', 'score': 0},
            ],
          },
          {
            'questionText': 'test 2 ?',
            'answers': [
              {'text': 'right answer', 'score': 1},
              {'text': 'no one', 'score': 0},
              {'text': 'IDK', 'score': 0},
              {'text': 'Debrune', 'score': 0},
            ],
          },
        ];
      });
    } else if (index == 3) {
      setState(() {
        _questions = const [
          {
            'questionText': 'test 3 ?',
            'answers': [
              {'text': 'right answer', 'score': 1},
              {'text': 'Rayyan', 'score': 0},
              {'text': 'Ried', 'score': 0},
              {'text': 'fahad', 'score': 0},
            ],
          },
          {
            'questionText': 'test 3 ?',
            'answers': [
              {'text': 'right answer', 'score': 1},
              {'text': 'no', 'score': 0},
              {'text': 'some times', 'score': 0},
              {'text': 'IDK', 'score': 0},
            ],
          },
          {
            'questionText': 'test 3 ?',
            'answers': [
              {'text': 'right answer', 'score': 1},
              {'text': 'no one', 'score': 0},
              {'text': 'IDK', 'score': 0},
              {'text': 'Debrune', 'score': 0},
            ],
          },
        ];
      });
    }
  }

  var _questions = const [
    {
      '': '',
      'answers': [
        {'': '', 'score': 0},
        {'': '', 'score': 0},
        {'': '', 'score': 0},
        {'': '', 'score': 0},
      ],
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalQ = _questions.length;
    setIndex();

    return _questionIndex < _questions.length
        ? Quiz(
            questions: _questions,
            answerQuestion: _answerQuestion,
            questionIndex: _questionIndex,
          )
        : Result(_totalScore, _resetQuiz, totalQ);
  }
}
