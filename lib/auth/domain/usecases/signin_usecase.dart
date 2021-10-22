import 'package:craft_cuts_mobile/auth/domain/repositories/user_repository.dart';
import 'package:craft_cuts_mobile/auth/domain/usecases/params/signin_param.dart';
import 'package:craft_cuts_mobile/common/domain/usecases/usecase.dart';

class SignInUsecase implements UseCase<Future<void>, SignInParam> {
  final UserRepository _repository;

  SignInUsecase(this._repository);

  @override
  Future<void> call(SignInParam params) async {
    return _repository.signInWithEmailAndPassword(
      params.email,
      params.password,
    );
  }
}
