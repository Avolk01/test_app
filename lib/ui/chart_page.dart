import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:register_page/assets/strings.dart';
import 'package:register_page/ui/widgets/color_description.dart';
import 'package:register_page/ui/widgets/multi_chart.dart';

class ChartPage extends StatelessWidget {
  ChartPage(this._values, this._dates, {Key? key}) : super(key: key);

  final List<List<int>> _values;
  final List<DateTime> _dates;
  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.green
  ];

  final List<String> _strings = [
    FieldsStrings.blin,
    FieldsStrings.suicide,
    FieldsStrings.giveUp,
    FieldsStrings.chetko,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TitleStrings.chartPageTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 400,
            child: MultiChart(_values, _dates, false),),
          ...List.generate(
            _colors.length,
            (index) => SizedBox(
              height: 20,
              child: ColorDescription(
                'Количество нажатий ${_strings[index]}',
                _colors[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
