import 'package:echo/core/enums/news_category_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class NewsCategoryCubit extends Cubit<NewsCategory> {
  NewsCategoryCubit() : super(NewsCategory.general);

  void changeNewsCategory({required NewsCategory category}) {
    emit(category);
  }

}

