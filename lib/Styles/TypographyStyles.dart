import 'package:flutter/cupertino.dart';

class TypographyStyles {

  static TextStyle normalText(int size, Color color){
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: size.toDouble(),
      color: color,
    );
  }

  static TextStyle boldText(int size, Color color){
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: size.toDouble(),
      color: color,
    );
  }

  static TextStyle title(int size){
    return TextStyle(
        fontSize: size.toDouble(),
        fontWeight: FontWeight.bold
    );
  }

  static TextStyle text(int size){
    return TextStyle(
        fontSize: size.toDouble(),
        fontWeight: FontWeight.normal
    );
  }

  static TextStyle walletTransactions(int size, int type){
    return TextStyle(
        fontSize: size.toDouble(),
        fontWeight: FontWeight.bold,
        color: type == 0 ? Color(0xff02B88D):  Color(0xffDB1E00)
    );
  }
}
