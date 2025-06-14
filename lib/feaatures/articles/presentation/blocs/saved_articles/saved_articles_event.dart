part of 'saved_articles_bloc.dart';

sealed class SavedArticlesEvent {}

final class FetchSavedArticlesEvent extends SavedArticlesEvent {
  final bool shouldSkipLoading;

  FetchSavedArticlesEvent({this.shouldSkipLoading = false});
}

final class SaveArticleEvent extends SavedArticlesEvent {
  final ArticleEntity article;

  SaveArticleEvent({required this.article});
}

final class RemoveArticleEvent extends SavedArticlesEvent {
  final String id;

  RemoveArticleEvent({required this.id});
}

final class RemoveAllArticlesEvent extends SavedArticlesEvent {}
