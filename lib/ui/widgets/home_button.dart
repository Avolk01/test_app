import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_page/assets/strings.dart';
import 'package:register_page/models/loginizator.dart';
import 'package:register_page/models/registrator.dart';
import 'package:register_page/bloc/reg_bloc.dart';
import '../register_page.dart';

class HomeButton extends StatelessWidget {
  final String _title;
  HomeButton(this._title);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(_title),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider(
                create: (context) => (_title == RegisterStrings.signUp) ? RegBloc(Registrator()): RegBloc(Loginizator()),
                child: (_title == RegisterStrings.signUp) ? RegisterPage.reg(_title): RegisterPage.log(_title),
              );},
          ),
        );
      },
    );
  }
}
