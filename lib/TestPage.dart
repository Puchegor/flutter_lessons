import 'package:flutter/material.dart';
import 'package:flutterlessons/Question.dart';
import 'package:flutterlessons/Test.dart';
import 'dart:async';

class TestPage extends StatefulWidget{
  int idTopic;
  TestPage({Key key, @required this.idTopic}) : super(key: key){
    this.idTopic = idTopic; //Конструктор получает id темы
  }
  @override
  TestPageState createState() => TestPageState(idTopic);
}

class TestPageState extends State<TestPage>{
  int _id;
  TestPageState(int idTopic){
    _id = idTopic;
  }
  
  @override
  Widget build(BuildContext context) {

  }

}