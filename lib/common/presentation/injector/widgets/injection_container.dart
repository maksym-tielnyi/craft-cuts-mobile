import 'package:craft_cuts_mobile/auth/data/repositories/user_repository_impl.dart';
import 'package:craft_cuts_mobile/auth/domain/repositories/user_repository.dart';
import 'package:craft_cuts_mobile/auth/domain/usecases/register_user_usecase.dart';
import 'package:craft_cuts_mobile/auth/domain/usecases/signin_usecase.dart';
import 'package:craft_cuts_mobile/auth/presentation/state/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InjectionContainer extends StatefulWidget {
  final Widget child;

  const InjectionContainer({Key? key, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InjectionContainerState();
}

class _InjectionContainerState extends State<InjectionContainer> {
  late AuthNotifier _authNotifier;

  late RegisterUserUsecase _registerUserUsecase;

  late SignInUsecase _signInUsecase;

  @override
  void initState() {
    UserRepository userRepository = UserRepositoryImpl();

    _registerUserUsecase = RegisterUserUsecase(userRepository);

    _signInUsecase = SignInUsecase(userRepository);

    _authNotifier = AuthNotifier(
      _registerUserUsecase,
      _signInUsecase,
    );

    _authNotifier.subscribeToAuthUpdates(userRepository.currentUser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _authNotifier),
      ],
      child: widget.child,
    );
  }
}
