part of 'top_headlines_bloc.dart';

sealed class TopHeadlinesEvent {}

final class FetchTopHeadlinesEvent extends TopHeadlinesEvent {
  final NewsCategory category;

  FetchTopHeadlinesEvent({required this.category});
}
