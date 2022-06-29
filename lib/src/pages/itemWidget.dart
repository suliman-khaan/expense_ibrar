import 'package:expense/src/resources/category.dart';
import 'package:expense/src/resources/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ItemWidget extends StatelessWidget {
  final Category item;
  const ItemWidget({Key? key, required this.item})
      : assert(item != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            backgroundColor: item.color,
            child: item.icon,
          ),
          Text(item.name),
          Text("${currencyTester.switchCurrency().toUpperCase()} ${item.amount.toString()}"),
          Text("${item.percentage.toString()}%")
        ],
      ),
    );
  }
}
