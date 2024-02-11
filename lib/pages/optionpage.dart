import 'package:flutter/material.dart';
import 'package:program_ankiety_http/pages/klasa_1.dart';
import '../bgcolor.dart';

import 'anymessagepage.dart';
import 'addusesrpage.dart';

import 'prezentacja.dart';



class OptionScreen extends StatefulWidget {
  final String ip;
  final int port;

  OptionScreen({required this.ip, required this.port});



  @override
  _OptionScreen createState() => _OptionScreen();
}



class _OptionScreen extends State<OptionScreen>{

  @override
  void initState() {
    super.initState();


  }

  void nothing(){

  }


  void gotoAnyMessagePanel() {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnyMessage(ip: widget.ip, port: widget.port),

      ),
    );
  }


  void gotoAddUserPanel(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddUserPage(ip: widget.ip, port: widget.port),

      ),
    );

  }



  void prezentacja(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Prezentacja(ip: widget.ip, port: widget.port),

      ),
    );
  }


  void addGrade(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Klasa1(ip: widget.ip, port: widget.port),

      ),
    );
}






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: userTheme.backGroundColor,
      appBar: AppBar(
        title: Text("Options"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [




            SizedBox(height: 16),
            Align(alignment: Alignment.center,
              child:  Padding(
                  padding:EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: prezentacja,
                    child: Text("Prezentacja",
                        style:TextStyle(fontSize:45,)
                    ),



                  )),
            ),

            SizedBox(height: 16),
            Align(alignment: Alignment.center,
              child:  Padding(
                  padding:EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: addGrade,
                    child: Text("Dodawanie",
                        style:TextStyle(fontSize:45,)
                    ),



                  )),
            ),




          ],
        ),
      ),
    );
  }
}
