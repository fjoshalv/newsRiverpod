import 'package:flutter/material.dart';
import 'package:news_riverpod/src/utils/app_strings.dart';
import 'package:go_router/go_router.dart';

enum HomeTabs {
  trends,
  search,
  bookmarks;

  String get title {
    switch (this) {
      case HomeTabs.trends:
        return AppStrings.trends;
      case HomeTabs.search:
        return AppStrings.search;
      case HomeTabs.bookmarks:
        return AppStrings.bookmarks;
    }
  }

  IconData get icon {
    switch (this) {
      case HomeTabs.trends:
        return Icons.trending_up;
      case HomeTabs.search:
        return Icons.search;
      case HomeTabs.bookmarks:
        return Icons.bookmark;
    }
  }
}
