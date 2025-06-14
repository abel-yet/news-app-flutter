import 'package:echo/core/utils/data_mapper.dart';
import 'package:echo/feaatures/articles/domain/entities/article_entity.dart';

class ArticleModel extends DataMapper<ArticleEntity> {
  final String title;
  final String description;
  final String content;
  final String url;
  final String image;
  final DateTime publishedAt;
  final SourceModel source;

  ArticleModel({
    required this.title,
    required this.description,
    required this.content,
    required this.url,
    required this.image,
    required this.publishedAt,
    required this.source,
  });

  @override
  ArticleEntity mapToEntity() {
    return ArticleEntity(
      title: title,
      description: description,
      content: content,
      url: url,
      image: image,
      publishedAt: publishedAt,
      source: source.mapToEntity(),
    );
  }

  factory ArticleModel.fromEntity(ArticleEntity articleEntity) {
    return ArticleModel(
      title: articleEntity.title,
      description: articleEntity.description,
      content: articleEntity.content,
      url: articleEntity.url,
      image: articleEntity.image,
      publishedAt: articleEntity.publishedAt,
      source: SourceModel.fromEntity(articleEntity.source),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'content': content,
      'url': url,
      'image': image,
      'publishedAt': publishedAt.millisecondsSinceEpoch,
      'source': source.toMap(),
    };
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      title: map['title'] as String,
      description: map['description'] as String,
      content: map['content'] as String,
      url: map['url'] as String,
      image: map['image'] as String,
      publishedAt: DateTime.parse(map['publishedAt']),
      source: SourceModel.fromMap(map['source'] as Map<String, dynamic>),
    );
  }

  factory ArticleModel.fromDB(Map<String, dynamic> map) {
    return ArticleModel(
      title: map['title'],
      description: map['description'],
      content: map['content'],
      url: map['url'],
      image: map['image'],
      publishedAt: DateTime.fromMillisecondsSinceEpoch(map['published_at']),
      source: SourceModel(name: map['source_name'], url: map['source_url']),
    );
  }

  Map<String, dynamic> toDB() {
    return {
      'title': title,
      'description': description,
      'content': content,
      'url': url,
      'image': image,
      'published_at': publishedAt.millisecondsSinceEpoch,
      'source_name': source.name,
      'source_url': source.url,
    };
  }

  ArticleModel copyWith({
    String? title,
    String? description,
    String? content,
    String? url,
    String? image,
    DateTime? publishedAt,
    SourceModel? source,
  }) {
    return ArticleModel(
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      url: url ?? this.url,
      image: image ?? this.image,
      publishedAt: publishedAt ?? this.publishedAt,
      source: source ?? this.source,
    );
  }
}

class SourceModel extends DataMapper<SourceEntity> {
  final String name;
  final String url;
  SourceModel({
    required this.name,
    required this.url,
  });

  @override
  SourceEntity mapToEntity() {
    return SourceEntity(name: name, url: url);
  }

  factory SourceModel.fromEntity(SourceEntity sourceEntity) {
    return SourceModel(name: sourceEntity.name, url: sourceEntity.url);
  }

  SourceModel copyWith({
    String? name,
    String? url,
  }) {
    return SourceModel(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
    };
  }

  factory SourceModel.fromMap(Map<String, dynamic> map) {
    return SourceModel(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }
}
