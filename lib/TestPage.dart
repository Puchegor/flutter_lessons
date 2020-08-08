import 'package:flutter/material.dart';
import 'package:flutterlessons/Question.dart';
import 'package:flutterlessons/Test.dart';

class TestPage extends StatefulWidget{
  Test test;
  TestPage({Key key, @required this.test}) : super(key: key){
    this.test = test;
    test.getTest().shuffle();
  }
  @override
  TestPageState createState() => TestPageState();
}

class TestPageState extends State<TestPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Тест по теме'),
      ),
      body: Cards(),
    );
  }
}

class Cards extends StatefulWidget{
  @override
  CardsState createState()=>CardsState();
}

class CardsState extends State<Cards>{
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.question_answer),
                        title: Text('Card in Stack. What should I do next?'),
                        subtitle: Text('I really don\'t know'),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}