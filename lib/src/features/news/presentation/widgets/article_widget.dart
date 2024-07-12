import 'package:flutter/material.dart';
import 'package:flutter_turnkey_test/src/design/app_colors.dart';
import 'package:flutter_turnkey_test/src/design/app_sizes.dart';
import 'package:flutter_turnkey_test/src/features/news/domain/entities/article.dart';
import 'package:flutter_turnkey_test/src/utils/app_strings.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: AppSizes.p280,
            width: double.infinity,
            child: Image.network(
              article.urlToImage ?? '',
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
            ),
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
                ),
                Text(
                  '${article.sourceName} - ${DateFormat.MMMMEEEEd().format(article.publishedAt)}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  article.author ?? AppStrings.noArticleAuthor,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
