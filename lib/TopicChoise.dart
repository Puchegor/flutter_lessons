import 'package:flutter/material.dart';

import 'DB.dart';

class TopicChoiseWindow extends StatefulWidget{
  @override
  TopicChoiseWindowState createState()=>TopicChoiseWindowState();
}

class TopicChoiseWindowState extends State<TopicChoiseWindow>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выберите тему для тестирования'),
      ),
    );
  }
}
