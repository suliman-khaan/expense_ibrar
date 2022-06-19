import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final currency = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    currency.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(children: <Widget>[
            Row(
              children: [
                GestureDetector(
                  // ignore: avoid_print
                  onTap: (() => print("Closing")),
                  child: const Icon(CupertinoIcons.clear, size: 25.0),
                ),
                const SizedBox(width: 50.0),
                const Text(
                  "Add Expense",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                      fontFamily: 'Raleway'),
                )
              ],
            ),
            const SizedBox(height: 40),
            Row(
              children: <Widget>[
                //Currency
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(34, 206, 154, 1),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () => {},
                    child: const Text("PKR")),
                TextFormField(
                  controller: currency,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Input",
                    fillColor: Colors.red,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
