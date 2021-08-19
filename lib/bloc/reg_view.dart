import 'package:flutter/cupertino.dart';
import 'package:register_page/assets/strings.dart';
import 'package:register_page/ui/widgets/home_button.dart';

class RegView extends StatelessWidget {
  const RegView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
        ),
        Text("Добро пожаловать!"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeButton(RegisterStrings.signIn),
            HomeButton(RegisterStrings.signUp)
          ],
        ),
      ],
    );
  }
}
