import 'package:dartz/dartz.dart';
import 'package:echo/core/enums/news_category_enum.dart';
import 'package:echo/feaatures/articles/domain/entities/article_entity.dart';
import 'package:echo/feaatures/articles/domain/failures/failure.dart';
import 'package:echo/feaatures/articles/domain/repositories/article_repository.dart';

class FetchTopHeadlinesUseCase {
  final ArticleRepository articleRepository;

  FetchTopHeadlinesUseCase({required this.articleRepository});

  Future<Either<Failure, List<ArticleEntity>>> execute({required NewsCategory category}) async {
    return articleRepository.fetchTopHeadlines(category: category);
  }
}

class SearchArticlesUseCase {
  final ArticleRepository articleRepository;

  SearchArticlesUseCase({required this.articleRepository});

  Future<Either<Failure, List<ArticleEntity>>> execute({required String query}) async {
    return articleRepository.searchArticles(query: query);
  }
}
