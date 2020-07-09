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
}