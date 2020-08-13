
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterlessons/Setup.dart';
import 'Question.dart';
import 'DB.dart';
import 'TopicChoise.dart';
import 'Topics.dart';

double numberOfQuestions;
double timer;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = DB.init();
  //Setup setup = new Setup();
  numberOfQuestions = Setup.getNumberOfQuestions();
  timer = Setup.getTime();
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
        ],
      ),
      drawer: Drawer(child:
          ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Настройки', style: TextStyle(fontSize: 20.0),),
                decoration: BoxDecoration(
                  color: Colors.amber
                ),
              ),
              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.assignment),
                      title: Text('Вопросов в тесте'),
                      subtitle: Text('Количество вопросов в контрольном тесте'),
                    ),
                    SliderQuestionsWidget(),
                  ],
                )
              ),
              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.access_time),
                      title: Text('Время решения:'),
                      subtitle: Text('Время для решения контрольных тестов'),
                    ),
                    SliderTimeWidget(),
                  ],
                )
              )
            ],
          )
        ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.amber,
        elevation: 20.0,
        child: Container(height: 50.0,),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Продолжить',
        child: Icon(Icons.arrow_forward),
        onPressed: (){
          pressNextBtn(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
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

void pressNextBtn(BuildContext context){
  switch(_selected){
    case 0:
      runTopicChoise(context, false);
      break;
    case 1:
      runTopicChoise(context, true);
      break;
    case 2:
      //_resultSet = await DB.select('sql')
      break;
    default:
  }
}

void runTopicChoise(BuildContext context, bool isControl)async{
  List<Map> _resultSet;
  _resultSet = await DB.select('SELECT * FROM topics');
  List<topic> listTopics=[];
  _resultSet.forEach((element) {
    topic top = topic(element.values.elementAt(0), element.values.elementAt(2));
    listTopics.add(top);
  });
  Navigator.push(context, MaterialPageRoute(builder: (context)=>TopicChoiseWindow(topics: listTopics)));
}

class SliderQuestionsWidget extends StatefulWidget{
  @override
  SliderQuestionsWidgetState createState()=>SliderQuestionsWidgetState();
}

class SliderQuestionsWidgetState extends State<SliderQuestionsWidget>{
  var _value = numberOfQuestions;
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _value,
      activeColor: Colors.amber,
      min: 0,
      max: 100.0,
      divisions: 20,
      label: '${_value.round()} вопросов',
      onChanged: (double value){
        setState(() {
          _value = value;
          Setup.setNumberOfQuestions(value);
        });
      },
    );
  }
}

class SliderTimeWidget extends StatefulWidget{
  @override
  SliderTimeWidgetState createState()=>SliderTimeWidgetState();
}

class SliderTimeWidgetState extends State<SliderTimeWidget>{
  var _value = timer;
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _value,
      activeColor: Colors.amber,
      min: 0,
      max: 60.0,
      divisions: 12,
      label: '${_value.round()} минут',
      onChanged: (double value){
        setState(() {
          _value = value;
          Setup.setTime(value);
        });
      },
    );
  }
}
