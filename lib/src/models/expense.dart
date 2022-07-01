import 'dart:core';

class Expense {
  int? amount;
  String? category;
  String? subCategory;
  int? quntity;
  String? date;
  String? note;

  Expense(
      {required this.amount,
      required this.category,
      required this.subCategory,
      required this.quntity,
      required this.date,
      this.note = ''});
  Map<String, dynamic> toJson() => {
        'user': "Test-user",
        'amount': amount,
        'category': category,
        'sub-category': subCategory,
        'quantity': quntity,
        'date': date,
        'note': note
      };
  static Expense fromJson(Map<String, dynamic> json) => Expense(
      amount: json['amount'],
      category: json['category'],
      subCategory: json['subCategory'],
      quntity: json['quntity'],
      date: json['date']);
}
