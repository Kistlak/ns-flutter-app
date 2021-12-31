import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Models/AuthUser.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetCalories.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetGym.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetMeasurements.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetResources.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetSchedules.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetServices.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetSlots.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetStore.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetTrainers.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetWorkouts.dart';
import 'package:north_star/UI/SharedWidgets/HomeWidgetButton.dart';
import 'package:north_star/UI/Wallet.dart';

import 'HomeWidgets/HomeWidgetDoctors.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print(authUser.role);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 256,
              width: Get.width,
              child: PageView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset('assets/images/demo_ad_1.png',
                      fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset('assets/images/demo_ad_2.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            authUser.role == 'general_user' ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                homeWidgetButton((){
                  Get.to(()=>HomeWidgetGym());
                },'Gyms','Gyms'),
                homeWidgetButton((){
                  Get.to(()=>HomeWidgetTrainers());
                },'settings','Trainers'),
                homeWidgetButton((){
                  Get.to(()=>HomeWidgetStore());
                },'settings','Store'),
              ],
            ) : Container(),
            authUser.role == 'general_user' ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                homeWidgetButton((){
                },'settings','Settings'),
              ],
            ) : Container(),

            authUser.role == 'trainer' ? Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    homeWidgetButton((){
                      Get.to(()=>HomeWidgetCalories());
                    },'Calories','Calories'),
                    homeWidgetButton((){
                      Get.to(()=>HomeWidgetWorkouts());
                    },'Workouts','Workouts'),
                    homeWidgetButton((){
                      Get.to(()=>HomeWidgetSchedules());
                    },'Schedule','Schedule'),
                  ],
                )
            ): SizedBox(),
            authUser.role == 'trainer' ? Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    homeWidgetButton((){
                      Get.to(()=>HomeWidgetMeasurement());
                    },'Slots','Measurements'),
                    homeWidgetButton((){
                      Get.to(()=>Doctors());
                    },'Doctors','Doctors'),
                    homeWidgetButton((){
                      Get.to(()=>HomeWidgetGym());
                    },'Gyms','Gym'),
                  ],
                )
            ): SizedBox(),
            authUser.role == 'trainer' ? Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    homeWidgetButton((){
                      Get.to(()=>HomeWidgetResources());
                    },'Resources','Resources'),
                    homeWidgetButton((){
                      Get.to(()=>HomeWidgetServices());
                    },'HealthService','Health Services'),
                    homeWidgetButton((){

                    },'VideoSession','Video Sessions'),
                  ],
                )
            ): SizedBox(),
            authUser.role == 'trainer' ? Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    homeWidgetButton((){
                      Get.to(()=>HomeWidgetStore());
                    },'settings','Store'),
                    homeWidgetButton((){
                      Get.to(()=>HomeWidgetSlots());
                    },'Slots','Slots'),
                    homeWidgetButton((){
                    },'settings','Settings'),
                  ],
                )
            ): SizedBox(),

            authUser.role == 'client' ? Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    homeWidgetButton((){
                      Get.to(()=>HomeWidgetWorkouts());
                    },'Workouts','Workouts'),
                    homeWidgetButton((){
                      Get.to(()=>Doctors());
                    },'Doctors','Doctors'),
                    homeWidgetButton((){
                      Get.to(()=>HomeWidgetSchedules());
                    },'Schedule','Schedule'),
                  ],
                )
            ): SizedBox(),
            authUser.role == 'client' ? Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    homeWidgetButton((){
                      Get.to(()=>HomeWidgetTrainers());
                    },'settings','Trainers'),
                    homeWidgetButton((){
                      Get.to(()=>HomeWidgetResources());
                    },'Resources','Resources'),
                    homeWidgetButton((){
                      Get.to(()=>Wallet());
                    },'eWallet','eWallet'),
                  ],
                )
            ): SizedBox(),
            authUser.role == 'client' ? Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    homeWidgetButton((){
                      Get.to(()=>HomeWidgetStore());
                    },'settings','Store'),
                    homeWidgetButton((){
                    },'settings','Settings'),
                  ],
                )
            ): SizedBox(),
          ],
        ),
      ),
    );
  }
}
