import 'package:craft_cuts_mobile/auth/domain/repositories/user_repository.dart';
import 'package:craft_cuts_mobile/auth/domain/usecases/params/register_user_param.dart';
import 'package:craft_cuts_mobile/common/domain/usecases/usecase.dart';

class RegisterUserUsecase extends UseCase<Future<void>, RegisterUserParam> {
  final UserRepository _repository;

  RegisterUserUsecase(this._repository);

  @override
  Future<void> call(RegisterUserParam params) async {
    return _repository.registerUser(params.userData);
  }
}
