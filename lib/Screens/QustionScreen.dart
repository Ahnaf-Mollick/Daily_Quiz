import 'package:flutter/material.dart';

import '../data/dataManager.dart';
import 'ResultScreen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final DataManager _dataManager = DataManager();
  late final List<Map<String, dynamic>> _questionList =
      _dataManager.questions_list;
  late int totalmarks = _dataManager.finalMarks;
  int currentQuestionIndex = 0;
  bool isAnswered = false;
  int? currentAnswerIndex;
  void answerChecker(int index) {
    if (isAnswered) return;
    setState(() {
      currentAnswerIndex = index;
      if (currentAnswerIndex == _questionList[currentQuestionIndex]['answer']) {
        totalmarks++;
        isAnswered = true;
      } else {
        isAnswered = true;
      }
    });
  }

  Color answerColor(int index) {
    if (!isAnswered) return Colors.black87;
    final correctAnswer = _questionList[currentQuestionIndex]['answer'];
    if (index == correctAnswer) {
      return Colors.lightGreen;
    } else if (index == currentAnswerIndex) {
      return Colors.redAccent;
    }
    return Colors.black87;
  }

  void submitQuiz() {
    setState(() {
      _dataManager.finalMarks = totalmarks;
      _dataManager.testNumber + 1;
      _dataManager.addResult();
      currentQuestionIndex = 0;
      currentAnswerIndex = null;
      isAnswered = false;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ResultScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Qustions for today',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white54,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Text('Total Number of Questions: ${_questionList.length}'),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: currentQuestionIndex + 1 / _questionList.length,
              color: Colors.lightBlueAccent,
              backgroundColor: Colors.grey,
            ),
            Text('Question ${currentQuestionIndex + 1}'),
            SizedBox(height: 25),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.lightBlueAccent, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _questionList[currentQuestionIndex]['question'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            ...List.generate(
              _questionList[currentQuestionIndex]['options'].length,
              (index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () => answerChecker(index),
                      child: Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: answerColor(index),
                          border: Border.all(
                            color: Colors.lightBlueAccent,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            _questionList[currentQuestionIndex]['options'][index],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                );
              },
            ),
            const Spacer(),
            SafeArea(
              child: GestureDetector(
                onTap: isAnswered
                    ? () {
                        if (currentQuestionIndex == _questionList.length - 1) {
                          submitQuiz();
                        } else {
                          setState(() {
                            currentQuestionIndex++;
                            isAnswered = false; // reset for next question
                          });
                        }
                      }
                    : null, // disables tap when not answered
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isAnswered ? Colors.lightBlueAccent : Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    currentQuestionIndex == _questionList.length - 1
                        ? "Submit Quiz"
                        : "Next Question",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
