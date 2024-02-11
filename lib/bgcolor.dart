import 'package:flutter/material.dart';


class Theme{

late Color backGroundColor;

Theme(){

  backGroundColor=Colors.white;

}

Color initializeColor(String s){

  late Color result;

  switch(s){
  //add colors here
    case "green": result=Colors.green;  break;
    case "red": result=Colors.red;  break;
    case "blue": result=Colors.blue;  break;
    case "pink": result=Colors.pink;  break;




    default: result=Colors.white;  break;
  }



  return result;
}

void assignBgColor(String s){
 backGroundColor=initializeColor(s);
}

}

late Theme userTheme=Theme();




