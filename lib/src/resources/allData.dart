import 'package:flutter/cupertino.dart';

class CurrencyChanger with ChangeNotifier{
  static String currencyPickerVal = "PKR";
  String switchCurrency(){
    return currencyPickerVal;
  } 
  void switchValue(val){
    currencyPickerVal = val;
    notifyListeners();
  }
}