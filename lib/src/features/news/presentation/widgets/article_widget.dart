import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_riverpod/src/design/app_colors.dart';
import 'package:news_riverpod/src/design/app_sizes.dart';
import 'package:news_riverpod/src/features/news/data/news_local_repository.dart';
import 'package:news_riverpod/src/features/news/domain/entities/article.dart';
import 'package:news_riverpod/src/utils/app_strings.dart';
import 'package:intl/intl.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.p24),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: AppSizes.p280,
                width: double.infinity,
                child: article.urlToImage != null
                    ? _ArticleImage(url: article.urlToImage!)
                    : const _ArticleImagePlaceholder(),
              ),
              gapH12,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.p12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    gapH8,
                    Text(
                      article.description ?? AppStrings.noArticleDescription,
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    gapH4,
                    Text(
                      article.author ?? AppStrings.noArticleAuthor,
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    gapH4,
                    Text(
                      '${article.sourceName} - ${DateFormat.MMMMEEEEd().format(article.publishedAt)}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Consumer(
              builder: (context, ref, child) {
                final localArticleValue =
                    ref.watch(getArticleByIdProvider(article.id));

                final isBookmarked = localArticleValue.maybeWhen(
                  data: (article) => article != null,
                  orElse: () => false,
                );

                return IconButton(
                  icon: Icon(
                    localArticleValue.maybeWhen(
                      data: (article) => article != null
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      orElse: () => Icons.bookmark_border,
                    ),
                    color: AppColors.black,
                    size: AppSizes.p40,
                  ),
                  onPressed: localArticleValue.isLoading
                      ? null
                      : () async {
                          final newsLocalRepository =
                              ref.read(newsLocalRepositoryProvider);

                          // * Needs to be called here, otherwise the
                          // * article will be deleted from the local database
                          // * and the widget will be disposed before the
                          // * UI is updated
                          ref.invalidate(getArticleByIdProvider(article.id));

                          isBookmarked
                              ? await newsLocalRepository
                                  .deleteArticle(article.id)
                              : await newsLocalRepository.saveArticle(article);
                        },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ArticleImage extends StatelessWidget {
  const _ArticleImage({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.camera_alt,
                  size: AppSizes.p60,
                  color: AppColors.grey,
                ),
                Positioned(
                  child: Icon(
                    Icons.not_interested_sharp,
                    size: AppSizes.p120,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ArticleImagePlaceholder extends StatelessWidget {
  const _ArticleImagePlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
      ),
      child: Center(
        child: Icon(
          Icons.camera_alt,
          size: AppSizes.p60,
          color: AppColors.grey,
        ),
      ),
    );
  }
}
