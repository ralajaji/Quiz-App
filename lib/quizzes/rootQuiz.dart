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
            'questionText': "'OS' computer abbreviation usually means ?",
            'answers': [
              {'text': 'Order of Significance', 'score': 0},
              {'text': 'Open Software', 'score': 0},
              {'text': 'Operating System', 'score': 1},
              {'text': 'Optical Sensor', 'score': 0},
            ],
          },
          {
            'questionText':
                "'.MOV' extension refers usually to what kind of file?",
            'answers': [
              {'text': 'Image file', 'score': 0},
              {'text': 'Animation/movie file', 'score': 1},
              {'text': 'Audio file', 'score': 0},
              {'text': 'MS Office document', 'score': 0},
            ],
          },
          {
            'questionText':
                "In which decade was the SPICE simulator introduced?",
            'answers': [
              {'text': '1950s', 'score': 0},
              {'text': '1960s', 'score': 0},
              {'text': '1970s', 'score': 1},
              {'text': '1980s', 'score': 0},
            ],
          },
        ];
      });
    } else if (index == 1) {
      setState(() {
        _questions = const [
          {
            'questionText': "Which county did Ravi Shastri play for?",
            'answers': [
              {'text': 'Glamorgan', 'score': 1},
              {'text': 'Leicestershire', 'score': 0},
              {'text': 'Gloucestershire', 'score': 0},
              {'text': 'Lancashire', 'score': 0},
            ],
          },
          {
            'questionText':
                "Who was the first Indian to win the World Amateur Billiards title?",
            'answers': [
              {'text': 'Geet Sethi', 'score': 0},
              {'text': 'Wilson Jones', 'score': 1},
              {'text': 'Michael Ferreira', 'score': 0},
              {'text': 'Manoj Kothari', 'score': 0},
            ],
          },
          {
            'questionText': "Ricky Ponting is also known as what?",
            'answers': [
              {'text': 'The Rickster', 'score': 0},
              {'text': 'Ponts', 'score': 0},
              {'text': 'Ponter', 'score': 0},
              {'text': 'Punter', 'score': 1},
            ],
          },
        ];
      });
    } else if (index == 2) {
      setState(() {
        _questions = const [
          {
            'questionText': "The nucleus of an atom consists of",
            'answers': [
              {'text': 'electrons and neutrons', 'score': 0},
              {'text': 'electrons and protons', 'score': 0},
              {'text': 'protons and neutrons', 'score': 1},
              {'text': 'All of the above', 'score': 0},
            ],
          },
          {
            'questionText':
                "The most electronegative element among the following is",
            'answers': [
              {'text': 'sodium', 'score': 0},
              {'text': 'bromine', 'score': 0},
              {'text': 'fluorine', 'score': 1},
              {'text': 'oxygen', 'score': 0},
            ],
          },
          {
            'questionText':
                "The metal used to recover copper from a solution of copper sulphate is",
            'answers': [
              {'text': 'Na', 'score': 0},
              {'text': 'Ag', 'score': 0},
              {'text': 'Hg', 'score': 0},
              {'text': 'Fe', 'score': 1},
            ],
          },
        ];
      });
    } else if (index == 3) {
      setState(() {
        _questions = const [
          {
            'questionText': "Nuclear sizes are expressed in a unit named",
            'answers': [
              {'text': 'Fermi', 'score': 1},
              {'text': 'angstrom', 'score': 0},
              {'text': 'newton', 'score': 0},
              {'text': 'tesla', 'score': 0},
            ],
          },
          {
            'questionText': "Light year is a unit of",
            'answers': [
              {'text': 'Time', 'score': 0},
              {'text': 'distance', 'score': 1},
              {'text': 'light', 'score': 0},
              {'text': 'intensity of light', 'score': 0},
            ],
          },
          {
            'questionText': "Light from the Sun reaches us in nearly",
            'answers': [
              {'text': '2 minutes', 'score': 0},
              {'text': '4 minutes', 'score': 0},
              {'text': '8 minutes', 'score': 1},
              {'text': '16 minutes', 'score': 0},
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
