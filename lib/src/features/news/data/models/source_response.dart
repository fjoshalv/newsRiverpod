class SourceResponse {
  const SourceResponse({
    required this.name,
  });

  final String name;

  factory SourceResponse.fromMap(Map<String, dynamic> map) =>
      SourceResponse(name: map['name']);
}
