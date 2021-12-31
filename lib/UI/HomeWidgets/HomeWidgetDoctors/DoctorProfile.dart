
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Models/AuthUser.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/ButtonStyles.dart';
import 'package:north_star/Styles/Themes.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetDoctors/ScheduleForClient.dart';

import 'ScheduleForMe.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({Key? key, this.doctor}) : super(key: key);

  final doctor;
  static String placeholder =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.';
  static String placeholder2 =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';

  @override
  Widget build(BuildContext context) {
    void showSelection(){
      Get.defaultDialog(
          radius: 8,
          title: 'Select an Option',
          content: Column(
            children: [
              ListTile(
                onTap: (){

                },
                title: Row(
                  children: [
                    Text('Start an Instant Meeting')
                  ],
                ),
              ),
              ListTile(
                onTap: (){
                  Get.back();
                  Get.to(()=>ScheduleForMe(doctor: doctor));
                },
                title: Row(
                  children: [
                    Text('Schedule Appointment for me')
                  ],
                ),
              ),
              Visibility(
                child: ListTile(
                  onTap: (){
                    Get.back();
                    Get.to(()=>ScheduleForClient(doctor: doctor));
                  },
                  title: Row(
                    children: [
                      Text('Schedule Appointment for Client')
                    ],
                  ),
                ),
                visible: authUser.role == 'trainer',
              )
            ],
          )
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 16),
                CircleAvatar(radius: 48),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor['name'],
                      style:
                          TypographyStyles.boldText(16, Themes.mainThemeColor),
                    ),
                    Text(
                      doctor['name'],
                      style: TypographyStyles.boldText(18, Colors.black),
                    ),
                    Text(
                      doctor['name'],
                      style: TypographyStyles.boldText(14, Colors.grey),
                    ),
                  ],
                )
              ],
            ),
            Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About', style: TypographyStyles.title(20)),
                  SizedBox(height: 16),
                  Text('Qualifications', style: TypographyStyles.title(20)),
                  SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.ac_unit, size: 21),
                          SizedBox(width: 8),
                          Text('2015', style: TypographyStyles.title(18)),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(placeholder2,
                                textAlign: TextAlign.justify),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Channel Dr. ' + doctor['name'].split(' ')[0],
                    style: TypographyStyles.title(20),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                child: Container(
                  width: Get.width,
                  height: 56,
                  child: ElevatedButton(
                    style: ButtonStyles.bigBlackButton(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.video_call),
                        SizedBox(width: 8),
                        Text('Channel')
                      ],
                    ),
                    onPressed: (){
                      showSelection();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
