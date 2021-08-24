import 'package:flutter/material.dart';

class ColorDescription extends StatelessWidget {
  ColorDescription(this._text, this._color);

  Color _color;
  String _text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 50,),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
             color: _color,
          borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(width: 15,),
        Text(_text, style: TextStyle(
          fontSize: 16,
        ),),
      ],
    );
  }
}
