abstract class UseCase<T, Params> {
  const UseCase();

  T call(Params params);
}
