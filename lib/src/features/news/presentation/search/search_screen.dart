import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_turnkey_test/src/design/app_sizes.dart';
import 'package:flutter_turnkey_test/src/features/news/domain/entities/article.dart';
import 'package:flutter_turnkey_test/src/features/news/presentation/widgets/article_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16),
          child: Column(
            children: [
              gapH12,
              const CupertinoSearchTextField(),
              gapH12,
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ArticleWidget(article: Article.example);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
