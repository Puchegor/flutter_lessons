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
                });
              },);
          }),
      bottomNavigationBar: BottomAppBar(
        color: Colors.amber,
        elevation: 20.0,
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0,),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 20.0,
        tooltip: 'Продолжить',
        child: Icon(Icons.arrow_forward),
        onPressed: (){
          Test test = makeTest(_selected);
          runTestPage(context, test);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }
}

Test makeTest(int idTopic){
  Test test = new Test(idTopic);
  return test;
}

void runTestPage(BuildContext context, Test test){
  Navigator.push(context, MaterialPageRoute(builder: (context) => TestPage(test: test),));
}