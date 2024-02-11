import 'package:flutter/material.dart';
import 'dart:math';





Color getRandomColor(){
  late Color finalcolor=Color.fromRGBO(Random().nextInt(255),Random().nextInt(255),Random().nextInt(255), 1);
  return finalcolor;
}




