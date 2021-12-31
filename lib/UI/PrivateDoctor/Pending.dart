import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:north_star/Models/AuthUser.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/ButtonStyles.dart';
import 'package:north_star/Styles/TypographyStyles.dart';

class Pending extends StatelessWidget {
  const Pending({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool ready = false.obs;
    RxList list = [].obs;
    TextEditingController reason = TextEditingController();

    void getPending() async{
      ready.value = false;
      var request = http.Request('GET', Uri.parse(HttpClient.healthBaseURL +'/api/viewpendingappoinment'));
      request.body = json.encode({
        "doctors_id": authUser.roleId
      });
      request.headers.addAll(client.getHeader());
      print(authUser.roleId);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = jsonDecode(await response.stream.bytesToString());
        print(res);
        list.value = res['ViewpendingAppoinment'];
        ready.value = true;
      } else {
        print(await response.stream.bytesToString());
        ready.value = true;
      }
    }

    void accept(id) async{
      var request = http.Request('PUT', Uri.parse(HttpClient.healthBaseURL +'/api/doctoracceptappoinment/$id'));
      request.headers.addAll(client.headers);
      http.StreamedResponse response = await request.send();
      print(id);
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        getPending();
      }
      else {
        print(response.reasonPhrase);
      }
    }

    void reject(id) async{
      var request = http.Request('PUT', Uri.parse(HttpClient.healthBaseURL +'/api/doctorcencelappoinment/$id'));
      request.headers.addAll(client.headers);


      request.body = json.encode({
        "description": reason.text
      });

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        getPending();
      }
      else {
        print(response.reasonPhrase);
      }
    }

    void cancelingReason(id){
      Get.defaultDialog(
          radius: 4,
          title: 'Canceling Reason',
          content: TextField(
            controller: reason,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Reason',
            ),
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyles.bigBlackButton(),
                child: Text('Confirm Canceling'),
                onPressed: () {
                  reject(id);
                  Get.back();
                }
            ),
          ]
      );
    }

    getPending();

    return Scaffold(
      backgroundColor: Color(0xffF6F6F6),
      appBar: AppBar(
        title: Text('Pending Appointments'),
      ),
      body: Obx(()=> ready.value ? list.length == 0 ? Center(
        child: Text('No Pending Appointments', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ) : ListView.builder(
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
                  ButtonBar(
                    children: [
                      TextButton(
                        child: const Text('Reject'),
                        onPressed: () {
                          cancelingReason(list[index]['commondata']['id']);
                        },
                      ),
                      TextButton(
                        child: const Text('Accept'),
                        onPressed: () {
                          accept(list[index]['commondata']['id']);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ): LinearProgressIndicator()),
    );
  }
}
