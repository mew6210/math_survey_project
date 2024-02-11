import 'dart:async';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:program_ankiety_http/bgcolor.dart';
import 'package:http/http.dart' as http;









class Klasa1 extends StatefulWidget {
  final String ip;
  final int port;
  final String JSONpurpose="survey";

  Klasa1({required this.ip, required this.port});

  @override
  _Klasa1 createState() => _Klasa1();
}



class _Klasa1 extends State<Klasa1> {
  late Socket client;
  late TextEditingController messageController;
  late TextEditingController secondMessageController;
  late TextEditingController thirdMessageController;
  bool isConnected = false;
  StreamSubscription<List<int>>? _socketSubscription;
  List<String> messages = [];
  late int klasa=1;



  List<int> valueTable = [];



  @override
  void initState() {
    super.initState();
    secondMessageController = TextEditingController();
    messageController = TextEditingController();
    thirdMessageController = TextEditingController();

  }


  void clearInputs(){
    messageController.clear();
    secondMessageController.clear();
    thirdMessageController.clear();
    FocusScope.of(context).unfocus();

  }


void submitGrade () async{

  String login=widget.ip;
  String port=widget.port.toString();

  String baseUrl = "http://$login:$port";



  String url = baseUrl + "/grades";
  var postData = {"class": klasa.toString(), "grade": messageController.text};

  var response = await http.post(
    Uri.parse(url),
    body: postData,
  );





  String responsebody=response.body;



  print(responsebody);

  clearInputs();

}






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: userTheme.backGroundColor,
      appBar: AppBar(
        title: Text("Dodawanie"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [



          Text("klasa: "),
          DropdownButton<int>(
              value: klasa,
              onChanged: (int? newValue) {
                setState(() {
                  // Update the external variable when a new value is selected
                  klasa = newValue!;

                });
              },
              items: <int>[1, 2, 3, 4, 5]
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              ),




            SizedBox(height:16),
            TextField(
              controller: messageController,
              decoration: InputDecoration(labelText: "Ocena: ",hintText: "1-10"),
              keyboardType: TextInputType.number,

            ),


            SizedBox(height: 16),

            Align(
              child: ElevatedButton(
                onPressed: submitGrade,
                child: Text("Dodaj ocene"),
              ),
              alignment: Alignment.center,
            ),

            SizedBox(height: 16),

            SizedBox(height: 16),







]





              )





            ),




            // Add a ListView to display received messages
            /*
            Expanded(

              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(), // Unique key for each message
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      // Remove the dismissed message from the list
                      messages.removeAt(index);
                      setState(() {

                      });
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: ListTile(
                      title: Text(messages[index]),
                    ),
                  );
                },
              ),
            ),
            */









    );
  }
}