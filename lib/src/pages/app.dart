import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:expense/src/pages/analytics.dart';
import 'package:expense/src/pages/setting.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:expense/src/pages/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import 'home.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int pageIndex = 1;
  final List<String> _category = [
    'Grey Structure Material',
    'Finishing Work Items',
    'Contractor',
    'Item With Material'
  ];
  final List<String> _greyMaterial = [
    'Bricks',
    'Crush',
    'Sand',
    'Steel',
    'Cement',
    'Rori',
    'Kassu',
    'Electric Items',
    'Plumbing Items',
    'Earthfil',
    'Brick Tile',
    'AC Pipe',
    'Bitumen',
    'Polythene Sheet',
    'Mud',
    'Chips',
    'Anti Termite',
    'Boring',
    'Guard Salary',
    'Electric Bill',
    'Taxes',
    'Random'
  ];
  final List<String> _finishingMaterial = [
    'Electric Items',
    'Wood Items',
    'Tiles',
    'Paint',
    'Polish',
    'Sanitary Items',
    'Granite'
  ];
  final List<String> _contractor = [
    'Labour Contact',
    'Electric Contact',
    'Plumbing Contact',
    'Tile Contact',
    'Painting Contact',
    'Polish Contact',
    'Steel Fixer'
  ];
  final List<String> _itemWithMaterial = [
    'False Ceiling',
    'Aluminum Windows',
    'Railings',
    'Saftey Grius',
    'Main Gate',
    'Steel Stairs',
    'Wooden Floor',
    'Wall Paper',
    'Fire Place',
    'Other Items',
    'Taxes'
  ];
  String? _selectCategory;
  String? _subSelectCategory;
  List<String> _subCategory = [];

  final Color color1 = const Color.fromRGBO(124, 220, 149, 1);
  final Color color2 = const Color.fromRGBO(33, 207, 184, 1);
  final Color green = const Color.fromRGBO(34, 206, 154, 1);
  List<Widget> pages = [
    const Profile(),
    const Home(),
    const Analytics(),
    const Setting(),
  ];
  final _catForm = GlobalKey<FormState>();
  final currency = TextEditingController();
  final quntity = TextEditingController()..text = '1';
  final note = TextEditingController();
  final date = TextEditingController();
  late FocusNode amountFocusNode;

  DateTime now = DateTime.now();
  DateFormat today = DateFormat('dd-MM-yyyy');

  bool isLoading = false;
  bool isStretched = false;
  String addBtn = "Add";

  @override
  void initState() {
    super.initState();
    amountFocusNode = FocusNode();
    _selectCategory = _category[0];
    _subCategory = _greyMaterial;
    _subSelectCategory = _subCategory[0];
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
    _selectCategory = _category[0];
    _subCategory = _greyMaterial;
    _subSelectCategory = _subCategory[0];
    currency.text = '';
    note.text = '';
    date.text = '';
    addBtn = 'Add';
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
        extendBody: true,
        body: pages[pageIndex],
        bottomNavigationBar: AnimatedBottomNavigationBar(
          activeColor: color1,
          splashColor: color2,
          inactiveColor: Colors.black.withOpacity(0.5),
          icons: const [
            Icons.search,
            Icons.home,
            Icons.analytics_outlined,
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

  Widget buildSheet() =>
      StatefulBuilder(builder: (context, StateSetter setState) {
        return FractionallySizedBox(
          heightFactor: 0.87,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20.0))),
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
                      "Add Items",
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
                            onChanged: (category) {
                              _subSelectCategory = null;
                              setState(() {
                                _selectCategory = category;
                                switch (category) {
                                  case 'Grey Structure Material':
                                    _subCategory = _greyMaterial;
                                    _subSelectCategory = _subCategory[0];
                                    print(_subSelectCategory);
                                    break;
                                  case 'Finishing Work Items':
                                    _subCategory = _finishingMaterial;
                                    _subSelectCategory = _subCategory[0];
                                    print(_category);
                                    break;
                                  case 'Contactorr':
                                    _subCategory = _contractor;
                                    _subSelectCategory = _subCategory[0];
                                    print(_subSelectCategory);
                                    break;
                                  default:
                                    _subCategory = _itemWithMaterial;
                                    _subSelectCategory = _subCategory[0];
                                    print(_subSelectCategory);
                                }
                              });
                            },
                          )),
                        ],
                      ),
                      const SizedBox(height: 20),
                      //sub Catergory
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
                                value: _subSelectCategory,
                                items: _subCategory
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(item),
                                        ))
                                    .toList(),
                                onChanged: (category) => setState(
                                    () => _subSelectCategory = category)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Quntity Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 45.0,
                            height: 45.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: green),
                            child: const Icon(CupertinoIcons.bag_badge_plus,
                                color: Colors.white),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: TextFormField(
                              controller: quntity,
                              keyboardType: TextInputType.number,
                              cursorColor: green,
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: green)),
                                  hintText: "Quantity"),
                            ),
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
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(2032),
                                  builder: (context, child) {
                                    return Theme(
                                      data: ThemeData(
                                          colorScheme: ColorScheme.light(
                                        primary: green,
                                        onPrimary: Colors.white,
                                        onSurface: Colors.black,
                                      )),
                                      child: child!,
                                    );
                                  },
                                );

                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('dd-MM-yyyy')
                                          .format(pickedDate);
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
                                  print(_subSelectCategory);
                                  print(quntity.text);
                                  print(date.text);
                                  print(note.text);
                                });
                                await Future.delayed(
                                    const Duration(seconds: 3));
                                setState(() =>
                                    {isLoading = false, addBtn = 'Data Added'});
                                await Future.delayed(
                                    const Duration(milliseconds: 500));
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop();
                                clean();
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
                                : Text(addBtn,
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
      });
}
