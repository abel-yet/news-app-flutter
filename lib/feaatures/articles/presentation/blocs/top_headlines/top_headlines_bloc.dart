import 'dart:async';

import 'package:echo/core/enums/news_category_enum.dart';
import 'package:echo/feaatures/articles/domain/entities/article_entity.dart';
import 'package:echo/feaatures/articles/domain/use_cases/article_use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_headlines_event.dart';
part 'top_headlines_state.dart';

class TopHeadlinesBloc extends Bloc<TopHeadlinesEvent, TopHeadlinesState> {
  final FetchTopHeadlinesUseCase fetchTopHeadlinesUseCase;

  TopHeadlinesBloc({required this.fetchTopHeadlinesUseCase}) : super(TopHeadlinesInitial()) {
    on<FetchTopHeadlinesEvent>(_fetchTopHeadlinesEventHandler);
  }

  FutureOr<void> _fetchTopHeadlinesEventHandler(FetchTopHeadlinesEvent event, Emitter<TopHeadlinesState> emit) async {
    emit(TopHeadlinesLoading());

    final result = await fetchTopHeadlinesUseCase.execute(category: event.category);

    result.fold(
      (failure) {
        emit(TopHeadlinesError(errorMessage: failure.errorMessage));
      },
      (articles) {
        emit(TopHeadlinesFetched(articles: articles));
      },
    );
  }
}
