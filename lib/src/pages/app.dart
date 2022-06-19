import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
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

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    currency.dispose();
    note.dispose();
    date.dispose();
    super.dispose();
  }

  void clean() {
    _selectCategory = 'Category 1';
    currency.text = '';
    note.text = '';
    date.text = '';
  }
  // top menu button 
  _onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
      Navigator.pushNamed(context, "setting");
        break;
      case 1:
        print("you clicked more");
        break;
      default:
        print("went someting wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<int>(
              onSelected: (item) => _onSelected(context, item),
              itemBuilder: (context) =>
                  // ignore: prefer_const_constructors
                  [
                    PopupMenuItem<int>(value: 0, child: const Text("Setting")),
                    PopupMenuItem<int>(value: 1, child: const Text("more"))
                  ])
        ],
      ),
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
            onPressed: () => showModalBottomSheet(
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
                    // ignore: avoid_print
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
                    keyboardType: TextInputType.number,
                    cursorColor: green,
                    style: GoogleFonts.poppins(
                        fontSize: 30, fontWeight: FontWeight.w400),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: "0",
                        border: InputBorder.none),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 45.0,
                  height: 45.0,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: green),
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
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400))),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 45.0,
                  height: 45.0,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: green),
                  child:
                      const Icon(CupertinoIcons.calendar, color: Colors.white),
                ),
                const SizedBox(width: 15),
                // Date picker
                Expanded(
                  child: TextField(
                    controller: date, //editing controller of this TextField
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
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
                        // String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                        String formattedDate =
                            "${pickedDate.year.toString()}-${pickedDate.month.toString()}-${pickedDate.day.toString()}";
                        setState(() {
                          date.text = formattedDate;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Note
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 45.0,
                  height: 45.0,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: green),
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
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: green)),
                        hintText: "Notes"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      print(currency.text);
                      print(date.text);
                      print(_selectCategory);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      primary: green,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  child: Text("Add",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                )
              ],
            )
          ]),
        ),
      );
}
