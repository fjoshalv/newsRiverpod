import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_turnkey_test/src/shared/presentation/error_message_widget.dart';

/// A reusable widget to provide default loading and error widgets when working
/// with AsyncValue.
/// More info here:
/// https://codewithandrea.com/articles/async-value-widget-riverpod/
class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({super.key, required this.value, required this.data});
  final AsyncValue<T> value;
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (e, st) => Center(child: ErrorMessageWidget(e.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
