// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppException implements Exception {
  const AppException({
    required this.message,
  });

  final String message;

  @override
  String toString() {
    return message;
  }

  @override
  bool operator ==(covariant AppException other) {
    if (identical(this, other)) return true;

    return other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
