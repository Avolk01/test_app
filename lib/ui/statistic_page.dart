import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_page/assets/strings.dart';
import 'package:register_page/statistic_bloc/statistic_bloc.dart';
import 'package:register_page/ui/stat_screen.dart';

class StatisticPage extends StatefulWidget {
  StatisticPage({Key? key}) : super(key: key);

  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {

  void dateButton(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StatScreen(_values)),
    );
  }

  bool _isButtonOnClick = false;
  List<int> _values = [];
  List<String> _dates = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<StatisticBloc, StatisticState>(
      listener: (context, state) {
        if (state is Dates) _dates = state.dates;
        if (state is Values) _values = state.values;
        if( _isButtonOnClick)
          dateButton();
      },
      child: BlocBuilder<StatisticBloc, StatisticState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(TitleStrings.statisticPageTitle),
            ),
            body: Center(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return FlatButton(
                    onPressed: () {
                      context.read<StatisticBloc>().add(GetValues(_dates[index]));
                      _isButtonOnClick = true;
                    },
                    child: ListTile(
                      title: Text(_dates[index]),
                    ),
                  );
                },
                itemCount: _dates.length,
              ),
            ),
          );
        },
      ),
    );
  }
}
