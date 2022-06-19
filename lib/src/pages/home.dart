// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Color color1 = const Color.fromRGBO(124, 220, 149, 1);
  final Color color2 = const Color.fromRGBO(33, 207, 184, 1);
  final Color backgroundColor = const Color.fromRGBO(241, 240, 246, 1);

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
                    backgroundColor: Colors.amber,
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
                const Positioned(
                  left: 15,
                  bottom: 20,
                  child: Text(
                    "\$5785.55",
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
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            sliver: SliverToBoxAdapter(
              child: SectionHeader(
                title: "Planning Ahead",
                actionText: "-\$540.52",
              ),
            ),
          ),

          // 3) Horizontal Cards list
          SliverPadding(
            padding: const EdgeInsets.only(left: 20.0),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                  itemCount: 7,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
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
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage("assets/e5_$index.png"),
                                ),
                              ),
                            ),
                            Text(
                              "-150.52",
                              style: TextStyle(
                                color: color2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "In a 2 days",
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
                ),
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
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 8.0),
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
                              color: Colors.grey.shade500,
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

          SliverPadding(
            padding:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 60.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 1),
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
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("assets/e5_$index.png"),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            "Craftwork",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const Text("-150.52"),
                      ],
                    ),
                  );
                },
                childCount: 7,
              ),
            ),
          ),
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
