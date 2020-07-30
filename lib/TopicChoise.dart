import 'package:flutter/material.dart';
import 'package:flutterlessons/Question.dart';
import 'package:flutterlessons/TestPage.dart';
import 'dart:async';

import 'DB.dart';
import 'Topics.dart';

class TopicChoiseWindow extends StatefulWidget{
  List<topic> topics = [];
  TopicChoiseWindow({Key key, @required this.topics}){
    this.topics = topics;
  }
  @override
  TopicChoiseWindowState createState()=>TopicChoiseWindowState();
}

int _selected = 1;

class TopicChoiseWindowState extends State<TopicChoiseWindow>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выберите тему для тестирования'),
        elevation: 10.0,
      ),
      body:
       new ListView.builder(
          itemCount: widget.topics.length,
          itemBuilder: (bc, index){
            return RadioListTile(title: Text('${widget.topics.elementAt(index).getTopicId()}. ${widget.topics.elementAt(index).getTopicName()}'),
              value: widget.topics.elementAt(index).getTopicId(),
              groupValue: _selected,
              onChanged: (int value){
                setState(() {
                  _selected = value;
                  makeTest(value).then((test) => runTestPage(context, test));
                });
              },);
          }),
    );
  }
}

Future<List<Question>> makeTest(int idTopic) async{
  List<Map> _resultSet = [];
  List<Question> questions = [];
  List<int> idQuestionsSet = [];
  //print('Lists have been created');//DEBUG

  _resultSet = await DB.select('SELECT _id FROM questions WHERE idTopic = $idTopic');
  //print('Questions IDs queried: $_resultSet'); //DEBUG
  _resultSet.forEach((element) {
    idQuestionsSet.add(element.values.elementAt(0));
  });
  print('IDs located in array: $idQuestionsSet'); //DEBUG
  idQuestionsSet.forEach((element) async {
    _resultSet = await DB.select('SELECT *FROM questions WHERE _id = $element');
    //print('Question: $element'); //DEBUG
    int idQuestion = _resultSet.elementAt(0).values.elementAt(0);
    String nameQuestion = _resultSet.elementAt(0).values.elementAt(2);
    String correctAnswer = _resultSet.elementAt(0).values.elementAt(3);
    _resultSet = await DB.select('SELECT * FROM answers WHERE idQuestion = $idQuestion');
    //print('Answers quieried');
    List<Answer> answers = [];
    _resultSet.forEach((element) {
      bool isCorrect = element.values.elementAt(3)!=0 ? true : false; //если correct != 0 true else false
      answers.add(new Answer(element.values.elementAt(0), element.values.elementAt(2), isCorrect));
    });
    answers.shuffle();
    Question quest = new Question(idQuestion, nameQuestion, answers, correctAnswer);
    //print('Question $idQuestion is READY: $nameQuestion\n ${answers.elementAt(0).getNameAnswer()}'); //DEBUG
    questions.add(quest);
    //print(questions.length);//DEBUG
  });
  //print('final - ${questions.length}');
  return Future.value(questions);
}

void runTestPage(BuildContext context, List<Question> test){
  Navigator.push(context, MaterialPageRoute(builder: (context) => TestPage(test: test),));
}
