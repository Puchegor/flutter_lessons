import 'DB.dart';

class Setup {
  static const double defaultTime = 20;
  static const double  defaultQuestions = 20;

  static double _userTime;
  static double _userQuestions;

  static void init(){ //проверить наличие таблицы options и данных
    var _resultSet = DB.select('SELECT numberOfQuestions FROM options');
    _resultSet.then((value) => _userQuestions = value.elementAt(0).values.elementAt(0));
    _resultSet = DB.select('SELECT time FROM options');
    _resultSet.then((value) => _userTime = value.elementAt(0).values.elementAt(0));
  }

  static void setTime(double time){
    _userTime = time;
    DB.createSetupTable();
    DB.updateSetupData('time', time);
  }

  static void setNumberOfQuestions(double questions){
    _userQuestions = questions;
    DB.createSetupTable();
    DB.updateSetupData('numberOfQuestions', questions);
  }

  static double getNumberOfQuestions(){
    if (_userQuestions == null){
      return defaultQuestions;
    } else {
      return _userQuestions;
    }
  }

  static double getTime(){
    if(_userTime == null){
      return defaultTime;
    } else {
      return _userTime;
    }
  }
}
