// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyPicker {
  CurrencyPicker({required this.countrySymbol, required this.selectedCurrency});
  final String countrySymbol;
  bool selectedCurrency;
}

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isCheckedManagement = false;
  bool isCheckedExpenses = false;
  bool isDailyReminderOn = false;
  bool isSmartReminderOn = false;
  var enableorDisable = "Disable";
  // currency sybmbols
  var pound = "";
  var dollar = "";
  var euro = "";
  var india = "";
  var jpy = "";
  var sek = "";
  var pak = "";
  var nigeria = "";
  void currency() {
    Locale locale = Localizations.localeOf(context);
    var gbp =
        NumberFormat.simpleCurrency(locale: locale.toString(), name: "GBP");
    var eur =
        NumberFormat.simpleCurrency(locale: locale.toString(), name: "EUR");
    var dlr = NumberFormat.simpleCurrency(locale: locale.toString());
    var ind =
        NumberFormat.simpleCurrency(locale: locale.toString(), name: "IND");
    var japan =
        NumberFormat.simpleCurrency(locale: locale.toString(), name: "JPY");
    var swedish =
        NumberFormat.simpleCurrency(locale: locale.toString(), name: "SEK");
    var pkr =
        NumberFormat.simpleCurrency(locale: locale.toString(), name: "PKR");
    var ngn =
        NumberFormat.simpleCurrency(locale: locale.toString(), name: "NGN");
    pound = gbp.currencySymbol;
    euro = eur.currencySymbol;
    dollar = dlr.currencySymbol;
    india = ind.currencySymbol;
    jpy = japan.currencySymbol;
    sek = swedish.currencySymbol;
    pak = pkr.currencySymbol;
    nigeria = ngn.currencySymbol;
  }

  List<CurrencyPicker> testercurrency = <CurrencyPicker>[];
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    currency();
    testercurrency
        .add(CurrencyPicker(countrySymbol: dollar, selectedCurrency: false));
    testercurrency
        .add(CurrencyPicker(countrySymbol: euro, selectedCurrency: false));
    testercurrency
        .add(CurrencyPicker(countrySymbol: india, selectedCurrency: false));
    testercurrency
        .add(CurrencyPicker(countrySymbol: jpy, selectedCurrency: false));
    testercurrency
        .add(CurrencyPicker(countrySymbol: sek, selectedCurrency: false));
    testercurrency
        .add(CurrencyPicker(countrySymbol: pound, selectedCurrency: false));
    testercurrency
        .add(CurrencyPicker(countrySymbol: pak, selectedCurrency: false));
    testercurrency
        .add(CurrencyPicker(countrySymbol: nigeria, selectedCurrency: false));
  }

  // void currency(context){
  //   Locale locale = Localizations.localeOf(context);
  //   var format = NumberFormat.simpleCurrency(locale:Platform.localeName,name:"NGN");
  //   print("First SYmbol : " + format.currencySymbol);
  //   print("First Name : " + format.currencyName);
  // }

  // for General:
  @override
  void initState() {
    super.initState();
  }

  Widget forGeneral() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "General",
            style: TextStyle(color: Colors.green),
          ),
          GestureDetector(
            onTap: () {
              print("you just clicked the theme data");
            },
            child: const ListTile(
              contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
              title: Text(
                "Theme",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text("light"),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: const Text(
              "Currency",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () async {
              currency();
              print("--- : ------" + testercurrency[0].countrySymbol);
              await showInformationDialog(context);
              // openDialog();
            },
          ),
          const ListTile(
            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
            title:
                Text("Grouping", style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text("Month"),
          )
        ],
      ),
    );
  }

  // for Manage
  Widget forManage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Manage",
            style: TextStyle(color: Colors.green),
          ),
          // const ListTile(
          //   contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
          //   title: Text("Theme",style: TextStyle(fontWeight: FontWeight.w500),),
          //   subtitle: Text("light"),
          // ),
          TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: const Text(
                "Categories",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                // currency();
              }),
          TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: const Text(
                "Regular Expenses and Income",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {}),
          TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: const Text(
                "Backup/Restore your data",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {}),
          const ListTile(
            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
            title: Text("Spreadsheet export",
                style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text("Export your record to a spreadsheet."),
          )
        ],
      ),
    );
  }

  // for Income Management
  Widget forIncomeManagement() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Text(
            "Income Management",
            style: TextStyle(color: Colors.green),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
            title: const Text("Income Management",
                style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text("Income management is ${enableorDisable}"),
            trailing: Checkbox(
                value: isCheckedManagement,
                onChanged: (value) {
                  setState(() {
                    isCheckedManagement = value!;
                    if (isCheckedManagement == true) {
                      enableorDisable = "Enable";
                    } else {
                      enableorDisable = "Disable";
                    }
                  });
                }),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
            enabled: isCheckedManagement,
            title: const Text("Carry over expenses",
                style: TextStyle(fontWeight: FontWeight.w500)),
            trailing: Checkbox(
                value: isCheckedExpenses,
                onChanged: (value) {
                  if (isCheckedManagement) {
                    setState(() {
                      isCheckedExpenses = value!;
                    });
                  }
                }),
          )
        ],
      ),
    );
  }

  // for Daily Reminder

  Widget forDailyReminder() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Text(
            "Daily Reminder",
            style: TextStyle(color: Colors.green),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
            title: const Text("Daily Reminder",
                style: TextStyle(fontWeight: FontWeight.w500)),
            trailing: Checkbox(
                value: isDailyReminderOn,
                onChanged: (value) {
                  setState(() {
                    isDailyReminderOn = value!;
                  });
                }),
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            enabled: isDailyReminderOn,
            title: const Text("Time of day"),
            subtitle: const Text("18:00"),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
            enabled: isDailyReminderOn,
            title: const Text("Smart reminder",
                style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: const Text(
                "Remind me only when I did not record an expense for the current day."),
            trailing: Checkbox(
                value: isSmartReminderOn,
                onChanged: (value) {
                  if (isDailyReminderOn) {
                    setState(() {
                      isSmartReminderOn = value!;
                    });
                  }
                }),
          )
        ],
      ),
    );
  }

  // for About
  Widget forAbout() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Text(
            "About",
            style: TextStyle(color: Colors.green),
          ),
          TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: const Text(
                "Rate app",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {}),
          TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: const Text(
                "Quick Start",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {}),
          TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: const Text(
                "About Us",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {}),
          TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: const Text(
                "Promotion Code",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {}),
          TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: const Text(
                "Open Source License",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {}),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
      body: SafeArea(
          child: ListView(
        children: [
          // for general
          forGeneral(),
          // for Manage
          forManage(),
          // for incomemanagement
          forIncomeManagement(),
          // for DailyReminder
          forDailyReminder(),
          // for About
          forAbout()
        ],
      ))
      /* SafeArea(child:ListView(
      padding: EdgeInsets.all(24),
      children: [
        SettingsGroup(
          settingsGroupTitleStyle: TextStyle(color: Colors.green),
          settingsGroupTitle:'GENERAL',
          items: <SettingsItem>[
            SettingsItem(
            onTap: () {},
            iconStyle: IconStyle(),
            title: 'Appearance',
            subtitle: "Make Ziar'App yours",
          ),
          SettingsItem(
            onTap: () {},
            icons: Icons.dark_mode_rounded,
            iconStyle: IconStyle(
              iconsColor: Colors.white,
              withBackground: true,
              backgroundColor: Colors.red,
            ),
            title: 'Dark mode',
            subtitle: "Automatic",
            trailing: Switch.adaptive(
              value: false,
              onChanged: (value) {},
            ),
          ),
            buildLogout(),
            buildDelete(),
            
          ],
        )
      ],
    )
    ),
    */
      );

  _onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        print("CLicked setting");
        break;
      case 1:
        print("you clicked more");
        break;
      default:
        print("went someting wrong");
    }
  }

  // buildLogout()=>SettingsItem(
  // DialogBox
  bool tf = false;
  Future<void> showInformationDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              actionsPadding: EdgeInsets.only(bottom: 20),
              title: const Text("Currency"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "CANCEL",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.green),
                  ),
                )
              ],
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              testercurrency[0].selectedCurrency =
                                  !testercurrency[0].selectedCurrency;
                              testercurrency[1].selectedCurrency = false;
                              testercurrency[2].selectedCurrency = false;
                              testercurrency[3].selectedCurrency = false;
                              testercurrency[4].selectedCurrency = false;
                              testercurrency[5].selectedCurrency = false;
                              testercurrency[6].selectedCurrency = false;
                              testercurrency[7].selectedCurrency = false;
                              a = testercurrency[0].countrySymbol;
                            });
                            // testercurrency[0].selectedCurrency = true;
                          },
                          style: ButtonStyle(
                              backgroundColor: testercurrency[0]
                                      .selectedCurrency
                                  ? MaterialStateProperty.all<Color>(Colors.red)
                                  : MaterialStateProperty.all<Color>(
                                      Colors.transparent)),
                          child: Text(
                            testercurrency[0].countrySymbol,
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )),
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor: testercurrency[1]
                                      .selectedCurrency
                                  ? MaterialStateProperty.all<Color>(Colors.red)
                                  : MaterialStateProperty.all<Color>(
                                      Colors.transparent)),
                          onPressed: () {
                            setState(() {
                              testercurrency[1].selectedCurrency =
                                  !testercurrency[1].selectedCurrency;
                              testercurrency[0].selectedCurrency = false;
                              testercurrency[2].selectedCurrency = false;
                              testercurrency[3].selectedCurrency = false;
                              testercurrency[4].selectedCurrency = false;
                              testercurrency[5].selectedCurrency = false;
                              testercurrency[6].selectedCurrency = false;
                              testercurrency[7].selectedCurrency = false;
                              a = testercurrency[1].countrySymbol;
                              print(a);
                            });
                          },
                          child: Text(testercurrency[1].countrySymbol,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18))),
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor: testercurrency[2]
                                      .selectedCurrency
                                  ? MaterialStateProperty.all<Color>(Colors.red)
                                  : MaterialStateProperty.all<Color>(
                                      Colors.transparent)),
                          onPressed: () {
                            setState(() {
                              testercurrency[2].selectedCurrency =
                                  !testercurrency[2].selectedCurrency;
                              testercurrency[1].selectedCurrency = false;
                              testercurrency[0].selectedCurrency = false;
                              testercurrency[3].selectedCurrency = false;
                              testercurrency[4].selectedCurrency = false;
                              testercurrency[5].selectedCurrency = false;
                              testercurrency[6].selectedCurrency = false;
                              testercurrency[7].selectedCurrency = false;
                              a = testercurrency[2].countrySymbol;
                              print(a);
                            });
                          },
                          child: Text(testercurrency[2].countrySymbol,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18))),
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor: testercurrency[3]
                                      .selectedCurrency
                                  ? MaterialStateProperty.all<Color>(Colors.red)
                                  : MaterialStateProperty.all<Color>(
                                      Colors.transparent)),
                          onPressed: () {
                            setState(() {
                              testercurrency[3].selectedCurrency =
                                  !testercurrency[3].selectedCurrency;
                              testercurrency[1].selectedCurrency = false;
                              testercurrency[0].selectedCurrency = false;
                              testercurrency[2].selectedCurrency = false;
                              testercurrency[4].selectedCurrency = false;
                              testercurrency[5].selectedCurrency = false;
                              testercurrency[6].selectedCurrency = false;
                              testercurrency[7].selectedCurrency = false;
                              a = testercurrency[3].countrySymbol;
                              print(a);
                            });
                          },
                          child: Text(testercurrency[3].countrySymbol,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18))),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              testercurrency[4].selectedCurrency =
                                  !testercurrency[4].selectedCurrency;
                              testercurrency[1].selectedCurrency = false;
                              testercurrency[0].selectedCurrency = false;
                              testercurrency[5].selectedCurrency = false;
                              testercurrency[2].selectedCurrency = false;
                              testercurrency[3].selectedCurrency = false;
                              testercurrency[6].selectedCurrency = false;
                              testercurrency[7].selectedCurrency = false;
                              a = testercurrency[4].countrySymbol;
                              print(a);
                            });
                            // testercurrency[0].selectedCurrency = true;
                          },
                          style: ButtonStyle(
                              backgroundColor: testercurrency[4]
                                      .selectedCurrency
                                  ? MaterialStateProperty.all<Color>(Colors.red)
                                  : MaterialStateProperty.all<Color>(
                                      Colors.transparent)),
                          child: Text(
                            testercurrency[4].countrySymbol,
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              testercurrency[5].selectedCurrency =
                                  !testercurrency[5].selectedCurrency;
                              testercurrency[1].selectedCurrency = false;
                              testercurrency[0].selectedCurrency = false;
                              testercurrency[4].selectedCurrency = false;
                              testercurrency[6].selectedCurrency = false;
                              testercurrency[2].selectedCurrency = false;
                              testercurrency[3].selectedCurrency = false;
                              testercurrency[7].selectedCurrency = false;
                              a = testercurrency[3].countrySymbol;
                              print(a);
                            });
                            // testercurrency[0].selectedCurrency = true;
                          },
                          style: ButtonStyle(
                              backgroundColor: testercurrency[5]
                                      .selectedCurrency
                                  ? MaterialStateProperty.all<Color>(Colors.red)
                                  : MaterialStateProperty.all<Color>(
                                      Colors.transparent)),
                          child: Text(
                            testercurrency[5].countrySymbol,
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              testercurrency[6].selectedCurrency =
                                  !testercurrency[6].selectedCurrency;
                              testercurrency[1].selectedCurrency = false;
                              testercurrency[0].selectedCurrency = false;
                              testercurrency[4].selectedCurrency = false;
                              testercurrency[5].selectedCurrency = false;
                              testercurrency[2].selectedCurrency = false;
                              testercurrency[3].selectedCurrency = false;
                              testercurrency[7].selectedCurrency = false;
                              a = testercurrency[6].countrySymbol;
                              print(a);
                            });
                            // testercurrency[0].selectedCurrency = true;
                          },
                          style: ButtonStyle(
                              backgroundColor: testercurrency[6]
                                      .selectedCurrency
                                  ? MaterialStateProperty.all<Color>(Colors.red)
                                  : MaterialStateProperty.all<Color>(
                                      Colors.transparent)),
                          child: Text(
                            testercurrency[6].countrySymbol,
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              testercurrency[7].selectedCurrency =
                                  !testercurrency[7].selectedCurrency;
                              testercurrency[1].selectedCurrency = false;
                              testercurrency[0].selectedCurrency = false;
                              testercurrency[4].selectedCurrency = false;
                              testercurrency[5].selectedCurrency = false;
                              testercurrency[2].selectedCurrency = false;
                              testercurrency[3].selectedCurrency = false;
                              testercurrency[6].selectedCurrency = false;
                              a = testercurrency[7].countrySymbol;
                              print(a);
                            });
                            // testercurrency[0].selectedCurrency = true;
                          },
                          style: ButtonStyle(
                              backgroundColor: testercurrency[7]
                                      .selectedCurrency
                                  ? MaterialStateProperty.all<Color>(Colors.red)
                                  : MaterialStateProperty.all<Color>(
                                      Colors.transparent)),
                          child: Text(
                            testercurrency[7].countrySymbol,
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )),
                    ],
                  ),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        a = text;
                        testercurrency[1].selectedCurrency = false;
                        testercurrency[0].selectedCurrency = false;
                        testercurrency[4].selectedCurrency = false;
                        testercurrency[5].selectedCurrency = false;
                        testercurrency[2].selectedCurrency = false;
                        testercurrency[3].selectedCurrency = false;
                        testercurrency[6].selectedCurrency = false;
                        testercurrency[7].selectedCurrency = false;
                      });
                    },
                    decoration:
                        InputDecoration(hintText: "Enter Your Custom Currency"),
                  ),
                  SizedBox(height: 20),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    value: isCheckboxtile1,
                    onChanged: (value) {
                      setState(() {
                        isCheckboxtile1 = value!;
                      });
                    },
                    title: Text("Currency symbol is written before amount"),
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    value: isCheckboxtile2,
                    onChanged: (value) {
                      setState(() {
                        isCheckboxtile2 = value!;
                      });
                    },
                    title: Text("Currency uses decimals"),
                  ),
                ],
              ),
            );
          });
        });
  }

  // FOR check box tiles 2 booleans
  bool isCheckboxtile1 = false;
  bool isCheckboxtile2 = false;

  // just for testing given values of currency symbol assign to a
  var a = "";
}
