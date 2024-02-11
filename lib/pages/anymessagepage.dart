import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:program_ankiety_http/bgcolor.dart';
import 'package:program_ankiety_http/main.dart';


class AnyMessage extends StatefulWidget {
  final String ip;
  final int port;

  AnyMessage({required this.ip, required this.port});

  @override
  _AnyMessage createState() => _AnyMessage();
}

class _AnyMessage extends State<AnyMessage> {
  late Socket client;
  late TextEditingController messageController;
  late TextEditingController secondMessageController;
  bool isConnected = false;
  StreamSubscription<List<int>>? _socketSubscription;
  List<String> messages = [];
  late String latestMessage;





  @override
  void initState() {
    super.initState();
    secondMessageController = TextEditingController();
    messageController = TextEditingController();

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
            latestMessage=receivedMessage;
            userTheme.assignBgColor(latestMessage);
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

  void sendJsonThingy() {
    String userInput1 = messageController.text;
    String userInput2 = secondMessageController.text;
    Map<String, dynamic> user = {'name': userInput1, 'age': userInput2};
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
        title: Text("Chat App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (isConnected)
              TextField(
                controller: messageController,
                decoration: InputDecoration(labelText: "Enter your name"),
              ),
            TextField(
              controller: secondMessageController,
              decoration: InputDecoration(labelText: "Enter your age"),
            ),

            SizedBox(height: 16),
            ElevatedButton(
              onPressed: sendJsonThingy,
              child: Text("Send"),
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