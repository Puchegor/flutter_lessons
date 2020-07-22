import 'package:flutter/material.dart';

import 'DB.dart';
import 'Topics.dart';

class TopicChoiseWindow extends StatefulWidget{
  @override
  TopicChoiseWindowState createState()=>TopicChoiseWindowState();
}

class TopicChoiseWindowState extends State<TopicChoiseWindow>{
  List<topic> topics;
  List<Widget> topicsList = new List<Widget>();

  TopicChoiseWindowState({Key key, @required this.topics});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выберите тему для тестирования'),
      ),
      body: Padding(padding: EdgeInsets.all(20.0),
      child: topicChoiseGroup(),)
    );
  }
}

class topicChoiseGroup extends StatefulWidget{
  @override
  topicChoiseState createState() => topicChoiseState();
}

class topicChoiseState extends State<topicChoiseGroup>{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

      ],
    );
  }
}
