import 'package:dartz/dartz.dart';
import 'package:echo/core/enums/news_category_enum.dart';
import 'package:echo/feaatures/articles/domain/entities/article_entity.dart';
import 'package:echo/feaatures/articles/domain/failures/failure.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<ArticleEntity>>> fetchTopHeadlines({required NewsCategory category});
}