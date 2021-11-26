import 'package:craft_cuts_mobile/auth/presentation/state/auth_notifier.dart';
import 'package:craft_cuts_mobile/auth/presentation/widgets/auth_error_dialog.dart';
import 'package:craft_cuts_mobile/common/presentation/loading_indicator_overlay/widgets/loading_indicator_overlay.dart';
import 'package:craft_cuts_mobile/common/presentation/navigation/route_names.dart';
import 'package:craft_cuts_mobile/common/presentation/strings/common_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthNotifier _authNotifier;

  @override
  void initState() {
    _authNotifier = Provider.of<AuthNotifier>(context, listen: false);

    _authNotifier.addListener(_authNotifierListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_screen_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: LoadingIndicatorOverlay(
          isLoading: authNotifier.isLoading,
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      CommonStrings.craftCuts,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 17.0,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RouteNames.signInPage);
                          },
                          child: Text(
                            CommonStrings.login,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RouteNames.registerPage);
                        },
                        child: Text(CommonStrings.register),
                        style:
                            Theme.of(context).textButtonTheme.style!.copyWith(
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
      ),
    );
  }

  void _authNotifierListener() {
    if (_authNotifier.signInStateViewModel.lastException != null) {
      showDialog(
        context: context,
        builder: (context) => AuthErrorDialog(
          _authNotifier.signInStateViewModel.lastException.toString(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _authNotifier.removeListener(_authNotifierListener);
    super.dispose();
  }
}
