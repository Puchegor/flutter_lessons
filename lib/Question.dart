class Question{
  int _idQuestion;
  String _nameQuestion;
  List<Answer> _answers;
  String _correctAnswer;

  Question(int id, String question, List<Answer> answers, String correct){
    this._idQuestion = id;
    this._nameQuestion = question;
    this._answers = answers;
    this._correctAnswer = correct;
  }

  int getIdQuestion(){
    return _idQuestion;
  }

  String getNameQuestion(){
    return _nameQuestion;
  }

  List<Answer> getAnswers(){
    return _answers;
  }

  String getCorrectAnswer(){
    return _correctAnswer;
  }
}

class Answer{
  int _idAnswer;
  String _nameAnswer;
  bool _isCorrect;

  Answer(int id, String answer, bool isCorrect){
    this._idAnswer = id;
    this._nameAnswer = answer;
    this._isCorrect = isCorrect;
  }

  int getIdAnswer(){
    return _idAnswer;
  }

  String getNameAnswer(){
    return _nameAnswer;
  }

  bool getIsTrue(){
    return _isCorrect;
  }
}