import 'package:craft_cuts_mobile/common/presentation/navigation/route_names.dart';
import 'package:craft_cuts_mobile/common/presentation/strings/common_strings.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _userDataFormKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  bool _passwordVisible = false;

  bool get _enableSignInButton =>
      _emailFieldController.text.isNotEmpty &&
      _passwordFieldController.text.isNotEmpty;

  @override
  void initState() {
    _emailFieldController.addListener(_inputFieldValueChangeListener);
    _passwordFieldController.addListener(_inputFieldValueChangeListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const inputFieldsPadding = EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 7.0,
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close),
                        ),
                      ],
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Text(
                          CommonStrings.login,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: _userDataFormKey,
                child: Column(
                  children: [
                    Padding(
                      padding: inputFieldsPadding,
                      child: TextFormField(
                        controller: _emailFieldController,
                        validator: _requiredFieldValidator,
                        decoration: InputDecoration(
                          hintText: CommonStrings.email,
                        ),
                      ),
                    ),
                    Padding(
                      padding: inputFieldsPadding,
                      child: TextFormField(
                        controller: _passwordFieldController,
                        obscureText: !_passwordVisible,
                        validator: _requiredFieldValidator,
                        decoration: InputDecoration(
                          hintText: CommonStrings.password,
                          suffixIcon: TextButton(
                            onPressed: _passwordVisibleChanged,
                            child: Text(_passwordVisible
                                ? CommonStrings.hide
                                : CommonStrings.show),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(flex: 1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: ElevatedButton(
                  onPressed: _enableSignInButton ? _signInButtonPressed : null,
                  child: Text(CommonStrings.login),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: TextButton(
                  // TODO: fix button text color
                  style: Theme.of(context).textButtonTheme.style!.copyWith(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                  onPressed: _doNotHaveAccountButtonPressed,
                  child: Text(
                    CommonStrings.doNotHaveAccount,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _inputFieldValueChangeListener() {
    setState(() {});
  }

  String? _requiredFieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return CommonStrings.emptyInputFieldMessage;
    }
  }

  void _passwordVisibleChanged() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _signInButtonPressed() {}

  void _doNotHaveAccountButtonPressed() {
    Navigator.of(context).pushReplacementNamed(RouteNames.registerPage);
  }
}
