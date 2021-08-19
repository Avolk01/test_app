import 'package:flutter/cupertino.dart';
import 'package:register_page/assets/strings.dart';
import 'manager.dart';

class Controller with ChangeNotifier {
  Manager mg;
  String exceptionMessage = "";

  bool get isValid => exceptionMessage.isEmpty;
  bool get isDone => feedback.isNotEmpty;

  String feedback = "";

  Controller(this.mg);

  Future<void> finish(String log, String pass) async {
    if (log.isNotEmpty && pass.isNotEmpty) {
      try {
        feedback = await mg.sendRequest(log, pass);
      } catch (exc) {
        exceptionMessage = exc.toString();
      }
    } else {
      exceptionMessage = ExceptionStrings.emptyFields;
    }
    notifyListeners();
  }
}
