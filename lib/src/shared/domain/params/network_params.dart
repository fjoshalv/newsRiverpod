import 'package:news_riverpod/src/utils/app_constants.dart';

class NetworkParams {
  const NetworkParams({
    required this.page,
    this.query,
    this.pageSize,
  });

  final int page;
  final int? pageSize;
  final String? query;

  Map<String, String> toMap() {
    return {
      'page': page.toString(),
      'pageSize': pageSize?.toString() ?? AppConstants.pageSize.toString(),
      if (query != null) 'q': query!,
    };
  }
}
