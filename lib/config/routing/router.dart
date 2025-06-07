import 'package:echo/core/common/presentation/screens/scaffold_with_bottom_nav.dart';
import 'package:echo/feaatures/articles/presentation/screens/article_screen.dart';
import 'package:echo/feaatures/articles/presentation/screens/saved_screen.dart';
import 'package:echo/feaatures/articles/presentation/screens/search_screen.dart';
import 'package:echo/feaatures/articles/presentation/screens/top_headlines_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/topHeadlines',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithBottomNav(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: TopHeadlinesScreen.routeName,
              path: '/topHeadlines',
              builder: (context, state) {
                return const TopHeadlinesScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: SearchScreen.routeName,
              path: '/search',
              builder: (context, state) {
                return const SearchScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: SavedScreen.routeName,
              path: '/saved',
              builder: (context, state) {
                return const SavedScreen();
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      name: ArticleScreen.routName,
      path: '/article/:url',
      builder: (context, state) {
        final url = state.pathParameters['url']!;
        return ArticleScreen(articleUrl: url);
      },
    ),
  ],
);
