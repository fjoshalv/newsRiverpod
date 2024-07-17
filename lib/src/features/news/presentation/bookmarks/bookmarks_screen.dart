import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_riverpod/src/design/app_sizes.dart';
import 'package:news_riverpod/src/features/news/data/news_local_repository.dart';
import 'package:news_riverpod/src/features/news/presentation/trends/trends_screen.dart';
import 'package:news_riverpod/src/features/news/presentation/widgets/article_widget.dart';
import 'package:news_riverpod/src/shared/presentation/async_value_widget.dart';
import 'package:news_riverpod/src/utils/app_strings.dart';

class BookmarksScreen extends ConsumerStatefulWidget {
  const BookmarksScreen({super.key});

  @override
  ConsumerState<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends ConsumerState<BookmarksScreen> {
  @override
  Widget build(BuildContext context) {
    final stateValue = ref.watch(bookmarkedArticlesProvider);
    return Scaffold(
      body: AsyncValueWidget(
        value: stateValue,
        data: (articles) {
          if (articles.isEmpty) {
            return const Center(
              child: Text(AppStrings.noBookmarksYet),
            );
          }
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              if (index >= articles.length) {
                return const ListLoadingWidget();
              }
              final article = articles[index];
              return ArticleWidget(article: article);
            },
          );
        },
      ),
    );
  }
}
