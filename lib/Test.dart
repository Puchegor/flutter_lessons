import 'package:flutterlessons/Question.dart';
import 'DB.dart';

class Test{
  static List<Question>_test;
  static String _topic;

  Test(int idTopic){
    setTest(idTopic);
    setTopic(idTopic);
  }

  List<Question>getTest(){
    return _test;
  }

  String getTopic(){
    return _topic;
  }

  void setTopic(int idTopic)async{
    if (idTopic != null) {
      List<Map> _resultSet = await DB.select(
          'SELECT nameTopic FROM topics WHERE _id = $idTopic');
      _topic = _resultSet.elementAt(0).values.elementAt(0);
    }else{
      _topic = 'Контрольный тест по курсу';
    }
  }

  void setTest(int idTopic) async{
    List<Map>_resultSet;
    if (idTopic!=null){
      //Для тестов по теме
      _resultSet = await DB.select('SELECT _id FROM questions WHERE idTopic = $idTopic');
      List<int> questionsIDs=[];
      _resultSet.forEach((id) {
        questionsIDs.add(id.values.elementAt(0));
      });
      if(questionsIDs.length == null)
        print('Вопросы к теме отсутствуют');
      questionsIDs.forEach((id) async {
        _resultSet = await DB.select('SELECT nameQuestion, correctAnswer FROM questions WHERE _id =$id');
        _resultSet.forEach((quest) async {
          int idQuestion = id;
          String nameQuestion = quest.values.elementAt(0);
          String correctAnswer = quest.values.elementAt(1);
          //print('$id, $nameQuestion, $correctAnswer');
          List<Answer>answers = [];
          List<Map>_answerSet = await DB.select('SELECT * FROM answers WHERE idQuestion = $id');
          _answerSet.forEach((ans) {
            bool isCorrect = ans.values.elementAt(3) != 0 ? true : false;
            answers.add(new Answer(ans.values.elementAt(0), ans.values.elementAt(2), isCorrect));
            answers.shuffle();
          });
          Question question = new Question(idQuestion, nameQuestion, answers, correctAnswer);
          _test.add(question);
        });
      });
    }else{
      //Для контрольного теста по курсу
    }
  }
}