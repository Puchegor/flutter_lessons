import 'package:flutter/material.dart';
import 'package:flutterlessons/Question.dart';

class TestPage extends StatefulWidget{
  List<Question>test = [];
  TestPage({Key key, @required this.test}) : super(key: key);
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
    );
  }
}