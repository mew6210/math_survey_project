import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:program_ankiety_http/bgcolor.dart';
import 'package:program_ankiety_http/main.dart';





class AddUserPage extends StatefulWidget {
  final String ip;
  final int port;
  final String JSONpurpose="adduser";

  AddUserPage({required this.ip, required this.port});

  @override
  _AddUserPage createState() => _AddUserPage();
}

class _AddUserPage extends State<AddUserPage> {
  late Socket client;
  late TextEditingController messageController;
  late TextEditingController secondMessageController;
  late TextEditingController thirdMessageController;
  bool isConnected = false;
  StreamSubscription<List<int>>? _socketSubscription;
  List<String> messages = [];






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


  void sendAddUserJSON() {
    String userInput1 = messageController.text;
    String userInput2 = secondMessageController.text;
    String userInput3 = thirdMessageController.text;

    clearInputs();

    Map<String, dynamic> user = {
      'purpose': widget.JSONpurpose,
      'name': userInput1,
      'age': userInput2,
      'password': userInput3};



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
        title: Text("Add User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (isConnected)
              TextField(
                controller: messageController,
                decoration: InputDecoration(labelText: "Enter your name"),
                keyboardType: TextInputType.text,
              ),
            TextField(
              controller: secondMessageController,
              decoration: InputDecoration(labelText: "Enter your age"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: thirdMessageController,
              decoration: InputDecoration(labelText: "Enter your password"),
              keyboardType: TextInputType.visiblePassword,
            ),



            SizedBox(height: 16),
            ElevatedButton(
              onPressed: sendAddUserJSON,
              child: Text("Send user to db"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: disconnect,
              child: Text("Disconnect"),
            ),
            SizedBox(height: 16),




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



          ],
        ),
      ),
    );
  }
}