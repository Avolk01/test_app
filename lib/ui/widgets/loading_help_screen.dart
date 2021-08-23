import 'package:flutter/material.dart';

class LoadingHelpScreen extends StatelessWidget {
  LoadingHelpScreen(this._visible);

  bool _visible;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      bottom: 10,
      left: 10,
      top: 10,
      child: Visibility(
        visible: _visible,
        child: Opacity(
          opacity: 0.5,
          child: Container(
            color: Colors.grey,
            child: Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ),),
          ),
        ),
      ),
    );
  }
}
