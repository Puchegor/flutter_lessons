import 'DB.dart';

class Setup {
  static const double defaultTime = 20;
  static const double  defaultQuestions = 20;

  static double _userTime;
  static double _userQuestions;

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
    var _resultSet = DB.select('SELECT numberOfQuestions FROM options');

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
