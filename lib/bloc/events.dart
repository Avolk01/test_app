import 'package:register_page/assets/strings.dart';

abstract class RegEvent {
  String get key => '';
  String get login => '';
  String get password => '';
  String get checkPassword =>'';
}

class SignIn implements RegEvent {
  SignIn(this._login, this._password);

  final String _key = TypeOfEventStrings.signIn;
  final String _login;
  final String _password;

  String get checkPassword => '';
  String get login => _login;
  String get password => _password;
  String get key => _key;
}

class SignUp implements RegEvent {
  SignUp(this._login, this._password, this._checkPassword);

  final String _key = TypeOfEventStrings.signUp;
  final String _login;
  final String _password;
  final String _checkPassword;

  String get login => _login;
  String get password => _password;
  String get key => _key;
  String get checkPassword => _checkPassword;
}
