import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:north_star/Models/AuthUser.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/ButtonStyles.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:north_star/Utils/PopUps.dart';
import 'package:uuid/uuid.dart';

class ScheduleForMe extends StatelessWidget {
  const ScheduleForMe({Key? key, this.doctor}) : super(key: key);

  final doctor;

  @override
  Widget build(BuildContext context) {
    RxBool ready = true.obs;

    Rx<DateTime> date = new DateTime.now().add(Duration(days: 5)).obs;
    Rx<TimeOfDay> time = new TimeOfDay.now().obs;
    TextEditingController dateController = new TextEditingController(text: DateTime.now().toString().split(' ')[0]);
    TextEditingController timeController = new TextEditingController(
      text: TimeOfDay.now().hour.toString() + ':' + TimeOfDay.now().minute.toString()
    );
    TextEditingController descriptionController = new TextEditingController();

    void pickDateDialog() {
      showDatePicker(
          context: context,
          initialDate: date.value,
          firstDate: DateTime.now().add(Duration(days: 2)),
          lastDate: DateTime(2100),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: const Color(0xFFF1AB56),
                colorScheme:
                ColorScheme.light(primary: const Color(0xFFF1AB56)),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          }).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        date.value = pickedDate;
        dateController.text = pickedDate.toString().split(' ')[0];
      });
    }
    void pickTimeDialog() {
      showTimePicker(
          context: context,
          initialTime: time.value,
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: const Color(0xFFF1AB56),
                colorScheme:
                ColorScheme.light(primary: const Color(0xFFF1AB56)),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          }).then((pickedTime) {
        if (pickedTime == null) {
          return;
        }
        time.value = pickedTime;
        timeController.text = pickedTime.hour.toString() + ':' + pickedTime.minute.toString();
      });
    }

    void scheduleMeeting() async{
      var uuid = Uuid();
      print('Scheduling meeting');
      ready.value = false;
      var request = http.MultipartRequest(
          'POST', Uri.parse(HttpClient.healthBaseURL + '/api/trainerselectuserdoctorappoinment'));
      request.headers.addAll(client.getHeader());

      request.fields.addAll({
        'doctors_id': doctor['id'].toString(),
        'date': dateController.text,
        'time': timeController.text,
        'doctor_specification': doctor['categoryName'],
        'language': 'en',
        'description': descriptionController.text,
        'link': 'https://meet.jit.si/' + uuid.v1(),
        'trainer_user_id': authUser.id.toString(),
      });

      print(authUser.roleId);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        var res = jsonDecode(await response.stream.bytesToString());
        showSnack('Success!', 'Meeting Scheduled!');
        print(res);
        ready.value = true;
      } else {
        print(await response.stream.bytesToString());
        ready.value = true;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule for me'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Divider(),
              Text('Dr. ' + doctor['name'], style: TypographyStyles.title(18)),
              Divider(),
              Text('Appointment for You', style: TypographyStyles.title(18)),
              SizedBox(height: 16),
              TextField(
                onTap: () {
                  pickDateDialog();
                },
                controller: dateController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.calendar_today),
                  labelText: 'Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                onTap: () {
                  pickTimeDialog();
                },
                controller: timeController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.timer),
                  labelText: 'Time',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                minLines: 3,
                maxLines: 3,
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: Get.width,
                height: 56,
                child: Obx(()=>ElevatedButton(
                  style: ButtonStyles.bigBlackButton(),
                  child: ready.value ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.video_call),
                      SizedBox(width: 8),
                      Text('Schedule Meeting')
                    ],
                  ): Center(
                    child: CircularProgressIndicator(),
                  ),
                  onPressed: (){
                    if(descriptionController.text.isNotEmpty){
                      scheduleMeeting();
                    } else {
                      showSnack('Description is empty!', 'please add a description about the meeting');
                    }
                  },
                )),
              )
            ],
          ),
        ),
      ),

    );
  }
}
