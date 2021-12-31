import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Models/AuthUser.dart';
import 'package:north_star/Styles/ButtonStyles.dart';
import 'package:north_star/Styles/TypographyStyles.dart';

class TrainerView extends StatelessWidget {
  const TrainerView({Key? key, this.trainerObj}) : super(key: key);

  final trainerObj;

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
                    child: Text(trainerObj['id'].toString()),
                  ),
                  title: Text(trainerObj['name'], style: TypographyStyles.title(18)),
                  subtitle: Text(trainerObj['email'] + ' | Rating ' + trainerObj['rating'])
              ),
              SizedBox(height: 32),
              Row(
                children: [
                  SizedBox(width: 16),
                  Icon(Icons.loyalty),
                  SizedBox(width: 8),
                  Text(trainerObj['categoryName'])
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(width: 16),
                  Icon(Icons.phone),
                  SizedBox(width: 8),
                  Text(trainerObj['mobile_no'])
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
            ],
          ),
        ),
      ),
    );
  }
}
