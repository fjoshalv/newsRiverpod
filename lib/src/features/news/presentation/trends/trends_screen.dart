import 'package:flutter/material.dart';
import 'package:flutter_turnkey_test/src/features/news/domain/entities/article.dart';
import 'package:flutter_turnkey_test/src/features/news/presentation/widgets/article_widget.dart';

class TrendsScreen extends StatelessWidget {
  const TrendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index) {
        return ArticleWidget(
          article: Article.example,
        );
      }),
    );
  }
}
