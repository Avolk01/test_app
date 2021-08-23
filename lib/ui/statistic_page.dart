import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_page/statistic_bloc/statistic_bloc.dart';

class StatisticPage extends StatefulWidget {
  StatisticPage({Key? key}) : super(key: key);

  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  List<String> _dates = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<StatisticBloc, StatisticState>(
      listener: (context, state) {
        _dates = state.dates;
        print(_dates);
      },
      child: BlocBuilder<StatisticBloc, StatisticState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Статистика'),
            ),
            body: Center(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return FlatButton(
                    onPressed: () {},
                    child: ListTile(
                      title: Text('asd'),
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
