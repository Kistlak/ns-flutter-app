import 'package:flutter/material.dart';
import 'package:north_star/Styles/ButtonStyles.dart';
import 'package:north_star/Styles/TypographyStyles.dart';

Widget homeWidgetButton(Function goTo, String icon, String text){
  return Column(
    children: [
      Container(
        height: 96,
        width: 96,
        child: ElevatedButton(
          style: ButtonStyles.homeBtn(),
          onPressed: (){
            goTo();
          },
          child: Image.asset('assets/icons/$icon.png'),
        ),
      ),
      SizedBox(height: 8),
      Text(text,style: TypographyStyles.boldText(14, Colors.black),)
    ],
  );
}
