import 'package:flutter/material.dart';

class TestPage extends StatefulWidget{
  //TestPage({Key key, @required this.text}) : super(key: key);
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