import 'package:dio/dio.dart';
import 'package:echo/core/utils/environment.dart';
import 'package:echo/feaatures/articles/data/data_source/remote/article_remote_data_source.dart';
import 'package:echo/feaatures/articles/data/repositories/article_repository_impl.dart';
import 'package:echo/feaatures/articles/domain/repositories/article_repository.dart';
import 'package:echo/feaatures/articles/domain/use_cases/article_use_cases.dart';
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

  // Data sources

  sl.registerLazySingleton<ArticleRemoteDataSource>(() => ArticleRemoteDataSourceImpl(client: sl()));

  // Repositories

  sl.registerLazySingleton<ArticleRepository>(() => ArticleRepositoryImpl(articleRemoteDataSource: sl()));

  // Use cases

  sl.registerLazySingleton<FetchTopHeadlinesUseCase>(() => FetchTopHeadlinesUseCase(articleRepository: sl()));

  // Blocs

  sl.registerLazySingleton<TopHeadlinesBloc>(() => TopHeadlinesBloc(fetchTopHeadlinesUseCase: sl()));
}
