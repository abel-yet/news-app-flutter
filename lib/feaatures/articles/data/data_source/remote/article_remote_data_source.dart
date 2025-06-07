import 'package:dio/dio.dart';
import 'package:echo/core/enums/news_category_enum.dart';
import 'package:echo/feaatures/articles/data/models/article_model.dart';

abstract class ArticleRemoteDataSource {
  Future<List<ArticleModel>> fetchTopHeadlines({required NewsCategory category});
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
}
