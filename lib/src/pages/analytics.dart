import 'package:expense/src/pages/itemWidget.dart';
import 'package:expense/src/resources/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Analytics extends StatefulWidget {
  const Analytics({Key? key}) : super(key: key);

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  late List<Category> _chartData;
  TooltipBehavior _tooltipBehavior = TooltipBehavior();
  @override
  void initState() {
    // TODO: implement initState
    _chartData = getchartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              // child: Text("top section"),
              child: SfCircularChart(
                tooltipBehavior: _tooltipBehavior,
                series: <CircularSeries>[
                  DoughnutSeries<Category,String>(
                    dataSource: _chartData,
                    pointColorMapper: (Category data, _)=>data.color,
                    xValueMapper: (Category data, _)=>data.name,
                    yValueMapper: (Category data, _)=>data.percentage,
                    dataLabelSettings: DataLabelSettings(isVisible: true,),
                    enableTooltip: true
                    ,
                    dataLabelMapper: (Category data, _)=>data.name,
                    innerRadius: '60%'
                  )
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ItemWidget(item: Catalogmodel.products[index]);
                },
                childCount: Catalogmodel.products.length, // 1000 list items
              ),
            ),
          ],
          // ignore: sized_box_for_whitespace
          // child: Column(
          //   children:[
          //   const Text("Helo sir"),
          //     SizedBox(
          //       height: 200,
          //       child: ListView.builder(
          //         itemCount: Catalogmodel.products.length,
          //         itemBuilder:(context,index){
          //           return ItemWidget(item: Catalogmodel.products[index]);
          //         },
          //         ),
          //     ),
          //     SliverList(delegate: delegate)
          //   ]
          // ),
        ),
      ),
    );
  }
  List<Category> getchartData(){
    final List<Category> chartdata = Catalogmodel.products;
    return chartdata;
  }
}