part of 'saved_articles_bloc.dart';

enum SavedArticlesStatus {
  initial,
  loading,
  noSavedArticle,
  fetchSuccessful,
  fetchError,
  saveOrRemoveSuccessful,
  saveOrRemoveError,
}

class SavedArticlesState extends Equatable {
  final SavedArticlesStatus status;
  final List<ArticleEntity> articles;
  final String? message;

  const SavedArticlesState({required this.status, required this.articles, this.message});
  
  @override
  List<Object?> get props => [status, articles, message];

  SavedArticlesState copyWith({
    SavedArticlesStatus? status,
    List<ArticleEntity>? articles,
    String? message,
  }) {
    return SavedArticlesState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
      message: message,
    );
  }
}
