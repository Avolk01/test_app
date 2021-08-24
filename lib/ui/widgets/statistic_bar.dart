import 'package:flutter/cupertino.dart';

class StatisticBar extends StatelessWidget {
  StatisticBar(this._values, this._colors);
  final List<Color> _colors;
  final List<int> _values;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        _values.length,
        (index) => Expanded(
          flex: _values[index],
          child: Container(
            color: _colors[index],
          ),
        ),
      ),
    );
  }
}
