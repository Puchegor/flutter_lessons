import 'package:flutter/material.dart';
import 'package:flutterlessons/Question.dart';
import 'package:flutterlessons/Test.dart';
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
                  makeTest(value);
                });
              },);
          }),
    );
  }
}

Test makeTest(int idTopic){
  Test test = new Test(idTopic);
  print(test.getTest().toString());
  return test;
}

void runTestPage(BuildContext context, List<Question> test){
  Navigator.push(context, MaterialPageRoute(builder: (context) => TestPage(test: test),));
}