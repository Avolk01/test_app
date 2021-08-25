import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:register_page/assets/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:register_page/bloc/events.dart';
import 'package:register_page/bloc/reg_bloc.dart';
import 'package:register_page/bloc/states.dart';
import 'package:register_page/counter_bloc/counter_bloc.dart';
import 'package:register_page/models/firebase_controller.dart';
import 'package:register_page/models/shared_pref_controller.dart';
import 'package:register_page/ui/widgets/exception_bar.dart';
import 'package:register_page/ui/widgets/loading_help_screen.dart';
import 'package:register_page/ui/widgets/text_field_with_box.dart';
import 'counter_page.dart';
import 'package:firebase_core/firebase_core.dart';

class RegisterPage extends StatefulWidget {
  final bool _reg;
  final String _title;
  FirebaseApp defaultApp = Firebase.app();

  RegisterPage.reg(this._title) : _reg = true;

  RegisterPage.log(this._title) : _reg = false;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCheckController = TextEditingController();

  void openPage(String feedback, bool isNewUser) async {
    Navigator.popUntil(context, (context){ return true;});
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => CounterBloc(
              FirebaseController(mainCollection: 'users', optionalCollection: 'dates'),
              SharedPrefController(),
              feedback,
              DateFormat('yyyy-MM-dd').format(DateTime.now()),
              isNewUser,
            ),
            child: CounterPage(feedback),
          ),
        ));
  }

  String _exceptionMessage = '';
  bool _exceptionVisibility = false;
  bool _visible = false;
  bool _isNewUser = false;

  void finishOnPressed() {
    setState(() {
      _visible = true;
      _isNewUser = widget._reg;
    });
    if (widget._reg)
      context.read<RegBloc>().add(SignUp(loginController.text,
          passwordController.text, passwordCheckController.text));
    else
      context
          .read<RegBloc>()
          .add(SignIn(loginController.text, passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegBloc, RegState>(
      listener: (context, state) {
        if (state.exceptionMessage.isEmpty)
          openPage(state.feedback, _isNewUser);
        _exceptionMessage = state.exceptionMessage;
        _exceptionVisibility = state.exceptionMessage.isNotEmpty;
        _visible = false;
      },
      child: BlocBuilder(
        bloc: context.watch<RegBloc>(),
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(widget._title),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    TextFieldWithBox(RegisterStrings.login, loginController),
                    SizedBox(
                      height: 30,
                    ),
                    TextFieldWithBox(
                        RegisterStrings.password, passwordController),
                    SizedBox(
                      height: 30,
                    ),
                    Visibility(
                      visible: widget._reg,
                      child: Column(children: [
                        TextFieldWithBox(RegisterStrings.applyPassword,
                            passwordCheckController),
                      ]),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FlatButton(
                      onPressed: finishOnPressed,
                      color: Colors.blue,
                      child: Text(
                        RegisterStrings.apply,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Visibility(
                        visible: _exceptionVisibility,
                        child: ExceptionBar(message: _exceptionMessage)),
                  ],
                ),
              ),
              LoadingHelpScreen(_visible),
            ],
          ),
        ),
      ),
    );
  }
}
