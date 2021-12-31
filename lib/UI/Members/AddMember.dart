import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Models/AuthUser.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/Themes.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:http/http.dart' as http;
import 'package:north_star/Utils/PopUps.dart';

class AddMember extends StatelessWidget {
  const AddMember({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool ready = false.obs;
    var data = {};

    void getSlots() async{
      //
      ready.value = false;
      var request = http.Request('GET', Uri.parse(HttpClient.baseURL + '/api/trainers/app-slot-packages/'+ authUser.id.toString()));
      request.headers.addAll(client.getHeader());

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = jsonDecode(await response.stream.bytesToString());
        data = res;
        print(res);
        ready.value = true;
      } else {
        print(await response.stream.bytesToString());
        ready.value = true;
      }
    }

    getSlots();

    TextEditingController email = TextEditingController();

    void sendInvite() async {
      if (data['total_slots'] > 0){
        ready.value = false;
        var request = http.MultipartRequest(
            'POST', Uri.parse('https://ion-groups.live/api/clients/invitations'));
        request.headers.addAll(client.getHeader());

        request.fields.addAll({
          'email': email.text
        });

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 201) {
          var res = jsonDecode(await response.stream.bytesToString());
          showSnack('Success!', 'Invite Sent!');
          print(res);
          ready.value = true;
        } else {
          print(await response.stream.bytesToString());
          ready.value = true;
        }
      } else {
        showSnack('No free slots!', 'please purchase a slot package');
      }

    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Add Member'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Obx(()=> ready.value ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    height: Get.width/4,
                    decoration: BoxDecoration(
                        color: Color(0xffF2F2F2),
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Available Slots'),
                        Text(data['total_slots'].toString(),style: TypographyStyles.title(32),)
                      ],
                    ),
                  ),
                  /*Container(
                    padding: const EdgeInsets.all(16),
                    height: Get.width/4,
                    width: Get.width/2.5,
                    decoration: BoxDecoration(
                        color: Color(0xffF2F2F2),
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Reserved'),
                        Text('16',style: TypographyStyles.title(32),)
                      ],
                    ),
                  ),*/
                ],
              ): Center(child: CircularProgressIndicator())),
              SizedBox(height: 16),

              TextField(
                controller: email,
                decoration: InputDecoration(
                    hintText: 'Email',
                    label: Text('Email'),
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: Get.width,
                height: 58,
                child: Obx(()=> ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: Themes().roundedBorder(12),
                      primary: Color(0xFF1C1C1C)),
                  child: ready.value ? Text(
                    'Send Request',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ) : Center(child: CircularProgressIndicator()),
                  onPressed: () {
                    sendInvite();
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
