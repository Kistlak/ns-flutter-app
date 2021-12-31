import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Styles/ButtonStyles.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetDoctors/Doctors_List.dart';

class Doctors extends StatelessWidget {
  const Doctors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(width: 32),
              Icon(Icons.person),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Doctors',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(32),
            child: Image.asset('assets/images/undraw_medicine_b1ol.png'),
          ),
          Text('Channel a Doctor just in\nthree taps!', style: TypographyStyles.title(24), textAlign: TextAlign.center,),
          SizedBox(height: 32),
          Container(
            width: Get.width*0.8,
            height: 56,
            child: ElevatedButton(
              style: ButtonStyles.bigBlackButton(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.video_call),
                  SizedBox(width: 8),
                  Text('Book Now')
                ],
              ),
              onPressed: (){
                Get.to(()=>DoctorsList());
              },
            ),
          )
        ],
      ),
    );
  }
}
