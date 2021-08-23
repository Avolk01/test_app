import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:register_page/ui/counter_page.dart';
import 'package:register_page/ui/home_page.dart';
import 'package:register_page/ui/widgets/main_splash_screen.dart';

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
  Future<bool> alreadyLogin() async {
    return true;
  }

  String _uid = '';
  bool _alreadyLogin = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Регистрация",
      home: MainSplashScreen(
        true
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
