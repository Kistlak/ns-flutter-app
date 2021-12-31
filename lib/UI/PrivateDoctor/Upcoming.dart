import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:north_star/Models/AuthUser.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/ButtonStyles.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:url_launcher/url_launcher.dart';

class Upcoming extends StatelessWidget {
  const Upcoming({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool ready = false.obs;
    RxList list = [].obs;
    TextEditingController reason = TextEditingController();

    void getUpcoming() async{
      ready.value = false;
      var request = http.Request('GET', Uri.parse(HttpClient.healthBaseURL +'/api/upcominappoinment'));
      request.body = json.encode({
        "doctors_id": authUser.roleId
      });
      request.headers.addAll(client.getHeader());
      print(authUser.roleId);

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

    getUpcoming();

    return Scaffold(
      backgroundColor: Color(0xffF6F6F6),
      appBar: AppBar(
        title: Text('Upcoming Appointments'),
      ),
      body: Obx(()=> ready.value ? ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text(
                          list[index]['commondata']['getuser']['id'].toString()
                      ),
                    ),
                    title: Text(
                    list[index]['user_data']['name'] ?? list[index]['user_data']['full_name'],
                      style: TypographyStyles.title(20),
                    ),
                    subtitle: Text(
                        list[index]['commondata']['getuser']['birth_date'].toString()
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Appointment Date',
                            style: TypographyStyles.title(16),
                          ),
                          Text(
                              list[index]['commondata']['date'].toString().replaceAll('\n', '')
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Appointment Time',
                            style: TypographyStyles.title(16),
                          ),
                          Text(
                              list[index]['commondata']['time'].toString().replaceAll('\n', '')
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child:Row(
                      children: [
                        Text(list[index]['commondata']['description'].toString(),),
                      ],
                    )
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(8),
                        width: 128,
                        child: ElevatedButton(
                          style: ButtonStyles.bigBlackButton(),
                          child: const Text('Join'),
                          onPressed: () {
                            final Uri meeting = Uri.parse(list[index]['commondata']['link']);
                            launch(meeting.toString());
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ): LinearProgressIndicator()),
    );
  }
}
