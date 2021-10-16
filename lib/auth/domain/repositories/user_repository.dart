abstract class UserRepository {
  void registerUser(
    String email,
    String password,
    String name,
    bool agreedToReceiveNews,
  );

  void signInWithEmailAndPassword(
    String email,
    String password,
  );
}
