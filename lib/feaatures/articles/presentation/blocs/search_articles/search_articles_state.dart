part of 'search_articles_bloc.dart';

sealed class SearchArticlesState extends Equatable {
  const SearchArticlesState();
  
  @override
  List<Object> get props => [];
}

final class SearchArticlesInitial extends SearchArticlesState {}

final class SearchArticlesLoading extends SearchArticlesState {}

final class SearchArticlesFetched extends SearchArticlesState {
  final List<ArticleEntity> articles;

  const SearchArticlesFetched({required this.articles});

  @override
  List<Object> get props => [articles];

}

final class SearchArticlesError extends SearchArticlesState {
  final String errorMessage;

  const SearchArticlesError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
