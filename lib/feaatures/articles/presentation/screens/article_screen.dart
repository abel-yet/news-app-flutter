import 'package:echo/core/utils/extnesions.dart';
import 'package:echo/feaatures/articles/domain/entities/article_entity.dart';
import 'package:echo/feaatures/articles/presentation/blocs/saved_articles/saved_articles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleScreen extends StatefulWidget {
  static const routName = 'articleScreen';
  final ArticleEntity article;
  const ArticleScreen({super.key, required this.article});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.article.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(controller: _controller),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.theme.appColors.accentColor,
        foregroundColor: context.theme.appColors.secondaryColor,
        child: FaIcon(FontAwesomeIcons.heart),
        onPressed: () {
          context.read<SavedArticlesBloc>().add(SaveArticleEvent(article: widget.article));
        },
      ),
    );
  }
}
