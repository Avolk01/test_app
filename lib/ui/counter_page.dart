import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_page/counter_bloc/counter_bloc.dart';
import 'package:register_page/ui/statistic_page.dart';
import 'package:register_page/ui/widgets/img_with_button.dart';

class CounterPage extends StatefulWidget {
  CounterPage({Key? key}) : super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _blinCounter = 0;
  int _suicideCounter = 0;
  int _giveUpCounter = 0;
  int _chetkoCounter = 0;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  bool start = true;

  @override
  void initState() {
    super.initState();
    context.read<CounterBloc>().add(Loading());
  }

  void counterPageButton() {
    Navigator.pop(context);
  }

  void statisticPageButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (cntxt) => BlocProvider.value(
          value: BlocProvider.of<CounterBloc>(context),
          child: StatisticPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CounterBloc, CounterState>(
      listener: (context, state) {
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FlatButton(
                          onPressed: counterPageButton,
                          child: Text('Кнопочки')),
                      FlatButton(
                          onPressed: statisticPageButton,
                          child: Text('Статистика')),
                    ],
                  ),
                ),
                appBar: AppBar(
                  title: Text('Выбери своего бойца!'),
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
                                'images/blin.png',
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
                                'images/suicide.jpg',
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
                                'images/give_up.jpg',
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
                            ImageButton('images/chetko.png', 170, 295, () {
                              context.read<CounterBloc>().add(IncCount(4));
                            }),
                            Text('количество нажатий: $_chetkoCounter'),
                          ],
                        ),
                      ],
                    ),
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
