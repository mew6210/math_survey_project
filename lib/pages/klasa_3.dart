import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:program_ankiety_http/bgcolor.dart';
import 'package:program_ankiety_http/main.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:program_ankiety_http/chart/pie_chart.dart';
import '../chart_container.dart';




class Klasa3 extends StatefulWidget {
  final String ip;
  final int port;
  final String JSONpurpose="survey";

  Klasa3({required this.ip, required this.port});

  @override
  _Klasa3 createState() => _Klasa3();
}

class _Klasa3 extends State<Klasa3> {
  late Socket client;
  late TextEditingController messageController;
  late TextEditingController secondMessageController;
  late TextEditingController thirdMessageController;
  bool isConnected = false;
  StreamSubscription<List<int>>? _socketSubscription;
  List<String> messages = [];


  List<int> valueTable = [];



  @override
  void initState() {
    super.initState();
    secondMessageController = TextEditingController();
    messageController = TextEditingController();
    thirdMessageController = TextEditingController();
    connectToServer();
  }

  void connectToServer() async {
    try {
      client = await Socket.connect(widget.ip, widget.port);

      _socketSubscription = client.listen(
            (List<int> event) {
          String receivedMessage = utf8.decode(event);


          try {
            // Parse the received message into a JSON object
            var jsonData = jsonDecode(receivedMessage);

            // Check if the JSON object has a "purpose" field and its value is "sendingGrades"
            if (jsonData.containsKey('purpose') &&
                jsonData['purpose'] == 'sendingGrades') {


              var tagsJson = jsonDecode(receivedMessage)['grades'];
              List<String>? tags = tagsJson != null ? List.from(tagsJson) : null;



              for(String tag in tags!){
                int tag_int=int.parse(tag);
                valueTable.add(tag_int);

              }





              print('Received sendingGrades message');
            }

          } catch (e) {
            print('Failed to parse JSON: $e');
          }


          print(receivedMessage);
          setState(() {
            messages.add("'"+receivedMessage+"'");


          });
        },
        onDone: () {
          print('Socket closed');
          setState(() {
            isConnected = false;
          });
        },
        onError: (error) {
          print('Socket error: $error');
        },
        cancelOnError: true,
      );

      setState(() {
        isConnected = true;
      });
    } catch (e) {
      print("Failed to connect: $e");
    }
  }

  void clearInputs(){
    messageController.clear();
    secondMessageController.clear();
    thirdMessageController.clear();
    FocusScope.of(context).unfocus();

  }

  void askForGrades(){
    String userInput1 = messageController.text;


    clearInputs();

    Map<String, dynamic> user = {
      "purpose": "askforgrades",
      "class": 3,


    };



    String jsonEncoded = jsonEncode(user);
    send(client, jsonEncoded);

  }
  void sendGrade() {
    String userInput1 = messageController.text;


    clearInputs();

    Map<String, dynamic> user = {
     "purpose": widget.JSONpurpose,
      "class": 3,
      "grade": userInput1


    };



    String jsonEncoded = jsonEncode(user);
    send(client, jsonEncoded);
  }

  void sendMessage() {
    if (!isConnected) return; // Do nothing if not connected

    String userInput = messageController.text;
    if (userInput == DISCONNECT_MESSAGE) {
      disconnect();
      return;
    }

    send(client, userInput);
    messageController.clear();
  }

  void send(Socket socket, String msg) {
    List<int> message = utf8.encode(msg);
    int msgLength = message.length;
    String sendLength = msgLength.toString();

    socket.write(sendLength);
    socket.add(message);

    bool isSocketClosed = false;

    socket.listen(
          (List<int> event) {
        print(utf8.decode(event));
      },
      onDone: () {
        if (!isSocketClosed) {
          print('Socket closed');
          setState(() {
            isConnected = false;
          });
        }
      },
      onError: (error) {
        print('Socket error: $error');
      },
      cancelOnError: true,
    );

    socket.done.then((_) {
      isSocketClosed = true;
      _socketSubscription?.cancel();
    });
  }

  void disconnect() {
    send(client, DISCONNECT_MESSAGE);
    client.close();
    Navigator.pop(context); // Go back to the login screen
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: userTheme.backGroundColor,
      appBar: AppBar(
        title: Text("Klasa 3"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (isConnected)
              TextField(
                controller: messageController,
                decoration: InputDecoration(labelText: "Ocena: "),
                keyboardType: TextInputType.number,
              ),


            SizedBox(height: 16),
            ElevatedButton(
              onPressed: sendGrade,
              child: Text("Dodaj ocene"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: disconnect,
              child: Text("Disconnect"),
            ),
            SizedBox(height: 16),


            Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(

                  onPressed: askForGrades,
                  child:

                  Icon(Icons.refresh),

                )),


            ChartContainer(title: 'Pie Chart', color: Color(0xfff0f0f0), chart: PieChartContent(valueTable: valueTable,))


            /*
            // Add a ListView to display received messages
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


          ],
        ),
      ),
    );
  }
}