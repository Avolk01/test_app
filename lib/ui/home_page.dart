import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:register_page/bloc/reg_view.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Регистрация")),
      ),
      body: RegView(),
    );
  }
}

