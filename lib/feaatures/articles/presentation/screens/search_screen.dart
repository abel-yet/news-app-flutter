import 'package:echo/core/utils/extnesions.dart';
import 'package:echo/core/utils/helper_functions.dart';
import 'package:echo/feaatures/articles/presentation/blocs/search_articles/search_articles_bloc.dart';
import 'package:echo/feaatures/articles/presentation/widgets/article_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "searchScreen";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(context.width * .05, context.width * .03, context.width * .05, 0),
        child: Column(
          spacing: context.width * .05,
          children: [
            // Search bar
            TextField(
              controller: _textEditingController,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: "Search...",
                suffixIcon: GestureDetector(
                  onTap: () {
                    if (_textEditingController.text.isNotEmpty) {
                      context.read<SearchArticlesBloc>().add(SearchArticlesEvent(query: _textEditingController.text));
                    }
                  },
                  child: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: Colors.grey,
                  ),
                ),
              ),
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  context.read<SearchArticlesBloc>().add(SearchArticlesEvent(query: value));
                }
              },
            ),

            // Search Result
            Expanded(
              child: BlocConsumer<SearchArticlesBloc, SearchArticlesState>(
                listener: (context, state) {
                  if (state is SearchArticlesError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      buildSnackbar(
                        message: state.errorMessage,
                        isError: true,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  switch (state) {
                    case SearchArticlesInitial():
                      return Center(
                        child: Text(
                          "Looking for something? Search for articles by keyword or topic.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      );
                    case SearchArticlesLoading():
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ArticleCard.loading(context);
                        },
                      );
                    case SearchArticlesFetched():
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.articles.length,
                        itemBuilder: (context, index) {
                          return ArticleCard(articleEntity: state.articles[index]);
                        },
                      );
                    case SearchArticlesError():
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ArticleCard.error(context);
                        },
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
