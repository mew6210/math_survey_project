import 'package:flutter/material.dart';

class ChartContainer extends StatelessWidget {
  final Color color;

  final String title;
  final Widget chart;



  const ChartContainer({
    Key? key,
    required this.title,
    required this.color,
    required this.chart,





  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        //width: MediaQuery.of(context).size.width * 0.95,
        //height: MediaQuery.of(context).size.width * 0.95 * 0.65,


        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.6,

        padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
        decoration: BoxDecoration(
          color: Color.fromRGBO(232, 226, 226, 0.30196078431372547),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),



            Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  child: chart,
                )),




          ],
        ),
      ),
    );
  }}