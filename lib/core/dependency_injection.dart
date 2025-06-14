import 'package:dio/dio.dart';
import 'package:echo/core/utils/environment.dart';
import 'package:echo/feaatures/articles/data/data_source/local/article_local_data_source.dart';
import 'package:echo/feaatures/articles/data/data_source/local/database_helper.dart';
import 'package:echo/feaatures/articles/data/data_source/remote/article_remote_data_source.dart';
import 'package:echo/feaatures/articles/data/repositories/article_repository_impl.dart';
import 'package:echo/feaatures/articles/domain/repositories/article_repository.dart';
import 'package:echo/feaatures/articles/domain/use_cases/article_use_cases.dart';
import 'package:echo/feaatures/articles/presentation/blocs/saved_articles/saved_articles_bloc.dart';
import 'package:echo/feaatures/articles/presentation/blocs/search_articles/search_articles_bloc.dart';
import 'package:echo/feaatures/articles/presentation/blocs/top_headlines/top_headlines_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setUpSL() async {
  // Http client

  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: Environment.baseUrl,
        queryParameters: {
          "apikey": Environment.apiKey,
        },
      ),
    ),
  );

  // Database helper

  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);

  // Data sources

  sl.registerLazySingleton<ArticleRemoteDataSource>(() => ArticleRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<ArticleLocalDataSource>(() => ArticleLocalDataSourceImpl(databaseHelper: sl()));

  // Repositories

  sl.registerLazySingleton<ArticleRepository>(() => ArticleRepositoryImpl(articleRemoteDataSource: sl(), articleLocalDataSource: sl()));

  // Use cases

  sl.registerLazySingleton<FetchTopHeadlinesUseCase>(() => FetchTopHeadlinesUseCase(articleRepository: sl()));

  sl.registerLazySingleton<SearchArticlesUseCase>(() => SearchArticlesUseCase(articleRepository: sl()));

  sl.registerLazySingleton<FetchSavedArticlesUseCase>(() => FetchSavedArticlesUseCase(articleRepository: sl()));

  sl.registerLazySingleton<SaveArticleUseCase>(() => SaveArticleUseCase(articleRepository: sl()));

  sl.registerLazySingleton<RemoveArticleUseCase>(() => RemoveArticleUseCase(articleRepository: sl()));

  sl.registerLazySingleton<RemoveAllArticlesUseCase>(() => RemoveAllArticlesUseCase(articleRepository: sl()));

  // Blocs

  sl.registerLazySingleton<TopHeadlinesBloc>(() => TopHeadlinesBloc(fetchTopHeadlinesUseCase: sl()));

  sl.registerLazySingleton<SearchArticlesBloc>(() => SearchArticlesBloc(searchArticlesUseCase: sl()));

  sl.registerLazySingleton<SavedArticlesBloc>(
    () => SavedArticlesBloc(
      fetchSavedArticlesUseCase: sl(),
      saveArticleUseCase: sl(),
      removeArticleUseCase: sl(),
      removeAllArticlesUseCase: sl(),
    ),
  );
}
