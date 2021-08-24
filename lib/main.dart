import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:register_page/ui/counter_page.dart';
import 'package:register_page/ui/home_page.dart';
import 'package:register_page/ui/widgets/main_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'counter_bloc/counter_bloc.dart';
import 'models/firebase_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(RegisterApp());
}

class RegisterApp extends StatefulWidget {
  @override
  _RegisterAppState createState() => _RegisterAppState();
}

class _RegisterAppState extends State<RegisterApp> {
  void alreadyLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _uid = prefs.getString('uid')!;
    print('uid main = $_uid');
    _alreadyLogin = _uid.isNotEmpty;
    print('flag main = $_alreadyLogin');
  }

  String _uid = '';
  bool _alreadyLogin = true;

  @override
  void initState(){
    super.initState();
    alreadyLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Регистрация",
      home: MainSplashScreen(
        _alreadyLogin
            ? BlocProvider(
                create: (context) => CounterBloc(
                  FirebaseController(
                      mainCollection: 'users', optionalCollection: 'dates'),
                  _uid,
                  DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  false,
                ),
                child: CounterPage(_uid),
              )
            : HomePage(),
        3000,
      ),
    );
  }
}
