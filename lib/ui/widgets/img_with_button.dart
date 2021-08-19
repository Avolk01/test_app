import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {

  ImageButton(this._imageName, this._width, this._height, this._onPressed);

  final String _imageName;
  final double? _width;
  final double? _height;
  final VoidCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.black,
      onTap: _onPressed,
      child: Image.asset(
        _imageName,
        width: _width,
        height: _height,
      ),
    );
  }
}
