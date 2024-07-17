import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_riverpod/src/design/app_sizes.dart';
import 'package:news_riverpod/src/features/news/domain/entities/article.dart';
import 'package:news_riverpod/src/features/news/presentation/search/search_controller.dart';
import 'package:news_riverpod/src/features/news/presentation/trends/trends_screen.dart';
import 'package:news_riverpod/src/features/news/presentation/widgets/article_widget.dart';
import 'package:news_riverpod/src/shared/presentation/async_value_widget.dart';
import 'package:news_riverpod/src/utils/app_constants.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16),
          child: Column(
            children: [
              gapH12,
              CupertinoSearchTextField(
                controller: _searchController,
                onChanged: ref.read(searchControllerProvider.notifier).onSearch,
              ),
              gapH12,
              Expanded(
                child: Consumer(
                  builder: (_, ref, __) {
                    final stateValue = ref.watch(searchControllerProvider);
                    return AsyncValueWidget(
                        value: stateValue,
                        data: (state) {
                          return ListView.builder(
                            controller: _scrollController,
                            itemCount: state.hasReachedMax
                                ? state.articles.length
                                : state.articles.length + 1,
                            itemBuilder: (_, index) {
                              if (state.articles.isEmpty) {
                                return const SizedBox.shrink();
                              } else if (index >= state.articles.length) {
                                return const ListLoadingWidget();
                              } else {
                                final article = state.articles[index];
                                return ArticleWidget(article: article);
                              }
                            },
                          );
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= AppConstants.scrollThreshold) {
      ref.read(searchControllerProvider.notifier).loadNewsFor(
            query: _searchController.text,
          );
    }
  }
}
