import 'package:flutter/material.dart';

class MainSplashScreen extends StatefulWidget {
  MainSplashScreen(this.nextScreen, this.duration);

  Widget nextScreen;
  int duration;

  @override
  _MainSplashScreenState createState() =>
      _MainSplashScreenState(nextScreen, duration);
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  _MainSplashScreenState(this.nextScreen, this.duration);

  bool _visible = true;
  Widget nextScreen;

  int? duration;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(milliseconds: duration!),
      () {
        setState(
          () {
            _visible = false;
          },
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) =>nextScreen));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible,
      child: Container(
        color: Colors.blue[300],
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
