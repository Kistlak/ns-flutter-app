import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Auth/SignUpClient.dart';
import 'package:north_star/Auth/SignUpDoctor.dart';
import 'package:north_star/Auth/SignUpTrainer.dart';
import 'package:north_star/Styles/TypographyStyles.dart';

class UsertypeSelection extends StatelessWidget {
  const UsertypeSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text('Select your account type'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: Get.width/5,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
                )
              ),
              onPressed: (){
                Get.to(()=>SignUpClient());
              },
              child: Row(
                children: [
                  Icon(Icons.supervised_user_circle, size: 24, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Client', style: TypographyStyles.boldText(21, Colors.white))
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: Get.width/5,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                  )
              ),
              onPressed: (){
                Get.to(()=>SignUpTrainer());
              },
              child: Row(
                children: [
                  Icon(Icons.fitness_center, size: 24, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Trainer', style: TypographyStyles.boldText(21, Colors.white))
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: Get.width/5,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                  )
              ),
              onPressed: (){
                Get.to(()=>SignUpDoctor());
              },
              child: Row(
                children: [
                  Icon(Icons.medical_services, size: 24, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Doctor', style: TypographyStyles.boldText(21, Colors.white))
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
