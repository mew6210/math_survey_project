
import 'package:flutter/material.dart';
import '../bgcolor.dart';
import  '../main.dart';
import 'optionpage.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController ipController;
  late TextEditingController portController;






  @override
  void initState() {
    super.initState();
    ipController = TextEditingController();
    portController = TextEditingController();
  }

  void connect() {
    String ip = ipController.text;
    int port = int.tryParse(portController.text) ?? 5055; // Default port is 5055

    Navigator.push(
      context,
      MaterialPageRoute(
        //builder: (context) => MyHomePage(ip: ip, port: port),
        builder: (context) => OptionScreen(ip: ip,port: port),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: userTheme.backGroundColor,
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: ipController,
              decoration: InputDecoration(
                  labelText: "Enter Server IP",
                  hintText:"89.74.117.71",

              ),

            ),
            SizedBox(height: 16),
            TextField(
              controller: portController,
              decoration: InputDecoration(labelText: "Enter Server Port"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: connect,
              child: Text("Connect"),
            ),





          ],
        ),
      ),
    );
  }
}