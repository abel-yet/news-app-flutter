import 'package:echo/core/enums/news_category_enum.dart';
import 'package:echo/core/utils/extnesions.dart';
import 'package:echo/feaatures/articles/presentation/blocs/news_category/news_category_cubit.dart';
import 'package:echo/feaatures/articles/presentation/blocs/top_headlines/top_headlines_bloc.dart';
import 'package:echo/feaatures/articles/presentation/widgets/article_card.dart';
import 'package:echo/feaatures/articles/presentation/widgets/news_category_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopHeadlinesScreen extends StatelessWidget {
  static const routeName = "topHeadlines";
  const TopHeadlinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // News category
          BlocConsumer<NewsCategoryCubit, NewsCategory>(
            listener: (context, state) {
              context.read<TopHeadlinesBloc>().add(FetchTopHeadlinesEvent(category: state));
            },
            builder: (context, state) {
              return Container(
                height: 80,
                padding: EdgeInsets.fromLTRB(context.width * .05, context.width * .05, 0, context.width * .05),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: NewsCategory.values.map((category) => NewsCategoryChip(category: category)).toList(),
                  ),
                ),
              );
            },
          ),

          // Top headlines
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * .05),
              child: BlocBuilder<TopHeadlinesBloc, TopHeadlinesState>(
                builder: (context, state) {
                  switch (state) {
                    case TopHeadlinesInitial():
                      return Container();
                    case TopHeadlinesLoading():
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
                    case TopHeadlinesFetched():
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.articles.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: context.width * .06),
                            child: ArticleCard(articleEntity: state.articles[index]),
                          );
                        },
                      );
                    case TopHeadlinesError():
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
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
