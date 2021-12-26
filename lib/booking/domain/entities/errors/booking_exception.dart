abstract class BookingException implements Exception {
  final String? description;

  const BookingException(this.description);
}
