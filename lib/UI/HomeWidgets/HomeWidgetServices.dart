import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Styles/ButtonStyles.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetServices/BMICalculator.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetServices/BloodPressureCalculator.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetServices/BloodSugarCalculator.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetServices/BodyFatCalculator.dart';

class HomeWidgetServices extends StatelessWidget {
  const HomeWidgetServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Health Services')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: Get.width/2.5,
                height: Get.width/2,
                child: TextButton(
                  style: ButtonStyles.healthServiceButton(Color(0xffFFF2E2)),
                  onPressed: (){
                    Get.to(()=>BMICalculator());
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('BMI Calculator',
                          textAlign: TextAlign.center,
                          style: TypographyStyles.title(16))
                    ],
                  ),
                ),
              ),
              Container(
                width: Get.width/2.5,
                height: Get.width/2,
                child: TextButton(
                  style: ButtonStyles.healthServiceButton(Color(0xffFFE9E9)),
                  onPressed: (){
                    Get.to(()=>BloodPressureCalculator());
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Blood Pressure Calculator',
                          textAlign: TextAlign.center,
                          style: TypographyStyles.title(16))
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: Get.width/2.5,
                height: Get.width/2,
                child: TextButton(
                  style: ButtonStyles.healthServiceButton(Color(0xffE2FFE2)),
                  onPressed: (){
                    Get.to(()=>BodyFatCalculator());
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Body Fat \nCalculator',
                          textAlign: TextAlign.center,
                          style: TypographyStyles.title(16))
                    ],
                  ),
                ),
              ),
              Container(
                width: Get.width/2.5,
                height: Get.width/2,
                child: TextButton(
                  style: ButtonStyles.healthServiceButton(Color(0xffECE9FF)),
                  onPressed: (){
                    Get.to(()=>BloodSugarCalculator());
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Blood Sugar Calculator',
                          textAlign: TextAlign.center,
                          style: TypographyStyles.title(16))
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
