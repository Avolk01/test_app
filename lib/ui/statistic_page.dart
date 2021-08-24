import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_page/statistic_bloc/statistic_bloc.dart';
import 'package:register_page/ui/stat_screen.dart';

class StatisticPage extends StatefulWidget {
  StatisticPage({Key? key}) : super(key: key);

  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  void dateButton(int index){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StatScreen(_values)),
    );
  }

  int flag = -1;
  List<int> _values = [];
  List<String> _dates = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<StatisticBloc, StatisticState>(
      listener: (context, state) {
        if (state.key == 'dates') _dates = state.dates;
        if (state.key == 'values') _values = state.values;
        if(flag != -1)
          dateButton(flag);
      },
      child: BlocBuilder<StatisticBloc, StatisticState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Выберите дату'),
            ),
            body: Center(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return FlatButton(
                    onPressed: () {
                      context.read<StatisticBloc>().add(GetValues(_dates[index]));
                      flag = index;
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
