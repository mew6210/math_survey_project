
import 'dart:core';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:program_ankiety_http/randomcolor.dart';
import 'package:program_ankiety_http/theme.dart';
import 'package:program_ankiety_http/consts.dart';
import 'package:program_ankiety_http/chart/indicator.dart';





List<Color> gradientColors (){


  List<Color> l=[  usertheme.color1,
    usertheme.color2,
    usertheme.color3,
    usertheme.color4,
    usertheme.color5,
    usertheme.color6,
    usertheme.color7,
    usertheme.color8,
    usertheme.color9,
    usertheme.color10,
  ];


  return l;
}









extension EnhancedMap<K, V> on Map<K, V> {
  V? getOrDefaultOrNull(K key) {
    if (!containsKey(key)) {
      return null;
    }

    return this[key];
  }
}



List<PieChartSectionData> GetValues(List<int> valueTable,double screenWidth) {
  int tableLength = valueTable.length;

  double radius = screenWidth / 4.44;
  late List<PieChartSectionData> list = [];

  late Map<int, int> occurrenceMap = {};

  for (int grade in valueTable) {
    int? count = occurrenceMap.getOrDefaultOrNull(grade) ?? 0;
    count=(count!+1) ?? 0;
    occurrenceMap[grade] = count ?? 0;
  }




  occurrenceMap.forEach((key, value) {
    double? doulekey=value/tableLength;
    double percent=doulekey*100;
    String percentasString=percent.toStringAsFixed(2);
    double actualpercent=double.parse(percentasString);

    Color definedcolor;
    /*
    switch(key){
      case 1: definedcolor=Color.fromRGBO(255, 0, 22, 1.0); break;
      case 2: definedcolor=Color.fromRGBO(200, 0, 255, 1.0); break;
      case 3: definedcolor=Color.fromRGBO(79, 109, 252, 1.0); break;
      case 4: definedcolor=Color.fromRGBO(0, 228, 255, 1.0); break;
      case 5: definedcolor=Color.fromRGBO(0, 255, 129, 1.0); break;
      case 6: definedcolor=Color.fromRGBO(137, 255, 0, 1.0); break;
      case 7: definedcolor=Color.fromRGBO(200, 255, 0, 1.0); break;
      case 8: definedcolor=Color.fromRGBO(255, 131, 0, 1.0); break;
      case 9: definedcolor=Color.fromRGBO(255, 0, 211, 1.0); break;
      case 10: definedcolor=Color.fromRGBO(0, 189, 255, 1.0); break;
      default: definedcolor=getRandomColor(); break;
    }


     */


    Themeown theme=usertheme;
    switch(key){
      case 1: definedcolor=theme.color1; break;
      case 2: definedcolor=theme.color2; break;
      case 3: definedcolor=theme.color3; break;
      case 4: definedcolor=theme.color4; break;
      case 5: definedcolor=theme.color5; break;
      case 6: definedcolor=theme.color6; break;
      case 7: definedcolor=theme.color7; break;
      case 8: definedcolor=theme.color8; break;
      case 9: definedcolor=theme.color9; break;
      case 10: definedcolor=theme.color10; break;
      default: definedcolor=getRandomColor(); break;
    }

    list.add(PieChartSectionData(

      value: doulekey,
      title: '${key}($actualpercent%)',
      titleStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
      radius: radius,
      color: definedcolor,


    ));
  });


  return list;

  }





List<PieChartSectionData> getSectionData(double screenWidth,List<int> valueTable) {

  List<PieChartSectionData> list=GetValues(valueTable,screenWidth);



  return list;
}







List<BarChartGroupData> getBarChartValues(List<int> valuetable) {
  List<BarChartGroupData> barChartValues = [];

  for (int grade = 1; grade <= 10; grade++) {
    int occurrences = valuetable.where((element) => element == grade).length;
    barChartValues.add(generateGroupData(grade, occurrences));
  }

  return barChartValues;
}




BarChartGroupData generateGroupData(int x, int y) {
  List<Color> gradientcolors=gradientColors();
  return BarChartGroupData(
    x: x,

    barRods: [
      BarChartRodData(toY: y.toDouble(),
        color: gradientcolors[x-1],


      ),

    ],
  );
}




List<BarChartGroupData> getBarChartData(List<int> valuetable){

  List<BarChartGroupData> list=getBarChartValues(valuetable);



  return list;
}





double calculateMaxY(List<int> valuetable) {
  Map<int, int> occurrencesMap = {};

  // Count occurrences of each grade
  for (int grade in valuetable) {
    int count = occurrencesMap.containsKey(grade) ? occurrencesMap[grade]! + 1 : 1;
    occurrencesMap[grade] = count;
  }

  // Find the grade with the highest occurrence
  int maxGrade = occurrencesMap.keys.reduce((a, b) => occurrencesMap[a]! > occurrencesMap[b]! ? a : b);

  // Get the maximum occurrences (y) for the most frequent grade
  int maxOccurrences = occurrencesMap[maxGrade] ?? 0;

  // Add 2 to the maximum occurrences to set maxY
  double maxY = (maxOccurrences + 2).toDouble();

  return maxY;
}





List<LineChartBarData> getLineBarsData(List<int> valueTable){



  List<LineChartBarData> l=lol(valueTable);


  return l;


}



List<LineChartBarData> lol(valueTable){
  List<Color> gradientcolors=gradientColors();
  List<LineChartBarData> datalist=[];


  Map<int, int> occurrencesMap = {};

  // Count occurrences of each grade
  for (int grade in valueTable) {
    int count = occurrencesMap.containsKey(grade) ? occurrencesMap[grade]! + 1 : 1;
    occurrencesMap[grade] = count;
  }

  List<FlSpot> spots = [];

  // Populate spots list with x and y values from occurrencesMap
  for (int i = 1; i <= 10; i++) {
    int yValue = occurrencesMap.containsKey(i) ? occurrencesMap[i]! : 0;
    spots.add(FlSpot(i.toDouble(), yValue.toDouble()));
  }

  // Add LineChartBarData with spots populated
  datalist.add(LineChartBarData(
    spots: spots,

    gradient: LinearGradient(
      colors:
       gradientcolors.map((color)=>color.withOpacity(1)).toList(),


    ),
    belowBarData: BarAreaData(
      show:true,
      gradient:LinearGradient(
        colors:gradientcolors.map((color)=>color.withOpacity(0.3)).toList(),
      )
    )
  ));







  return datalist;



}






