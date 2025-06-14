import 'package:echo/core/utils/extnesions.dart';
import 'package:echo/core/utils/helper_functions.dart';
import 'package:echo/feaatures/articles/presentation/blocs/saved_articles/saved_articles_bloc.dart';
import 'package:echo/feaatures/articles/presentation/blocs/search_articles/search_articles_bloc.dart';
import 'package:echo/feaatures/articles/presentation/blocs/top_headlines/top_headlines_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ScaffoldWithBottomNav extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const ScaffoldWithBottomNav({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          // Listeners to react to error and success cases and show snackbar
          BlocListener<TopHeadlinesBloc, TopHeadlinesState>(
            listener: (context, state) {
              if (state is TopHeadlinesError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  buildSnackbar(
                    message: state.errorMessage,
                    isError: true,
                  ),
                );
              }
            },
          ),
          BlocListener<SearchArticlesBloc, SearchArticlesState>(
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
          ),
          BlocListener<SavedArticlesBloc, SavedArticlesState>(
            listener: (context, state) {
              if (state.status == SavedArticlesStatus.saveOrRemoveError || state.status == SavedArticlesStatus.fetchError) {
                ScaffoldMessenger.of(context).showSnackBar(buildSnackbar(message: state.message ?? "Error", isError: true));
              } else if (state.status == SavedArticlesStatus.saveOrRemoveSuccessful) {
                ScaffoldMessenger.of(context).showSnackBar(buildSnackbar(message: state.message ?? "Successful"));
              }
            },
          ),
        ],
        child: navigationShell,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: context.width * .05, vertical: context.width * .05),
        color: Colors.black,
        child: GNav(
          selectedIndex: navigationShell.currentIndex,
          gap: 8,
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          haptic: true,
          padding: EdgeInsetsGeometry.all(16),
          onTabChange: (value) {
            navigationShell.goBranch(value);
          },
          tabs: [
            GButton(
              icon: FontAwesomeIcons.newspaper,
              text: "Top Headlines",
            ),
            GButton(
              icon: FontAwesomeIcons.magnifyingGlass,
              text: "Search",
            ),
            GButton(
              icon: FontAwesomeIcons.heart,
              text: "Saved",
            ),
          ],
        ),
      ),
    );
  }
}
