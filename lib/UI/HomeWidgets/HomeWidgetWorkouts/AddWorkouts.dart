import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Styles/Themes.dart';
import 'package:north_star/Styles/TypographyStyles.dart';

class AddWorkouts extends StatelessWidget {
  const AddWorkouts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Schedule'),
        actions: [
          TextButton(onPressed: (){}, child: Text('Save'))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    hintText: 'Schedule Name',
                    label: Text('Schedule Name'),
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                    hintText: 'Schedule Description',
                    label: Text('Schedule Description'),
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: Get.width,
                height: 58,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: Themes().roundedBorder(12),
                      primary: Color(0xFF1C1C1C)),
                  child: Text(
                    'Add Workouts',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  onPressed: () {

                  },
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
