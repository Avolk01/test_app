import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_page/assets/strings.dart';
import 'package:register_page/counter_bloc/counter_bloc.dart';
import 'package:register_page/models/firebase_controller.dart';
import 'package:register_page/statistic_bloc/statistic_bloc.dart';
import 'package:register_page/ui/statistic_page.dart';
import 'package:register_page/ui/widgets/img_with_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'charts.dart';
import 'home_page.dart';

class CounterPage extends StatefulWidget {
  CounterPage(this._uid);
  String _uid;
  @override
  _CounterPageState createState() => _CounterPageState(_uid);
}

class _CounterPageState extends State<CounterPage> {
  _CounterPageState(this._uid);
  int _blinCounter = 0;
  int _suicideCounter = 0;
  int _giveUpCounter = 0;
  int _chetkoCounter = 0;
  String _uid;
  CollectionReference users = FirebaseFirestore.instance.collection(FirebaseStrings.mainCollection);
  bool start = true;

  void counterPageButton() {
    Navigator.pop(context);
  }

  void statisticPageButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (cntxt) => BlocProvider.value(
          value: BlocProvider.of<CounterBloc>(context),
          child: BlocProvider(
            create: (context) => StatisticBloc(
                FirebaseController(
                    mainCollection: FirebaseStrings.mainCollection, optionalCollection: FirebaseStrings.optionalCollection),
                _uid),
            child: StatisticPage(),
          ),
        ),
      ),
    );
  }

  void exitButton() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(FieldsStrings.uid);
    Navigator.popUntil(context, (context) {
      return true;
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  List<int> _clicks = [];
  List<DateTime> _dates = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<CounterBloc, CounterState>(
      listener: (context, state) {
        if (state is GraphData) {
          _clicks = state.values;
          _dates = state.dates;
        }
        _blinCounter = state.blin;
        _suicideCounter = state.suicide;
        _giveUpCounter = state.giveUp;
        _chetkoCounter = state.chetko;
      },
      child: StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (context, snapshot) {
          return BlocBuilder(
            bloc: context.watch<CounterBloc>(),
            builder: (context, state) {
              return Scaffold(
                drawer: Drawer(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                              onPressed: counterPageButton,
                              child: Text('Кнопочки')),
                          FlatButton(
                              onPressed: statisticPageButton,
                              child: Text('Статистика')),
                        ],
                      ),
                      FlatButton(
                          onPressed: exitButton,
                          child: Text('Выход из аккаунта')),
                    ],
                  ),
                ),
                appBar: AppBar(
                  title: Text(TitleStrings.counterPageTitle),
                ),
                body: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: <Widget>[
                            ImageButton(
                                ImagePath.blin,
                                200,
                                100,
                                () => context
                                    .read<CounterBloc>()
                                    .add(IncCount(1))),
                            Text('количество нажатий: $_blinCounter'),
                            SizedBox(
                              height: 33,
                            ),
                            ImageButton(
                                ImagePath.suicide,
                                200,
                                40,
                                () => context
                                    .read<CounterBloc>()
                                    .add(IncCount(2))),
                            Text('количество нажатий: $_suicideCounter'),
                            SizedBox(
                              height: 33,
                            ),
                            ImageButton(
                                ImagePath.giveUp,
                                200,
                                50,
                                () => context
                                    .read<CounterBloc>()
                                    .add(IncCount(3))),
                            Text('количество нажатий: $_giveUpCounter'),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            ImageButton(ImagePath.chetko, 170, 295, () {
                              context.read<CounterBloc>().add(IncCount(4));
                            }),
                            Text('количество нажатий: $_chetkoCounter'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 150,
                      width: 300,
                      child: SimpleTimeSeriesChart(_clicks, _dates, false),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
