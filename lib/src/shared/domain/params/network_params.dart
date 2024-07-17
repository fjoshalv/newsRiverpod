import 'package:flutter_turnkey_test/src/utils/app_constants.dart';

class NetworkParams {
  final int page;

  const NetworkParams({
    required this.page,
  });

  Map<String, String> toMap() {
    return {
      'page': page.toString(),
      'pageSize': AppConstants.pageSize.toString(),
    };
  }
}
