import 'package:echo/core/enums/news_category_enum.dart';
import 'package:echo/core/utils/extnesions.dart';
import 'package:echo/feaatures/articles/presentation/blocs/news_category/news_category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCategoryChip extends StatelessWidget {
  final NewsCategory category;
  const NewsCategoryChip({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final currentlySelectedCategory = context.read<NewsCategoryCubit>().state;
    return GestureDetector(
      onTap: () {
        context.read<NewsCategoryCubit>().changeNewsCategory(category: category);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: context.width * .03, vertical: context.width * .015),
        margin: EdgeInsets.only(right: context.width * .04),
        decoration: BoxDecoration(
          color: currentlySelectedCategory == category
              ? isDark
                    ? context.theme.appColors.secondaryColor
                    : context.theme.appColors.primaryColor
              : null,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          category.displayName,
          style: TextStyle(
            color: currentlySelectedCategory == category
                ? isDark
                      ? context.theme.appColors.primaryColor
                      : context.theme.appColors.secondaryColor
                : null,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
