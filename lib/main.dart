
import 'package:flutter/material.dart';

import  'pages/loginpage.dart';

const int HEADER = 64;
const String FORMAT = "utf-8";
const String DISCONNECT_MESSAGE = "!DISCONNECT";




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}




