import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:north_star/Models/AuthUser.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomeWidgetSchedules extends StatelessWidget {
  const HomeWidgetSchedules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool ready = false.obs;
    RxList list = [].obs;

    void getScheduled() async{
      ready.value = false;
      var request = http.Request('GET', Uri.parse(HttpClient.healthBaseURL +'/api/userupcominappoinment'));
      request.body = json.encode({
        "user_id": authUser.id
      });
      request.headers.addAll(client.getHeader());
      //print(authUser.roleId);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = jsonDecode(await response.stream.bytesToString());
        print(res);
        list.value = res['UserUpcominAppoinment'];
        ready.value = true;
      } else {
        print(await response.stream.bytesToString());
        ready.value = true;
      }
    }

    List getEventsForDay(DateTime day) {
      String dtString = day.toString().split(' ')[0];

      List events = [];
      list.forEach((element) {
        /*print(element['commondata']['date'].toString().replaceAll('\n','').replaceAll(' ', ''));
        print(dtString);*/
        if (element['UserUpcominAppoinment']['date'].toString().replaceAll('\n','').replaceAll(' ', '') == dtString) {
          events.add(element);
          print('Has Event');
        }
      });
      return events;
    }

    getScheduled();

    return Scaffold(
      appBar: AppBar(title: Text('Schedules')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Upcoming Schedules', style: TypographyStyles.title(21)),
            ),
            Container(
              width: Get.width,
              height: Get.width/2,
              child: Obx(()=>ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (_,index){
                  return upComingCard(list[index]['UserUpcominAppoinment']['date'],
                      list[index]['UserUpcominAppoinment']['get_doctor_details']['name']
                      ,  list[index]['UserUpcominAppoinment']['time'],
                      list[index]['UserUpcominAppoinment']['link']
                  );
                },
              )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Calender', style: TypographyStyles.title(21)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(()=>ready.value ? TableCalendar(
              onFormatChanged: (val){},
              startingDayOfWeek: StartingDayOfWeek.monday,
              firstDay: DateTime.utc(2021, 1, 1),
              lastDay: DateTime.utc(2025, 12, 31),
              focusedDay: DateTime.now(),
              eventLoader: (day) {
                return getEventsForDay(day);
              },
            ): Center(
                child: CircularProgressIndicator(),
              )),
            ),
          ],
        ),
      )
    );
  }
}


Widget upComingCard(String month, String doctor, String time, String link){
  return Container(
    width: Get.width/1.5,
    child: Card(
      margin: const EdgeInsets.all(16),
      color: Color(0xffE8F5FF),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(month, style: TypographyStyles.title(18)),
                Text(time, style: TypographyStyles.title(16)),
                Row()
              ],
            ),
            Row(
              children: [
                ElevatedButton(onPressed: (){
                  final Uri meeting = Uri.parse(link);
                  launch(meeting.toString());
                }, child: Text('Join'))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doctor, style: TypographyStyles.title(16)),
                Row()
              ],
            )
          ],
        ),
      ),
    ),
  );
}
