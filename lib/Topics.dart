class topic{
  int _idTopic;
  String _nameTopic;

  topic(int id, String name){
    this._idTopic = id;
    this._nameTopic = name;
  }

  int getTopicId(){
    return _idTopic;
  }

  String getTopicName(){
    return _nameTopic;
  }
}