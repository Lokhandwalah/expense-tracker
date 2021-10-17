import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData icon;

  const Category({required this.name, required this.icon});

  static Category clothing = const Category(
    name: 'Clothing',
    icon: Icons.checkroom,
  );
  static Category food = const Category(
    name: 'Food',
    icon: Icons.fastfood,
  );
  static Category travel = const Category(
    name: 'Travel',
    icon: Icons.directions_bike,
  );
  static Category bills = const Category(
    name: 'Bills',
    icon: Icons.receipt_long,
  );
  static Category electronics = const Category(
    name: 'Electronics',
    icon: Icons.devices,
  );
  static Category others = const Category(
    name: 'Others',
    icon: Icons.monetization_on_outlined,
  );
}

List<Category> get categories => <Category>[
      Category.clothing,
      Category.food,
      Category.travel,
      Category.electronics,
      Category.bills,
      Category.others,
    ];
