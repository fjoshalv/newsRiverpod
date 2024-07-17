import 'package:flutter_turnkey_test/src/utils/app_constants.dart';

class NetworkParams {
  const NetworkParams({
    required this.page,
    this.query,
  });

  final int page;
  final String? query;

  Map<String, String> toMap() {
    return {
      'page': page.toString(),
      'pageSize': AppConstants.pageSize.toString(),
      if (query != null) 'q': query!,
    };
  }
}
