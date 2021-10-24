import 'package:craft_cuts_mobile/auth/domain/entities/user.dart';

abstract class UserRepository {
  Stream<User?> get currentUser;

  void registerUser(User userData);

  void signInWithEmailAndPassword(
    String email,
    String password,
  );

  void signOut();
}
