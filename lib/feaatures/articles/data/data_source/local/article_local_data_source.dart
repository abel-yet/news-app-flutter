import 'package:echo/feaatures/articles/data/data_source/local/database_helper.dart';
import 'package:echo/feaatures/articles/data/models/article_model.dart';

abstract class ArticleLocalDataSource {
  Future<List<ArticleModel>> fetchSavedArticles();
  Future<int> saveArticle({required ArticleModel article});
  Future<int> removeArticle({required String id});
  Future<int> removeAllArticles();
}

class ArticleLocalDataSourceImpl implements ArticleLocalDataSource {
  final DatabaseHelper databaseHelper;

  ArticleLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<ArticleModel>> fetchSavedArticles() async {
    final result = await databaseHelper.getArticles();

    final articles = result.map((m) => ArticleModel.fromDB(m)).toList();

    return articles;
  }

  @override
  Future<int> saveArticle({required ArticleModel article}) async {
    final result = await databaseHelper.addArticle(article: article.toDB());

    return result;
  }

  @override
  Future<int> removeArticle({required String id}) async {
    final result = await databaseHelper.removeArticle(id: id);

    return result;
  }

  @override
  Future<int> removeAllArticles() async {
    final result = await databaseHelper.removeAllArticles();
    
    return result;
  }
}
