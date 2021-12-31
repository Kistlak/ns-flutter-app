import 'package:flutter/material.dart';
import 'package:north_star/Styles/Themes.dart';

class ButtonStyles{

  static ButtonStyle homeBtn(){
    return ElevatedButton.styleFrom(
        onPrimary: Themes.mainThemeColor,
        primary: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(27)
        )
    );
  }

  static ButtonStyle flatButton(){
    return ElevatedButton.styleFrom(
        onPrimary: Colors.black,
        primary: Color(0xFFF6F6F6),
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
        )
    );
  }

  static ButtonStyle healthServiceButton(Color color){
    return ElevatedButton.styleFrom(
        onPrimary: Colors.black,
        primary: color,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
        )
    );
  }

  static ButtonStyle bigBlackButton(){
    return ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        primary: Colors.black,
        elevation: 6,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
        )
    );
  }

  static ButtonStyle bigFlatBlackButton(){
    return ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        primary: Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(4),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(4)
            )
        )
    );
  }

  static ButtonStyle bigFlatSearchBlackButton(){
    return ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        primary: Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(4),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(4)
            )
        )
    );
  }
}
