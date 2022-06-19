import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:expense/src/pages/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int pageIndex = 1;
  final List<String> _category = [
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4'
  ];
  String? _selectCategory = 'Category 1';

  final Color color1 = const Color.fromRGBO(124, 220, 149, 1);
  final Color color2 = const Color.fromRGBO(33, 207, 184, 1);
  final Color green = const Color.fromRGBO(34, 206, 154, 1);
  List<Widget> pages = [
    const Profile(),
    const Home(),
    const Profile(),
    const Home(),
    const Profile(),
  ];
  final currency = TextEditingController();
  final note = TextEditingController();
  final date = TextEditingController();
  late FocusNode amountFocusNode;
  final _catForm = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    amountFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    currency.dispose();
    note.dispose();
    date.dispose();
    amountFocusNode.dispose();

    super.dispose();
  }

  void clean() {
    _selectCategory = 'Category 1';
    currency.text = '';
    note.text = '';
    date.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: pages[pageIndex],
        bottomNavigationBar: AnimatedBottomNavigationBar(
          activeColor: color1,
          splashColor: color2,
          inactiveColor: Colors.black.withOpacity(0.5),
          icons: const [
            Icons.search,
            Icons.home,
            Icons.favorite,
            Icons.settings,
          ],
          activeIndex: pageIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
          leftCornerRadius: 10,
          iconSize: 25,
          rightCornerRadius: 10,
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
          },
          //other params
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => {
                  amountFocusNode.requestFocus(),
                  showModalBottomSheet(
                    isDismissible: false,
                    // enableDrag: false,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20.0))),
                    context: context,
                    builder: (context) => buildSheet(),
                  ),
                },
            backgroundColor: color1,
            // ignore: prefer_const_constructors
            child: Icon(
              Icons.add,
              size: 25,
            )),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }

  Widget buildSheet() => FractionallySizedBox(
        heightFactor: 0.87,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
          child: ListView(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (() {
                      Navigator.of(context).pop();
                      clean();
                    }),
                    child: const Icon(CupertinoIcons.clear, size: 25.0),
                  ),
                  const SizedBox(width: 50.0),
                  Text(
                    "Add Expense",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400, fontSize: 18.0),
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
            Form(
                key: _catForm,
                child: Column(
                  children: [
                    // currency Row
                    Row(
                      children: <Widget>[
                        //Currency
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: green,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () => {},
                            child: const Text("PKR")),
                        Expanded(
                          child: TextFormField(
                              controller: currency,
                              focusNode: amountFocusNode,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(13),
                                ThousandsFormatter(allowFraction: true)
                              ],
                              cursorColor: green,
                              style: GoogleFonts.poppins(
                                  fontSize: 30, fontWeight: FontWeight.w400),
                              decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  hintText: "0",
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter amount to add your expense.";
                                }
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    //category row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 45.0,
                          height: 45.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: green),
                          child: const Icon(CupertinoIcons.square_grid_2x2,
                              color: Colors.white),
                        ),
                        const SizedBox(width: 15),
                        // Category Input
                        Expanded(
                          child: DropdownButtonFormField<String>(
                              icon: const Icon(CupertinoIcons.right_chevron),
                              iconSize: 24,
                              elevation: 0,
                              dropdownColor: Colors.grey.shade100,
                              style: GoogleFonts.poppins(
                                  height: 1,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 18),
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: green)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400))),
                              value: _selectCategory,
                              items: _category
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      ))
                                  .toList(),
                              onChanged: (category) =>
                                  setState(() => _selectCategory = category)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    //Date Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 45.0,
                          height: 45.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: green),
                          child: const Icon(CupertinoIcons.calendar,
                              color: Colors.white),
                        ),
                        const SizedBox(width: 15),
                        // Date picker
                        Expanded(
                          child: TextFormField(
                            controller:
                                date, //editing controller of this TextField
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: green)),
                                hintText: "Select Date" //label text of field
                                ),
                            readOnly: true,
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w400),
                            onTap: () async {
                              final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
                                setState(() {
                                  date.text = formattedDate;
                                });
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please! Select Date to add expense.";
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Note Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 45.0,
                          height: 45.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: green),
                          child: const Icon(CupertinoIcons.text_justifyleft,
                              color: Colors.white),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextFormField(
                            controller: note,
                            cursorColor: green,
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: green)),
                                hintText: "Notes"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    //add Button --> Submit form
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (_catForm.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                                print(currency.text);
                                print(date.text);
                                print(_selectCategory);
                              });
                              await Future.delayed(const Duration(seconds: 5));
                              setState(() => isLoading = false);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: green,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            shape: const StadiumBorder(),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text("Add",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                        )
                      ],
                    )
                  ],
                ))
          ]),
        ),
      );
}
