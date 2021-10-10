import 'package:craft_cuts_mobile/auth/presentation/state/auth_notifier.dart';
import 'package:craft_cuts_mobile/common/presentation/loading_indicator_overlay/widgets/loading_indicator_overlay.dart';
import 'package:craft_cuts_mobile/common/presentation/navigation/route_names.dart';
import 'package:craft_cuts_mobile/common/presentation/strings/common_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _userDataFormKey = GlobalKey<FormState>();
  final _nameFieldController = TextEditingController();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  bool _passwordVisible = false;
  bool _receiveNewsEnabled = true;

  bool get _enableRegisterButton =>
      _nameFieldController.text.isNotEmpty &&
      _emailFieldController.text.isNotEmpty &&
      _passwordFieldController.text.isNotEmpty;

  @override
  void initState() {
    _nameFieldController.addListener(_inputFieldValueChangeListener);
    _emailFieldController.addListener(_inputFieldValueChangeListener);
    _passwordFieldController.addListener(_inputFieldValueChangeListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);

    const inputFieldsPadding = EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 7.0,
    );

    return LoadingIndicatorOverlay(
      isLoading: authNotifier.isLoading,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            CommonStrings.register,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(RouteNames.signInPage);
                        },
                        child: Text(CommonStrings.login),
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
                          controller: _nameFieldController,
                          validator: _requiredFieldValidator,
                          decoration: InputDecoration(
                            hintText: CommonStrings.name,
                          ),
                        ),
                      ),
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
                CheckboxListTile(
                  value: _receiveNewsEnabled,
                  onChanged: _receiveNewsEnabledChanged,
                  title:
                      Text(CommonStrings.receiveNewsAndNotificationsAgreement),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                Spacer(flex: 1),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                  child: ElevatedButton(
                    onPressed:
                        _enableRegisterButton ? _registerButtonPressed : null,
                    child: Text(CommonStrings.register),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                  child: TextButton(
                    // TODO: fix button text color
                    style: Theme.of(context).textButtonTheme.style!.copyWith(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                        ),
                    onPressed: _alreadyHaveAccountButtonPressed,
                    child: Text(CommonStrings.alreadyHaveAccount),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _passwordVisibleChanged() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _receiveNewsEnabledChanged(bool? value) {
    setState(() {
      _receiveNewsEnabled = value ?? _receiveNewsEnabled;
    });
  }

  void _registerButtonPressed() {
    final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    if (_userDataFormKey.currentState!.validate()) {
      authNotifier.registerAccount(
        _emailFieldController.text,
        _passwordFieldController.text,
        _nameFieldController.text,
        _receiveNewsEnabled,
      );
    }
  }

  void _alreadyHaveAccountButtonPressed() {
    Navigator.of(context).pushReplacementNamed(RouteNames.signInPage);
  }

  String? _requiredFieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return CommonStrings.emptyInputFieldMessage;
    }
  }

  void _inputFieldValueChangeListener() {
    setState(() {});
  }
}
