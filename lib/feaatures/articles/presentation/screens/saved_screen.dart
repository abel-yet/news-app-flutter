import 'package:echo/core/utils/extnesions.dart';
import 'package:echo/feaatures/articles/presentation/blocs/saved_articles/saved_articles_bloc.dart';
import 'package:echo/feaatures/articles/presentation/widgets/article_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SavedScreen extends StatelessWidget {
  static const routeName = "savedScreen";
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(context.width * .05, context.width * .05, context.width * .05, 0),
        child: BlocBuilder<SavedArticlesBloc, SavedArticlesState>(
          builder: (context, state) {
            switch (state.status) {
              case SavedArticlesStatus.initial:
                return Container();
              case SavedArticlesStatus.loading:
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: context.width * .06),
                      child: ArticleCard.loading(context),
                    );
                  },
                );
              case SavedArticlesStatus.noSavedArticle:
                return Center(
                  child: Text(
                    "You haven't saved any articles yet. Start exploring and tap the save icon to keep your favorites here!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                );
              case SavedArticlesStatus.fetchError:
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: context.width * .06),
                      child: ArticleCard.error(context),
                    );
                  },
                );
              case SavedArticlesStatus.fetchSuccessful:
              case SavedArticlesStatus.saveOrRemoveSuccessful:
              case SavedArticlesStatus.saveOrRemoveError:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Delete all button
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                      ),
                      onPressed: () {
                        _showDeleteAllDialog(context);
                      },
                      child: Text("Clear All"),
                    ),

                    // Saved articles
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.articles.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: context.width * .06),
                            child: Slidable(
                              endActionPane: ActionPane(
                                motion: StretchMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      _showDeleteDialog(context, state.articles[index].url);
                                    },
                                    icon: FontAwesomeIcons.trashCan,
                                    backgroundColor: context.theme.appColors.errorColor,
                                  ),
                                ],
                              ),
                              child: ArticleCard(articleEntity: state.articles[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Article"),
          content: Text("Are you sure you want to delete this article?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: context.theme.textTheme.bodyMedium,
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<SavedArticlesBloc>().add(RemoveArticleEvent(id: url));
                Navigator.pop(context);
              },
              child: Text(
                "Yes",
                style: context.theme.textTheme.bodyMedium,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete All Articles"),
          content: Text("Are you sure you want to delete all saved articles?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: context.theme.textTheme.bodyMedium,
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<SavedArticlesBloc>().add(RemoveAllArticlesEvent());
                Navigator.pop(context);
              },
              child: Text(
                "Yes",
                style: context.theme.textTheme.bodyMedium,
              ),
            ),
          ],
        );
      },
    );
  }
}
