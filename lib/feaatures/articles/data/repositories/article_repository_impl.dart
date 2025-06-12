import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:echo/core/enums/news_category_enum.dart';
import 'package:echo/core/utils/helper_functions.dart';
import 'package:echo/feaatures/articles/data/data_source/remote/article_remote_data_source.dart';
import 'package:echo/feaatures/articles/domain/entities/article_entity.dart';
import 'package:echo/feaatures/articles/domain/failures/failure.dart';
import 'package:echo/feaatures/articles/domain/repositories/article_repository.dart';
import 'package:flutter/foundation.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource articleRemoteDataSource;

  ArticleRepositoryImpl({required this.articleRemoteDataSource});

  @override
  Future<Either<Failure, List<ArticleEntity>>> fetchTopHeadlines({required NewsCategory category}) async {
    try {
      final articleModels = await articleRemoteDataSource.fetchTopHeadlines(category: category);
      final articleEntities = articleModels.map((am) => am.mapToEntity()).toList();
      return right(articleEntities);
    } on DioException catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint(e.toString());
        debugPrintStack(stackTrace: stackTrace);
      }
      return left(Failure(errorMessage: getDioErrorMessage(e)));
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint(e.toString());
        debugPrintStack(stackTrace: stackTrace);
      }
      return left(Failure(errorMessage: "Oops something went wrong"));
    }
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> searchArticles({required String query}) async {
    try {
      final articleModels = await articleRemoteDataSource.searchArticles(query: query);
      final articleEntities = articleModels.map((am) => am.mapToEntity()).toList();
      return right(articleEntities);
    } on DioException catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint(e.toString());
        debugPrintStack(stackTrace: stackTrace);
      }
      return left(Failure(errorMessage: getDioErrorMessage(e)));
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint(e.toString());
        debugPrintStack(stackTrace: stackTrace);
      }
      return left(Failure(errorMessage: "Oops something went wrong"));
    }
  }
}
