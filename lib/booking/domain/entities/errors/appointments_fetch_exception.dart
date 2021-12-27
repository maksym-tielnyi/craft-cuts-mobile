class AppointmentsFetchException implements Exception {
  final String? description;

  const AppointmentsFetchException({this.description});
}
