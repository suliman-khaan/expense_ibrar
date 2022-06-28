// ignore_for_file: unnecessary_this
import 'package:flutter/material.dart';

class Category {
  final String name;
  final Icon icon;
  final int amount;
  final int percentage;
  final Color color;
  Category(
      {required this.name,
      required this.icon,
      required this.amount,
      required this.percentage,
      required this.color});
}

class Catalogmodel {
  static final List<Category>  products = [
    Category(
        name: "Bricks",
        icon: const Icon(Icons.grid_on,color: Colors.white),
        amount: 50000,
        percentage: 20,
        color: Colors.amber),

        Category(
        name: "Crush",
        icon: const Icon(Icons.build,color: Colors.white),
        amount: 12334,
        percentage: 10,
        color: Colors.red),

    Category(
        name: "Sand",
        icon: const Icon(Icons.home,color: Colors.white),
        amount: 32000,
        percentage: 20,
        color: Colors.blue),

    Category(
        name: "Steel",
        icon: const Icon(Icons.format_align_justify,color: Colors.white),
        amount: 2000,
        percentage: 50,
        color: Colors.grey),
      
  ];
}
