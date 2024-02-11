import 'package:fl_chart/fl_chart.dart';
import  'package:program_ankiety_http/chart_data/pie_chart_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class PieChartContent extends StatelessWidget {

   final Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };

  final List<int> valueTable;

  PieChartContent({
    Key? key,

    required this.valueTable,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PieChart(

        PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 0,
        startDegreeOffset: 255,
        sections: getSectionData(MediaQuery.of(context).size.width*0.4,valueTable)


    ),

    swapAnimationDuration: Duration(milliseconds:200),
      swapAnimationCurve: Curves.linear,

    );
  }
}







BarChartGroupData generateGroupData(int x, int y) {
  return BarChartGroupData(
    x: x,

    barRods: [
      BarChartRodData(toY: y.toDouble()),
    ],
  );
}





class BarChartContent extends StatelessWidget {




  final Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };

  final List<int> valueTable;

  BarChartContent({
    Key? key,

    required this.valueTable,

  }) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return BarChart(

        BarChartData(
            maxY: calculateMaxY(valueTable),       //get dynamically
            barGroups: getBarChartData(valueTable),

            //sections: getSectionData(MediaQuery.of(context).size.width,valueTable)


          titlesData: const FlTitlesData(
            show: true,
            topTitles: AxisTitles(
            sideTitles: SideTitles(interval:1)

            ),




            leftTitles: AxisTitles(

              sideTitles: SideTitles(interval: 1,reservedSize: 24)
            ),

            rightTitles: AxisTitles(

              sideTitles: SideTitles(interval: 1,showTitles: true,reservedSize: 24),





          )



          )



            )
    );

  }
}