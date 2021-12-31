import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Models/AuthUser.dart';
import 'package:north_star/Styles/ButtonStyles.dart';
import 'package:north_star/Styles/TypographyStyles.dart';

class GymView extends StatelessWidget {
  const GymView({Key? key, this.gymObj}) : super(key: key);

  final gymObj;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gym'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              ListTile(
                  leading: CircleAvatar(
                    radius: 28,
                    child: Text(gymObj['id'].toString()),
                  ),
                  title: Text(gymObj['name'], style: TypographyStyles.title(18)),
                  subtitle: Text(gymObj['email'] + '| Rating ' + gymObj['rating'])
              ),
              SizedBox(height: 32),
              Row(
                children: [
                  SizedBox(width: 16),
                  Icon(Icons.add_location),
                  SizedBox(width: 8),
                  Text(gymObj['countryName'])
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(width: 16),
                  Icon(Icons.phone),
                  SizedBox(width: 8),
                  Text('+91 654 654 654')
                ],
              ),
              SizedBox(height: 32),
              Visibility(
                child: Container(
                  width: Get.width*0.8,
                  height: 56,
                  child: ElevatedButton(
                    style: ButtonStyles.bigBlackButton(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 8),
                        Text('Book Now')
                      ],
                    ),
                    onPressed: (){

                    },
                  ),
                ),
                visible: authUser.role != 'general_user',
              ),
              SizedBox(height: 8),
              Container(
                width: Get.width*0.8,
                height: 56,
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.open_in_new),
                      SizedBox(width: 8),
                      Text('Open In Maps')
                    ],
                  ),
                  onPressed: (){

                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
