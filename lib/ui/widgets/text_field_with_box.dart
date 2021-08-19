import 'package:flutter/material.dart';

class TextFieldWithBox extends StatelessWidget {
  TextFieldWithBox(this._message, this._textController);
  TextEditingController _textController;
  String _message;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(
          child: Text(_message),
          height: 20,
        ),
        TextFormField(
          controller: _textController,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
