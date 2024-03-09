// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:e_commerce/screens/Rewards/model/chartmodel.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RewardsCircle extends StatelessWidget {
  List<ChartData> chartData = [];

  RewardsCircle(this.chartData);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.w < 500 ? 70.w : 35.w,
      width: 100.w < 500 ? 70.w : 35.w,
      child: SfCircularChart(
        series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(
            innerRadius: '60%',
            dataSource: chartData,
            pointColorMapper: (ChartData data, _) => data.color,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
          ),
        ],
      ),
    );
  }
}
