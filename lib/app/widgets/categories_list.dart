import 'package:expense_tracker/app/models/category.dart';
import 'package:expense_tracker/core/app_theme.dart';
import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  final Category? selectedCategory;
  final Function(Category?) onTap;
  const CategoryFilter(
      {Key? key, required this.selectedCategory, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          buildChip('All',
              isSelected: selectedCategory == null, onTap: () => onTap(null)),
          ...categories.map(
            (category) => buildChip(category.name,
                icon: category.icon,
                isSelected: category.name == selectedCategory?.name,
                onTap: () => onTap(category)),
          ),
        ],
      ),
    );
  }

  Widget buildChip(
    String label, {
    Function()? onTap,
    IconData? icon,
    bool isSelected = false,
  }) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: onTap,
        child: Chip(
          avatar: icon != null
              ? Icon(
                  icon,
                  color: AppTheme.secondary,
                )
              : null,
          side: isSelected ? null : BorderSide(color: AppTheme.secondary),
          backgroundColor: isSelected ? AppTheme.primary : AppTheme.offWhite,
          label: Text(label),
          labelStyle: TextStyle(
            color: isSelected ? AppTheme.white : AppTheme.secondary,
          ),
        ),
      ),
    );
  }
}
