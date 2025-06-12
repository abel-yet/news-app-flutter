import 'dart:async';
import 'package:echo/feaatures/articles/domain/entities/article_entity.dart';
import 'package:echo/feaatures/articles/domain/use_cases/article_use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_articles_event.dart';
part 'search_articles_state.dart';

class SearchArticlesBloc extends Bloc<SearchArticlesEvent, SearchArticlesState> {
  final SearchArticlesUseCase searchArticlesUseCase;

  SearchArticlesBloc({required this.searchArticlesUseCase}) : super(SearchArticlesInitial()) {
    on<SearchArticlesEvent>(_searchArticlesEventHandler);
  }

  FutureOr<void> _searchArticlesEventHandler(SearchArticlesEvent event, Emitter<SearchArticlesState> emit) async {
    emit(SearchArticlesLoading());

    final result = await searchArticlesUseCase.execute(query: event.query);

    result.fold(
      (failure) {
        emit(SearchArticlesError(errorMessage: failure.errorMessage));
      },
      (articles) {
        emit(SearchArticlesFetched(articles: articles));
      },
    );
  }
}
