abstract class Manager{
  String get exceptionMessage =>'';
  Future<String> sendRequest(String log, String pass, {String checkPass = ''});
}