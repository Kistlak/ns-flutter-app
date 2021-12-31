import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Auth/AuthHome.dart';
import 'package:north_star/Models/AuthUser.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:http/http.dart' as http;
import 'package:north_star/UI/PrivateDoctor/Pending.dart';
import 'package:north_star/Utils/PopUps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import 'Upcoming.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool online = true.obs;
    RxBool ready = false.obs;
    RxList list = [].obs;
    RxInt count_upcomming = 0.obs;
    RxInt count_pending = 0.obs;

    void getOnlineStatus() async{

    }
    void getCounts() async{
      var request = http.MultipartRequest('POST', Uri.parse(HttpClient.healthBaseURL +'/api/ViewScheduleAndPending'));
      request.headers.addAll(client.getHeader());

      request.fields.addAll({
        'doctor_id': authUser.roleId.toString()
      });
      print(authUser.roleId);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = jsonDecode(await response.stream.bytesToString());
        print(res);
        count_upcomming.value = res['Schedule_count'];
        count_pending.value = res['Pending_count'];

      } else {
        print(await response.stream.bytesToString());
      }
    }
    void getScheduled() async{
      ready.value = false;
      var request = http.Request('GET', Uri.parse(HttpClient.healthBaseURL +'/api/upcominappoinment'));
      request.body = json.encode({
        "doctors_id": authUser.roleId
      });
      request.headers.addAll(client.getHeader());
      //print(authUser.roleId);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = jsonDecode(await response.stream.bytesToString());
        print(res);
        list.value = res['upcomingappointment'];
        ready.value = true;
      } else {
        print(await response.stream.bytesToString());
        ready.value = true;
      }
    }
    void toggleOnlineStatus() async{
      ready.value = false;
      var request = http.Request('PUT', Uri.parse('http://139.59.111.170/api/doctoronline/1'));
      request.headers.addAll(client.getHeader());

      request.body = json.encode({
        "active": online.value ? 1:0
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        var res = jsonDecode(await response.stream.bytesToString());
        ready.value = true;
        print(res);
      showSnack('Successfully Changes', 'Online Status changed successfully!');
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
        if (element['commondata']['date'].toString().replaceAll('\n','').replaceAll(' ', '') == dtString) {
          events.add(element);
          print('Has Event');
        }
      });
      return events;
    }


    void refresh(){
      getCounts();
      getScheduled();
    }

    getCounts();
    getScheduled();


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF3F4F6),
          toolbarHeight: 72,
          centerTitle: true,
          title: Container(
            height: 32,
            child: Image.asset(
              'assets/logo_black.png',
              fit: BoxFit.fitHeight,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Online', style: TypographyStyles.title(24)),
                  Obx(
                        () => CupertinoSwitch(
                        value: online.value,
                        onChanged: (value) {
                          online.value = value;
                          toggleOnlineStatus();
                        }),
                  ),
                  IconButton(
                    onPressed: (){
                      refresh();
                    },
                    icon: Icon(Icons.refresh),
                  )
                ],
              ),
              SizedBox(height: 32),
              Obx(()=>Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: ElevatedButton(
                    onPressed:(){
                      Get.to(()=>Pending());
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Color(0xffF3F4F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16),
                              Text('Schedule',
                                  style: TypographyStyles.title(18)),
                              Text(count_upcomming.string, style: TypographyStyles.title(32)),
                              SizedBox(height: 16),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16),
                              Text('Pending',
                                  style: TypographyStyles.title(18)),
                              Text(count_pending.string, style: TypographyStyles.title(32)),
                              SizedBox(height: 16),
                            ],
                          ),
                        ])),
              )),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Upcoming Appointments', style: TypographyStyles.title(18)),
                    TextButton(onPressed: (){
                      Get.to(()=>Upcoming());
                    }, child: Text('View All'))
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: Get.width,
                height: 180,
                child: Obx(()=> list.length == 0 ? Center(
                  child: Text('No Upcoming Appointments', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ): ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (_,index){
                    print(list[index]);
                    return Container(
                      padding: const EdgeInsets.all(8),
                      width: Get.width*0.8,
                      child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Colors.blue,
                                      child: Text('A'),
                                    ),
                                    SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                        list[index]['user_data']['name'] ?? list[index]['user_data']['full_name']
                                        , style: TypographyStyles.title(16)),
                                        Text(
                                            list[index]['commondata']['getuser']['birth_date']
                                        , style: TypographyStyles.text(14)),
                                      ],
                                    )
                                  ],
                                ),
                                Divider(),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Date', style: TypographyStyles.title(16)),
                                        SizedBox(width: 8),
                                        Text(list[index]['commondata']['date'].toString().replaceAll('\n', ''), style: TypographyStyles.text(14)),
                                      ],
                                    ),
                                    SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Time', style: TypographyStyles.title(16)),
                                        SizedBox(width: 8),
                                        Text(list[index]['commondata']['time'], style: TypographyStyles.text(14)),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                      ),
                    );
                  },
                )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text('Schedule Dates', style: TypographyStyles.title(21)),
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  child: Obx(()=> ready.value ? TableCalendar(
                    onFormatChanged: (val){},
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    firstDay: DateTime.utc(2021, 1, 1),
                    lastDay: DateTime.utc(2025, 12, 31),
                    focusedDay: DateTime.now(),
                    eventLoader: (day) {
                      return getEventsForDay(day);
                    },
                  ): Center(
                    child: LinearProgressIndicator(),
                  )),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(onPressed: (){
                      SharedPreferences.getInstance().then((prefs) async {
                        await prefs.clear();
                        Get.offAll(()=>AuthHome());
                      });
                    },
                      child: Text('Sign Out'),)
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
