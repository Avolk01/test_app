import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:register_page/assets/strings.dart';
import 'package:register_page/ui/counter_page.dart';
import 'package:register_page/ui/home_page.dart';
import 'package:register_page/ui/widgets/main_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'counter_bloc/counter_bloc.dart';
import 'models/firebase_controller.dart';
import 'models/shared_pref_controller.dart';

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

  Future<void> alreadyLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString(FieldsStrings.uid);
    var date = prefs.getString(FieldsStrings.date);
    if (uid == null || date == null) {
      _alreadyLogin = false;
      _isNewDate = true;
    } else {
      _uid = uid;
      _alreadyLogin = true;
      _isNewDate = DateFormat('yyyy-mm-dd').format(DateTime.now()) == date;
    }
    _alreadyLogin = _uid.isNotEmpty;
  }

  String _uid = '';
  bool _alreadyLogin = true;
  bool _isNewDate = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TitleStrings.mainTitle,
      home: FutureBuilder(
        future: alreadyLogin(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _alreadyLogin
                ? BlocProvider(
                    create: (context) => CounterBloc(
                      FirebaseController(
                          mainCollection: 'users', optionalCollection: 'dates'),
                      SharedPrefController(),
                      _uid,
                      DateFormat('yyyy-MM-dd').format(DateTime.now()),
                      _isNewDate,
                    ),
                    child: CounterPage(_uid),
                  )
                : HomePage();
          } else
            return MainSplashScreen();
        },
      ),
    );
  }
}
