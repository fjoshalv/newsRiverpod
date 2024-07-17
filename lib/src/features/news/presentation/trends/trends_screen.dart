import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_riverpod/src/design/app_sizes.dart';
import 'package:news_riverpod/src/features/news/presentation/trends/trends_controller.dart';
import 'package:news_riverpod/src/features/news/presentation/widgets/article_widget.dart';
import 'package:news_riverpod/src/shared/presentation/async_value_widget.dart';
import 'package:news_riverpod/src/utils/app_constants.dart';

class TrendsScreen extends ConsumerStatefulWidget {
  const TrendsScreen({super.key});

  @override
  ConsumerState<TrendsScreen> createState() => _TrendsScreenState();
}

class _TrendsScreenState extends ConsumerState<TrendsScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stateValue = ref.watch(trendsControllerProvider);
    return Scaffold(
      body: AsyncValueWidget(
        value: stateValue,
        data: (state) {
          final articles = state.articles;
          return ListView.builder(
            controller: _scrollController,
            itemCount:
                state.hasReachedMax ? articles.length : articles.length + 1,
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

  void onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= AppConstants.scrollThreshold) {
      ref.read(trendsControllerProvider.notifier).loadMoreHeadlines();
    }
  }
}

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
