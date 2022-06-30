// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CurrencyChanger with ChangeNotifier {
  // Dialogbox data
  static String currencyPickerVal = "PKR";
  static bool isCheckedManagement = false;
  static bool isCheckedExpenses = false;
  static bool isDailyReminderOn = false;
  static bool isSmartReminderOn = false;

  static bool isCurrencySelect = false;
  static List<CurrencyPicker> testercurrency = <CurrencyPicker>[];
  // textfield data
  static String textfieldData = "";
  String switchCurrency() {
    return currencyPickerVal;
  }

  void switchValue(val) {
    currencyPickerVal = val;
    for (var i = 0; i < testercurrency.length; i++) {
      if (val == testercurrency[i].countrySymbol) {
        testercurrency[i].selectedCurrency = true;
      } else {
        testercurrency[i].selectedCurrency = false;
      }
    }
    notifyListeners();
  }
}

class CurrencyPicker {
  CurrencyPicker({required this.countrySymbol, required this.selectedCurrency});
  final String countrySymbol;
  bool selectedCurrency;
}

