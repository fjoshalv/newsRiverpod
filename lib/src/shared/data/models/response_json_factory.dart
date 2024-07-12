abstract class ResponseJsonFactory<T> {
  T fromJson(dynamic data);
}

class EmptyResponseJsonFactory implements ResponseJsonFactory<void> {
  const EmptyResponseJsonFactory();

  @override
  void fromJson(dynamic _) {}
}
