import 'package:echo/core/utils/extnesions.dart';
import 'package:echo/core/utils/helper_functions.dart';
import 'package:echo/feaatures/articles/domain/entities/article_entity.dart';
import 'package:echo/feaatures/articles/presentation/screens/article_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ArticleCard extends StatelessWidget {
  final ArticleEntity articleEntity;
  const ArticleCard({super.key, required this.articleEntity});

  static Widget loading(BuildContext context) {
    return Container(
      height: context.width * .3,
      margin: EdgeInsets.only(bottom: context.width * .06),
      child: Row(
        spacing: context.width * .04,
        children: [
          shimmerContainer(
            height: context.width * .3,
            width: context.width * .3,
            borderRadius: 6,
          ),
          Expanded(
            child: shimmerContainer(
              height: context.width * .1,
              width: double.infinity,
              borderRadius: 3,
            ),
          ),
        ],
      ),
    );
  }

  static Widget error(BuildContext context) {
    return Container(
      height: context.width * .3,
      margin: EdgeInsets.only(bottom: context.width * .06),
      child: Row(
        spacing: context.width * .04,
        children: [
          Container(
            width: context.width * .3,
            height: context.width * .3,
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(50),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          Expanded(
            child: Container(
              height: context.width * .1,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(50),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          ArticleScreen.routName,
          pathParameters: {
            "url": articleEntity.url,
          },
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: context.width * .06),
        child: Row(
          spacing: context.width * .04,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                articleEntity.image,
                height: context.width * .3,
                width: context.width * .3,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: context.width * .3,
                    height: context.width * .3,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  );
                },
              ),
            ),

            Expanded(
              child: Column(
                spacing: context.width * .02,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Source name
                  Text(
                    articleEntity.source.name,
                    style: TextStyle(color: context.theme.appColors.accentColor, fontSize: 10, fontWeight: FontWeight.w900),
                  ),

                  // Title
                  Text(
                    articleEntity.title,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),

                  // Date
                  Text(
                    articleEntity.publishedAt.formattedDate(),
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      color: context.theme.brightness == Brightness.dark ? Colors.grey.shade300 : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
