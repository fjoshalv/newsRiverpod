class SourceResponse {
  const SourceResponse({
    this.id,
    required this.name,
  });
  final String? id;
  final String name;

  factory SourceResponse.fromMap(Map<String, dynamic> map) =>
      SourceResponse(id: map['id'], name: map['name']);
}
