class BookingErrorViewModel {
  final BookingErrorType errorType;
  final String? description;

  BookingErrorViewModel({
    required this.errorType,
    this.description,
  });
}

enum BookingErrorType {
  unknown,
}
