import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:register_page/ui/widgets/color_description.dart';
import 'package:register_page/ui/widgets/statistic_bar.dart';

class StatScreen extends StatelessWidget {
  StatScreen(this._values, {Key? key}) : super(key: key);

  final List<int> _values;
  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.green
  ];

  final List<String> _strings = ['blin', 'suicide', 'give up', 'chetko'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Статистика'),
        actions: [],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 50,
            child: StatisticBar(_values, _colors),
          ),
          SizedBox(
            height: 100,
          ),
          ...List.generate(
            _values.length,
            (index) => ColorDescription(
              '${_strings[index]} - количество нажатий: ${_values[index]}',
              _colors[index],
            ),
          ),
        ],
      ),
    );
  }
}
