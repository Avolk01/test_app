import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_page/bloc/states.dart';
import 'package:register_page/models/manager.dart';
import 'events.dart';

class RegObserver extends BlocObserver {

}

class RegBloc extends Bloc<RegEvent, RegState> {
  RegBloc(this.mg) : super(RegState.waiting());
  bool _error = false;
  String _exceptionMessage = '';
  Manager mg;

  bool _checkFeedback(String feedback) {
    return feedback != '1' &&
        feedback != '2' &&
        feedback != '3' &&
        feedback != '4' &&
        feedback != '5' &&
        feedback != '6' &&
        feedback != '7' &&
        feedback != '8' &&
        feedback != '';
  }

  @override
  Stream<RegState> mapEventToState(RegEvent event) async* {
    String feedback = await mg.sendRequest(event.login, event.password, checkPass: event.checkPassword);
    _exceptionMessage = mg.exceptionMessage;
    _error = !_checkFeedback(feedback);

    await Future.delayed(Duration(seconds: 3));

    if (!_error) {
      yield RegState.complete(feedback);
    } else {
      yield RegState.exception(_exceptionMessage);
    }
  }
}
