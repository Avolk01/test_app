import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_page/counter_bloc/counter_bloc.dart';
import 'package:register_page/ui/widgets/img_with_button.dart';

class MainData {
  String _uid;
  num _blin;
  num _suicide;
  num _giveUp;
  num _chetko;

  MainData(this._uid, this._blin, this._suicide, this._giveUp, this._chetko);

  num get blin => _blin;
  num get suicide => _suicide;
  num get giveUp => _giveUp;
  num get chetko => _chetko;
  String get uid => _uid;
}

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<CounterBloc, CounterState>(
      listener: (context, state) {
        _blinCounter = state.blin;
        _chetkoCounter = state.chetko;
        _suicideCounter = state.suicide;
        _giveUpCounter = state.giveUp;
      },
      child: StreamBuilder<QuerySnapshot>(
          stream: users.snapshots(),
          builder: (context, snapshot) {
            return BlocBuilder(
              bloc: context.watch<CounterBloc>(),
              builder: (context, state) {
                return Scaffold(
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
                                context
                                    .read<CounterBloc>()
                                    .add(IncCount(4));
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
          }),
    );
  }
}
