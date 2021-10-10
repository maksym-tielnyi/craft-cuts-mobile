import 'package:craft_cuts_mobile/common/presentation/strings/common_strings.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/login_screen_background.png'),
          fit: BoxFit.cover,
        )),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    'Craft Cuts',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 80.0,
                          vertical: 12.0,
                        ),
                        child: Text(
                          CommonStrings.login,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(CommonStrings.register),
                      style: Theme.of(context).textButtonTheme.style!.copyWith(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                    ),
                  ],
                ),
              ),
              Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
