import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:register_page/ui/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(RegisterApp());
}

class RegisterApp extends StatefulWidget {
  @override
  _RegisterAppState createState() => _RegisterAppState();
}

class _RegisterAppState extends State<RegisterApp> {
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Регистрация", home: HomePage());
  }
}
