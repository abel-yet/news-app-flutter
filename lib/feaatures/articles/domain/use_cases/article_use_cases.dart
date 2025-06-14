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

class FetchSavedArticlesUseCase {
  final ArticleRepository articleRepository;

  FetchSavedArticlesUseCase({required this.articleRepository});

  Future<Either<Failure, List<ArticleEntity>>> execute() async {
    return articleRepository.fetchSavedArticles();
  }
}

class SaveArticleUseCase {
  final ArticleRepository articleRepository;

  SaveArticleUseCase({required this.articleRepository});

  Future<Either<Failure, Null>> execute({required ArticleEntity article}) async {
    return articleRepository.saveArticle(article: article);
  }
}

class RemoveArticleUseCase {
  final ArticleRepository articleRepository;

  RemoveArticleUseCase({required this.articleRepository});

  Future<Either<Failure, Null>> execute({required String id}) async {
    return articleRepository.removeArticle(id: id);
  }
}

class RemoveAllArticlesUseCase {
  final ArticleRepository articleRepository;

  RemoveAllArticlesUseCase({required this.articleRepository});

  Future<Either<Failure, Null>> execute() async {
    return articleRepository.removeAllSavedArticles();
  }
}