import 'package:echo/config/routing/router.dart';
import 'package:echo/config/theme/theme.dart';
import 'package:echo/core/dependency_injection.dart';
import 'package:echo/feaatures/articles/presentation/blocs/news_category/news_category_cubit.dart';
import 'package:echo/feaatures/articles/presentation/blocs/search_articles/search_articles_bloc.dart';
import 'package:echo/feaatures/articles/presentation/blocs/top_headlines/top_headlines_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load();
  await setUpSL();
  runApp(const Echo());
}

class Echo extends StatelessWidget {
  const Echo({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCategoryCubit(),
        ),
        BlocProvider(
          create: (context) => sl<TopHeadlinesBloc>()
            ..add(
              FetchTopHeadlinesEvent(category: context.read<NewsCategoryCubit>().state),
            ),
        ),
        BlocProvider(
          create: (context) => sl<SearchArticlesBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
      ),
    );
  }
}
