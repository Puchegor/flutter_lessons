
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'TestPage.dart';
import 'Question.dart';
import 'DB.dart';
import 'TopicChoise.dart';
import 'Topics.dart';

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
      theme: ThemeData(primarySwatch: Colors.amber),
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
              pressNextBtn();
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>TestPage()));
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

int _selected = 0;

class RadioGroupState extends State<RadioChoiseGroup>{
  @override
  Widget build(BuildContext context) {
    return Column(
      children:<Widget>[
        RadioListTile(
          value: 0,
          groupValue: _selected,
          title: Text('Обучающий тест по теме...'),
          subtitle: Text('При решении теста появляются подсказки с правильными ответами'),
          onChanged: (int value){
            setState((){
              _selected = value;
            });
          },
        ),
        RadioListTile(
          value: 1,
          groupValue: _selected,
          title: Text('Контрольный тест по теме...'),
          subtitle: Text('Тест только по выбранной теме. Правильные ответы можно будет посмотреть по окончании теста.'),
          onChanged: (int value){
            setState(() {
              _selected = value;
            });
          },
        ),
        RadioListTile(
          value: 2,
          groupValue: _selected,
          title: Text('Конотрольный тест по курсу'),
          subtitle: Text('Вопросы выбираются случайным образом из всех тем курса. Правильные ответы можно посмотреть после окончания теста'),
          onChanged: (int value){
            setState(() {
              _selected = value;
            });
          },
        )
      ]
    );
  }
}

void pressNextBtn() async{
  List<Map> _resultSet;
  switch(_selected){
    case 0:
      _resultSet = await DB.select('SELECT * FROM topics');
      _resultSet.forEach((row) => print(row));
      //List<topic> listTopics;
      //for (int i = 0; i<_resultSet.length; i++){
        //listTopics.add(new topic(_resultSet[i].['_id'], _resultSet[i].values as String));
      //}
      break;
    case 1:
      _resultSet = await DB.select('SELECT * FROM topics');
      break;
    case 2:
      //_resultSet = await DB.select('sql')
      break;
    default:
  }
}
