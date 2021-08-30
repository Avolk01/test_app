import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:register_page/assets/strings.dart';
import 'package:register_page/ui/widgets/multi_chart.dart';

class ChartPage extends StatelessWidget {
  const ChartPage(this._values, this._dates, {Key? key}) : super(key: key);

  final List<List<int>> _values;
  final List<DateTime> _dates;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TitleStrings.chartPageTitle),
      ),
      body: Center(
        child: MultiChart(_values, _dates, false),
        //SimpleTimeSeriesChart(_values, _dates, false),
      ),
    );
  }
}
