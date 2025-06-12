import 'package:dio/dio.dart';
import 'package:echo/core/enums/news_category_enum.dart';
import 'package:echo/feaatures/articles/data/models/article_model.dart';

abstract class ArticleRemoteDataSource {
  Future<List<ArticleModel>> fetchTopHeadlines({required NewsCategory category});
  Future<List<ArticleModel>> searchArticles({required String query});
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final Dio client;

  ArticleRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ArticleModel>> fetchTopHeadlines({required NewsCategory category}) async {
    final response = await client.get(
      "/top-headlines",
      queryParameters: {
        "category": category.name,
        "max": 10,
        "lang": "en"
      },
    );
    final List<ArticleModel> articleModels = response.data['articles'].map<ArticleModel>(
      (m) {
        return ArticleModel.fromMap(m);
      },
    ).toList();
    return articleModels;
  }

  @override
  Future<List<ArticleModel>> searchArticles({required String query}) async {
    final response = await client.get(
      "/search",
      queryParameters: {
        "q": query,
        "max": 10,
        "lang": "en",
        "in": "	title,description,content"
      }
    );
    final List<ArticleModel> articleModels = response.data['articles'].map<ArticleModel>(
      (m) {
        return ArticleModel.fromMap(m);
      },
    ).toList();
    return articleModels;
  }
}
