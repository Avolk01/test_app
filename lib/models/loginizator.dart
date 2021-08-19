import 'package:firebase_auth/firebase_auth.dart';
import 'package:register_page/assets/strings.dart';
import 'manager.dart';

class Loginizator implements Manager {

  String _exceptionMessage = '';
  String get exceptionMessage => _exceptionMessage;

  Future<String> signIn(String log, String pass) async {
    if (log.isNotEmpty && pass.isNotEmpty) {
      try {
        var userUid = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: log,
          password: pass,
        );
        return userUid.user!.uid;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          _exceptionMessage = ExceptionStrings.userNotFound;
          return '2';
        } else if (e.code == 'wrong-password') {
          _exceptionMessage = ExceptionStrings.wrongPassword;
          return '3';
        }
      }
    } else {
      _exceptionMessage = ExceptionStrings.emptyFields;
      return '1';
    }
    _exceptionMessage = ExceptionStrings.signInError;
    return '4';
  }

  @override
  Future<String> sendRequest(String log, String pass, {String checkPass = ''}) async {
    return await signIn(log,pass);
  }
}

