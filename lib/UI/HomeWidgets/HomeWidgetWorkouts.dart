import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Styles/ButtonStyles.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetWorkouts/AddWorkouts.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetWorkouts/GymWorkouts.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetWorkouts/Schedules.dart';

class HomeWidgetWorkouts extends StatelessWidget {
  const HomeWidgetWorkouts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workouts'),),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 64,
            child: ElevatedButton(
              style: ButtonStyles.flatButton(),
              onPressed: (){
                Get.to(()=>GymWorkouts());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.handyman),
                  Text('Gym Workouts')
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 64,
            child: ElevatedButton(
              style: ButtonStyles.flatButton(),
              onPressed: (){
                Get.to(()=>Schedules());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.watch_later),
                  Text('Schedules')
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Divider(),
          Text('Custom Schedules', style: TypographyStyles.title(21)),
          SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (_,index){
                return Container(
                  padding: const EdgeInsets.all(8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Schedule $index',style: TypographyStyles.title(18),),
                          Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
                          SizedBox(height: 8),
                          Text('Oct 25 2021 | Trainer Name')
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
