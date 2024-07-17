abstract class ResponseJsonFactory<T> {
  T fromMap(dynamic data);
}

class EmptyResponseJsonFactory implements ResponseJsonFactory<void> {
  const EmptyResponseJsonFactory();

  @override
  void fromMap(dynamic _) {}
}
