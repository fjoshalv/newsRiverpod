import 'package:flutter/material.dart';
import 'package:news_riverpod/src/design/app_sizes.dart';

class ListLoadingWidget extends StatelessWidget {
  const ListLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: AppSizes.p12),
      child: Center(
        child: SizedBox.square(
          dimension: AppSizes.p28,
          child: CircularProgressIndicator(
            strokeWidth: AppSizes.p4,
          ),
        ),
      ),
    );
  }
}
