import 'package:firebase_auth/firebase_auth.dart';
import 'package:register_page/assets/strings.dart';

import 'manager.dart';

class Registrator implements Manager {

  String _exceptionMessage = '';
  String get exceptionMessage => _exceptionMessage;

  Future<String> signUp(String log, String pass, String checkPassword) async {
    if (pass != checkPassword) {
      _exceptionMessage = ExceptionStrings.differentPassword;
      return '5';
    } else if (log.isEmpty || pass.isEmpty || checkPassword.isEmpty) {
      _exceptionMessage = ExceptionStrings.emptyFields;
      return '1';
    } else
      try {
        var userUid = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: log,
          password: pass,
        );
        return userUid.user!.uid;

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          _exceptionMessage = ExceptionStrings.weakPassword;
          return '6';
        } else if (e.code == 'email-already-in-use') {
          _exceptionMessage = ExceptionStrings.emailAlreadyUsed;
          return '7';
        }
      }
    _exceptionMessage = ExceptionStrings.signUpError;
    return '8';
  }

  @override
  Future<String> sendRequest(String log, String pass, {String checkPass = ''}) async {
    return await signUp(log,pass, checkPass);
  }
}
