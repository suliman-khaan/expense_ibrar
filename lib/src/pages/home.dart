import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense/src/resources/allData.dart';
import 'package:flutter/material.dart';

import '../resources/config.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // temrory random data 
  int randomNumber = 7;



  final Color color1 = const Color.fromRGBO(124, 220, 149, 1);
  final Color color2 = const Color.fromRGBO(33, 207, 184, 1);
  final Color backgroundColor = const Color.fromRGBO(241, 240, 246, 1);
  List<Icon> icons = const [
    Icon(Icons.build),
    Icon(Icons.format_align_justify),
    Icon(Icons.grid_on),
    Icon(Icons.highlight),
    Icon(Icons.lightbulb),
    Icon(Icons.gesture),
    Icon(Icons.fire_hydrant),
  ];
  // List<IconData> iconItems = ;
  Container circle() {
    return Container(
      height: 240,
      width: 240,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white10,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          // 1) Creating Custom AppBar
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color1, color2],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Positioned(
                  // hit and trail
                  top: -100,
                  left: -100,
                  child: circle(),
                ),
                Positioned(
                  // hit and trail
                  bottom: -120,
                  right: -70,
                  child: circle(),
                ),
                Positioned(
                  // hit and trail
                  bottom: -50,
                  right: -170,
                  child: circle(),
                ),
                Positioned(
                  // hit and trail
                  bottom: 130,
                  right: 110,
                  left: 100,
                  child: circle(),
                ),

                // 1.1) Creating avatar
                const Positioned(
                  top: 50,
                  left: 15,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),
                ),

                // 1.2) Creating button
                Positioned(
                  top: 50,
                  right: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "Pay in aweek",
                      // AppLocalizations.of(context)!.payday_in_a_week,
                      style: TextStyle(
                        color: color2,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),

                // 1.3) Creating amount display
                const Positioned(
                  left: 15,
                  bottom: 60,
                  child: Text(
                    "Total Balance to spend",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),

                // 1.4) Creating amount
                Positioned(
                  left: 15,
                  bottom: 20,
                  child: Text(
                    "${currencyTester.switchCurrency().toUpperCase()}5785.55",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2) Creating section title
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            sliver: SliverToBoxAdapter(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('expense')
                    .where('date',
                        isGreaterThanOrEqualTo: DateTime.now().toString())
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Text(
                      "Please Restart Your App.",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final addAmount = snapshot.data!.docs;
                    // planning Amount Data
                    num planningAmount = 0;
                    for (int i = 0; i < addAmount.length; i++) {
                      planningAmount += addAmount[i]['amount'];
                    }
                    return SectionHeader(
                      title: "Planning Ahead",
                      actionText: "${currencyTester.switchCurrency()} ${planningAmount.toString()}",
                    );
                  } else {
                    return Text('${snapshot.data}');
                  }
                },
              ),
            ),
          ),

          // 3) Horizontal Cards list
          SliverPadding(
            padding: const EdgeInsets.only(left: 20.0),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 120,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('expense')
                        .where('date',
                            isGreaterThanOrEqualTo: DateTime.now().toString())
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Text(
                          "Please Restart Your App.",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      } else if (snapshot.hasData) {
                        final expense = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: expense.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final expenseDate =
                                DateTime.parse(expense[index]['date']);
                            final today = DateTime.now();
                            final difference =
                                expenseDate.difference(today).inDays;
                            return Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Wrap(
                                  direction: Axis.vertical,
                                  spacing: 10,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: const BoxDecoration(
                                        color: Colors.amber,
                                        shape: BoxShape.circle,
                                      ),
                                      child: icons[Random().nextInt(randomNumber)],
                                    ),
                                    Text(
                                      "${currencyTester.switchCurrency().toUpperCase()} ${expense[index]['amount']}",
                                      style: TextStyle(
                                        color: color2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "In a $difference days",
                                      style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Text('${snapshot.data}');
                      }
                    }),
              ),
            ),
          ),

          // 4) Divider
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: const Divider(),
            ),
          ),

          // 5) Header of scrolling calendar
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            sliver: SliverToBoxAdapter(
              child: SectionHeader(
                title: "Last Month Expense",
                actionText: "-\$1800.50",
              ),
            ),
          ),

          // 6) Scrolling calendar
          /*
          SliverPadding(
            padding:
                const EdgeInsets.only(bottom: 8.0, left: 20.0, right: 20.0),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 60,
                child: ListView.builder(
                  itemCount: 30,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            (index + 1).toString(),
                            style: TextStyle(
                              color: Colors.grey.shade800,
                            ),
                          ),
                          Text(
                            "MAY",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                          ),
                          Container(
                            height: 5,
                            width: 5,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
*/
          SliverPadding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            sliver: SliverList(
                delegate: SliverChildListDelegate([
              SingleChildScrollView(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('expense')
                      .where('date', isLessThan: DateTime.now().toString())
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Text(
                        "Please Restart YOur App.",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    } else if (snapshot.hasData) {
                      final expenseData = snapshot.data!.docs;
                      return Container(
                        transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: expenseData.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 5.0),
                              padding: const EdgeInsets.all(10),
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: const BoxDecoration(
                                        color: Colors.amber,
                                        shape: BoxShape.circle),
                                    child: icons[Random().nextInt(randomNumber)],
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      expenseData[index]["sub-category"],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Text('-${expenseData[index]["amount"]}'),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Text('${snapshot.data}');
                    }
                  },
                ),
              )
            ])),
          ),
          // SliverPadding(
          //     padding:
          //         const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 60.0),
          //     sliver:SliverToBoxAdapter(
          //       child: StreamBuilder<QuerySnapshot>(
          //       stream: FirebaseFirestore.instance.collection('expense').snapshots(),
          //       builder: (context,snapshot){
          //         if (snapshot.connectionState == ConnectionState.waiting) {
          //                 return const Center(
          //                   child: CircularProgressIndicator(),
          //                 );
          //               }
          //         if(snapshot.hasError){
          //           return const Text("Please Restart YOur App.", style: TextStyle(
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.w500,
          //                   ),);
          //         }else if(snapshot.hasData){
          //         final expenseData = snapshot.data!.docs;
          //         return SliverList(
          //         delegate: SliverChildBuilderDelegate(
          //           (context, index) {
          //             return Container(
          //               margin: const EdgeInsets.only(bottom: 5.0),
          //               padding: const EdgeInsets.all(10),
          //               height: 80,
          //               decoration: BoxDecoration(
          //                 color: Colors.white,
          //                 borderRadius: BorderRadius.circular(12),
          //               ),
          //               child: Row(
          //                 children: [
          //                   Container(
          //                     height: 40,
          //                     width: 40,
          //                     decoration: const BoxDecoration(
          //                         color: Colors.amber, shape: BoxShape.circle),
          //                     child: icons[index],
          //                   ),
          //                   const SizedBox(width: 10),
          //                   Expanded(
          //                     child: Text(
          //                       expenseData[index]["sub-category"],
          //                       style: const TextStyle(
          //                         fontWeight: FontWeight.bold,
          //                         fontSize: 16,
          //                         color: Colors.grey,
          //                       ),
          //                     ),
          //                   ),
          //                    Text('-${expenseData[index]["sub-category"]}'),
          //                 ],
          //               ),
          //             );
          //           },
          //           childCount: expenseData.length,
          //         ),
          //       );
          //       } else {
          //                 return Text('${snapshot.data}');
          //               }
          //       },
          //     ),

          //     )

          //   ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;

  const SectionHeader({
    Key? key,
    required this.title,
    required this.actionText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Text(actionText),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_right_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
