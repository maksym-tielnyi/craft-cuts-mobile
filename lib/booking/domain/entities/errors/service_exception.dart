abstract class ServiceException implements Exception {
  final String? description;

  const ServiceException({this.description});
}
