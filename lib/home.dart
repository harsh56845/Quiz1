import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app_1/answer.dart';

class Home extends StatefulWidget {
 const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _questionIndex = 0;

  int _totalScore = 0;

  bool answerWasSelected = false;

  bool endOfQuiz = false;

  late List<Icon> _scoreTracker = [];

  Color textColor = Colors.black;

  bool _correctAnswerSelected = false;

  void _questionAnswered(bool answerScore) {
    setState(() {
      answerWasSelected = true;
      if (answerScore) {
        _totalScore = _totalScore + 1;
        _correctAnswerSelected = true;
      }
      _scoreTracker.add(answerScore
          ? const Icon(
              Icons.check_circle,
              color: Colors.green,
            )
          : const Icon(
              Icons.cancel,
              color: Colors.red,
            ));
      textColor = Colors.white;
    });
  }

  void _nextQuestion() {
    setState(() {
      textColor = Colors.black;
      _questionIndex++;
_correctAnswerSelected = false;
      answerWasSelected = false;
      if (_questionIndex + 1 == _questions.length) {
        endOfQuiz = true;

        print(_questionIndex + 1);
        print("lengthh +  ${_questions.length}");
      }
      //   if (_questionIndex >= _questions.length) {
      //   _reset();
      // }
    });
  }

  void _reset() {
    setState(() {
      _questionIndex = 0;
      endOfQuiz = false;
      _scoreTracker = [];
      _totalScore = 0;
      answerWasSelected = false;
      textColor = Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('GK QUIZ'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                if (_scoreTracker.isEmpty)
                  SizedBox(
                    height: 20,
                  ),
                if (_scoreTracker.length > 0) ..._scoreTracker
              ],
            ),
            Container(
              height: 130,
              width: double.infinity,
              margin: const EdgeInsets.only(
                  left: 30, right: 30, bottom: 20, top: 15),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(165, 55, 253, 1)),
              child: Center(
                child: Text(
                  _questions[_questionIndex]['question'],
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            ...(_questions[_questionIndex]['answers']
                    as List<Map<String, Object?>>)
                .map(
              (answers) => Answer(
                answerText: '${answers['answerText']}',
                answerColor: answerWasSelected
                    ? (answers['score'] == true)
                        ? Colors.green
                        : Colors.red
                    : null,
                answerTap: () {
                  if (answerWasSelected) {
                    return;
                  }
                  if (answers['score'] == true) {
                    _questionAnswered(true);
                  } else {
                    _questionAnswered(false);
                  }
                },
                textColor: textColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 10, right: 10, bottom: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40)),
                onPressed: () {
                  if (!answerWasSelected) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please Select an option to go further"),
                      ),
                    );

                    return;
                  }
                  endOfQuiz ? _reset() : _nextQuestion();
                },
                child: Text(
                  endOfQuiz ? 'Restart Quiz' : 'Next Question',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Container(
              padding:const EdgeInsets.all(10),
              child: Text("${_totalScore.toString()} / ${_questions.length}",
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            if(answerWasSelected)
            Expanded(
              child: _correctAnswerSelected ? Container(
                decoration: BoxDecoration(color: Colors.green),
                width: double.infinity,
                 child: Center(child: Text('Well done you Got it right :-)',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)),
                 ):Container(
                decoration: BoxDecoration(color: Colors.red),
                width: double.infinity,
                 child: Center(child: Text('Wrong :-/',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)),
                 )
            ) ,
           if(answerWasSelected == true && endOfQuiz == true)
             Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.purple),
                width: double.infinity,
                 child: Center(child: Text("Your Total Score Is $_totalScore",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)),
                 )
            ),
          ],
        ),
      ),
      bottomNavigationBar:endOfQuiz ?Text("Made By Harsh",style: TextStyle(),textAlign: TextAlign.right,) : null,
    );
  }
}

List<Map> _questions = [
  {
    'question': 'In which state / union territory, Karaikal Port is located?',
    'answers': [
      {'answerText': 'Puducherry', 'score': true},
      {'answerText': 'Tamil Nadu', 'score': false},
      {'answerText': 'Kerala', 'score': false},
    ],
  },
  {
    'question':
        'The Draft Indian Ports Bill 2020, which has been circulated, seeks to repeal and replace which act?',
    'answers': [
      {'answerText': 'Indian Ports Act, 1948', 'score': false},
      {'answerText': 'Indian Ports Act, 1928', 'score': false},
      {'answerText': 'Indian Ports Act, 1908', 'score': true},
    ],
  },
  {
    'question': 'What was the name of Gautam Buddha’s only son ?',
    'answers': [
      {'answerText': 'Kanthala', 'score': false},
      {'answerText': 'Channa', 'score': false},
      {'answerText': 'Rahul', 'score': true},
    ],
  },
  {
    'question': 'Which among the following is not present in pure sugar ?',
    'answers': [
      {'answerText': 'Hydrogen', 'score': false},
      {'answerText': 'Nitrogen', 'score': true},
      {'answerText': 'Carbon', 'score': false},
    ],
  },
  {
    'question': 'Which of the following represents Pressure?',
    'answers': [
      {'answerText': 'Force/Area', 'score': true},
      {'answerText': 'Force/Density', 'score': false},
      {'answerText': 'Force x Area', 'score': false},
    ],
  },
  {
    'question':
        'Which institution cautioned against taking loans through unauthorised digital lending apps?',
    'answers': [
      {'answerText': 'RBI', 'score': true},
      {'answerText': 'SEBI', 'score': false},
      {'answerText': 'Supreme Court', 'score': false},
    ],
  },
  {
    'question': 'As of 2021, which is the world’s largest political party?',
    'answers': [
      {'answerText': 'Chinese Communist Party (CCP)', 'score': false},
      {'answerText': 'Democratic Party (United States)', 'score': false},
      {'answerText': 'Bhartiya Janata Party (BJP)', 'score': true},
    ],
  },
  {
    'question': 'Sohra is a town located in which Indian state/UT?',
    'answers': [
      {'answerText': 'Madhya Pradesh', 'score': false},
      {'answerText': 'Arunachal Pradesh', 'score': false},
      {'answerText': 'Meghalaya', 'score': true},
    ],
  },
  {
    'question':
        'Which of the following is the poorest conductor of heat in comparison to other options?',
    'answers': [
      {'answerText': 'Mercury', 'score': false},
      {'answerText': 'Silver', 'score': false},
      {'answerText': 'Lead', 'score': true},
    ],
  },
  {
    'question':
        'Which molecule is the genetic material of the SARS-CoV-2 virus?',
    'answers': [
      {'answerText': 'DNA', 'score': false},
      {'answerText': 'RNA', 'score': true},
      {'answerText': 'Both the above', 'score': false},
    ],
  },
];
