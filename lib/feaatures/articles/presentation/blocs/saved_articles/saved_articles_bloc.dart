import 'dart:async';

import 'package:echo/feaatures/articles/domain/entities/article_entity.dart';
import 'package:echo/feaatures/articles/domain/use_cases/article_use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'saved_articles_event.dart';
part 'saved_articles_state.dart';

class SavedArticlesBloc extends Bloc<SavedArticlesEvent, SavedArticlesState> {
  final FetchSavedArticlesUseCase fetchSavedArticlesUseCase;
  final SaveArticleUseCase saveArticleUseCase;
  final RemoveArticleUseCase removeArticleUseCase;
  final RemoveAllArticlesUseCase removeAllArticlesUseCase;

  SavedArticlesBloc({
    required this.fetchSavedArticlesUseCase,
    required this.saveArticleUseCase,
    required this.removeArticleUseCase,
    required this.removeAllArticlesUseCase,
  }) : super(SavedArticlesState(status: SavedArticlesStatus.initial, articles: [])) {
    on<FetchSavedArticlesEvent>(_fetchSavedArticlesEventHandler);
    on<SaveArticleEvent>(_saveArticleEventHandler);
    on<RemoveArticleEvent>(_removeArticleEventHandler);
    on<RemoveAllArticlesEvent>(_removeAllArticlesEventHandler);
  }

  FutureOr<void> _fetchSavedArticlesEventHandler(FetchSavedArticlesEvent event, Emitter<SavedArticlesState> emit) async {
    if (!event.shouldSkipLoading) {
      emit(state.copyWith(status: SavedArticlesStatus.loading));
    }

    final result = await fetchSavedArticlesUseCase.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(status: SavedArticlesStatus.fetchError, articles: state.articles, message: failure.errorMessage));
      },
      (articles) {
        if (articles.isEmpty) {
          emit(state.copyWith(status: SavedArticlesStatus.noSavedArticle, articles: articles));
        } else {
          emit(state.copyWith(status: SavedArticlesStatus.fetchSuccessful, articles: articles));
        }
      },
    );
  }

  FutureOr<void> _saveArticleEventHandler(SaveArticleEvent event, Emitter<SavedArticlesState> emit) async {
    final result = await saveArticleUseCase.execute(article: event.article);

    result.fold(
      (failure) {
        emit(state.copyWith(status: SavedArticlesStatus.saveOrRemoveError, articles: state.articles, message: failure.errorMessage));
      },
      (_) {
        emit(state.copyWith(status: SavedArticlesStatus.saveOrRemoveSuccessful, articles: state.articles, message: "Article Saved."));
        add(FetchSavedArticlesEvent(shouldSkipLoading: true));
      },
    );
  }

  FutureOr<void> _removeArticleEventHandler(RemoveArticleEvent event, Emitter<SavedArticlesState> emit) async {
    final result = await removeArticleUseCase.execute(id: event.id);

    result.fold(
      (failure) {
        emit(state.copyWith(status: SavedArticlesStatus.saveOrRemoveError, articles: state.articles, message: failure.errorMessage));
      },
      (_) {
        emit(state.copyWith(status: SavedArticlesStatus.saveOrRemoveSuccessful, articles: state.articles, message: "Article removed"));
        add(FetchSavedArticlesEvent(shouldSkipLoading: true));
      },
    );
  }

  FutureOr<void> _removeAllArticlesEventHandler(RemoveAllArticlesEvent event, Emitter<SavedArticlesState> emit) async {
    final result = await removeAllArticlesUseCase.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(status: SavedArticlesStatus.saveOrRemoveError, articles: state.articles, message: failure.errorMessage));
      },
      (_) {
        emit(state.copyWith(status: SavedArticlesStatus.saveOrRemoveSuccessful, articles: state.articles, message: "Articles removed"));
        emit(SavedArticlesState(status: SavedArticlesStatus.noSavedArticle, articles: []));
      },
    );
  }
}
