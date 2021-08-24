import 'package:flutter/material.dart';

class ColorDescription extends StatelessWidget {
  ColorDescription(this._text, this._color);

  Color _color;
  String _text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 50,
          color: _color,
        ),
        Text(_text),
      ],
    );
  }
}
