import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final String title;
  final String description;
  final String content;
  final String url;
  final String image;
  final DateTime publishedAt;
  final SourceEntity source;

  const ArticleEntity({
    required this.title,
    required this.description,
    required this.content,
    required this.url,
    required this.image,
    required this.publishedAt,
    required this.source,
  });

  @override
  List<Object?> get props => [
    title,
    description,
    content,
    url,
    image,
    publishedAt,
    source,
  ];

  ArticleEntity copyWith({
    String? title,
    String? description,
    String? content,
    String? url,
    String? image,
    DateTime? publishedAt,
    SourceEntity? source,
  }) {
    return ArticleEntity(
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

class SourceEntity extends Equatable {
  final String name;
  final String url;

  const SourceEntity({
    required this.name,
    required this.url,
  });

  @override
  List<Object?> get props => [name, url];

  SourceEntity copyWith({
    String? name,
    String? url,
  }) {
    return SourceEntity(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }
}
