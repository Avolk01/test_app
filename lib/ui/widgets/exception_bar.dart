import 'package:flutter/material.dart';

class ExceptionBar extends StatelessWidget {
  final String message;

  const ExceptionBar({Key? key,required this.message}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(message),backgroundColor: Colors.red[200],);
  }
}