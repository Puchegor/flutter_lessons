import 'package:flutterlessons/Question.dart';
import 'DB.dart';

class Test{
  List<Question>_test;
  String _topic;

  Test(int idTopic){
    setTest(idTopic);
    setTest(idTopic);
  }

  List<Question>getTest(){
    return _test;
  }

  String getTopic(){
    return _topic;
  }

  void setTest(int idTopic){
    List<int>_questionsIDs = _getQuestionsIDs(idTopic);  // ---------ID вопросов входящих в тему-------------------------
    _questionsIDs.forEach((element) {
      _getQuestions(element);
    });
  }

  void setTopic(int idTopic)async{
    List<Map> _resultSet = await DB.select('SELECT nameTopic FROM topics WHERE _id = $idTopic');
    _topic = _resultSet.elementAt(0).values.elementAt(0);
  }
  
  List<int>_getQuestionsIDs(int idTopic){
    List<int> _questionsIDs = [];
    DB.select('SELECT _id FROM questions WHERE idTopic = $idTopic').forEach((element) {
      _questionsIDs.add(element.values.elementAt(0));
    });
  }

  List<Answer>_getAnswers(int idQuestion){
    List<Answer> answers = [];
    DB.select('SELECT * FROM answers WHERE idQuestion = $idQuestion').forEach((element) {
      bool isCorrect = element.values.elementAt(3) !=0 ? true : false;
      answers.add(new Answer(element.values.elementAt(0),
          element.values.elementAt(2), isCorrect));
    });
    answers.shuffle();
    return answers;
  }

  List<Question>_getQuestions(int idQuestion){
    List<Question>questions = [];
    DB.select('SELECT nameQuestion, correctAnswer FROM questions WHERE _id = $idQuestion').forEach((element) {
      String nameQuestion = element.values.elementAt(0);
      String correctAnswer = element.values.elementAt(1);
      List<Answer> answers = _getAnswers(idQuestion);
      questions.add(new Question(idQuestion, nameQuestion, answers, correctAnswer));
    });
    questions.shuffle();
    return questions;
  }
}