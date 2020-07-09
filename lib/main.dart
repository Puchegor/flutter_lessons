
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'TestPage.dart';
import 'Question.dart';
import 'DB.dart';
import 'TopicChoise.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = DB.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Тесты по Экономической теории',
      home: MainWindow(),
    );
  }
}

class MainWindow extends StatefulWidget{
  @override
  MainWindowState createState()=>MainWindowState();
}

class MainWindowState extends State<MainWindow>{
  List<Question>test;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Тесты по Экономической теории'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: (){
              exit(0);
            },
          )
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Padding(padding: EdgeInsets.all(20.0),
              child: Text('Выберите режим тестирования:',
              style: TextStyle(fontSize: 20.0),),),
          ),
          Padding(padding: EdgeInsets.all(20.0),
            child: RadioChoiseGroup(),),//
          Padding(padding: EdgeInsets.all(40),),
          MaterialButton(
            child: Text('Продолжить'),
            color: Colors.amber,
            onPressed: (){
              print(''); //Вывод состояния radioGroup
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TestPage()));
            },
          )
        ],
      ),
    );
  }
}

class RadioChoiseGroup extends StatefulWidget{
  @override
  RadioGroupState createState () => RadioGroupState();
}

enum testChoise {stdTopic, ctrlTopic, ctrlSubject}


class RadioGroupState extends State<RadioChoiseGroup>{
  testChoise _choise = testChoise.stdTopic;
  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Обучающий тест по теме...'),
          subtitle: const Text('Будут показываться правильные ответы и пояснения к вопросам по выбранной теме'),
          leading: Radio(
            value: testChoise.stdTopic,
            groupValue: _choise,
            onChanged: (testChoise value){
              setState(() {
                _choise = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Контрольный тест по теме...'),
          subtitle: const Text('''По окончании теста по выбранной теме вам будут показаны правильные ответы и даны пояснения.'''),
          leading: Radio(
            value: testChoise.ctrlTopic,
            groupValue: _choise,
            onChanged: (testChoise value){
              setState(() {
                _choise = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Контрольный тест по курсу'),
          subtitle: const Text('Вопросы случайным образом выбираются из всех тем. Есть лимит времени'),
          leading: Radio(
            value: testChoise.ctrlSubject,
            groupValue: _choise,
            onChanged: (testChoise value){
              setState(() {
                _choise = value;
              });
            },
          ),
        )
      ],
    );
  }
}