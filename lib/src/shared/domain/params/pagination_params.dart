import 'package:flutter_turnkey_test/src/utils/app_constants.dart';

class PaginationParams {
  final int page;

  const PaginationParams({
    required this.page,
  });

  Map<String, String> toMap() {
    return {
      'page': page.toString(),
      'pageSize': AppConstants.pageSize.toString(),
    };
  }
}
