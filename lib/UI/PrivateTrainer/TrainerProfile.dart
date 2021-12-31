import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:north_star/Auth/AuthHome.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/Themes.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class TrainerProfile extends StatelessWidget {
  const TrainerProfile({Key? key}) : super(key: key);

  static String placeholder = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.';
  static String placeholder2 = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';

  @override
  Widget build(BuildContext context) {
    RxBool ready = false.obs;

    var data = {};

    void getProfile() async{
      ready.value = false;
      var request = http.MultipartRequest('GET', Uri.parse(HttpClient.baseURL + '/api/me/profile'));
      request.headers.addAll(client.getHeader());

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = jsonDecode(await response.stream.bytesToString());
        data = res['data'];
        print(res['data']);
        ready.value = true;
      } else {
        print(await response.stream.bytesToString());
        ready.value = true;
      }
    }

    getProfile();

    return Scaffold(
      body: Column(
        children: [
          Obx(()=>ready.value ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 16),
                  CircleAvatar(radius: 36),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text(data['name'].toString().split(' ')[0], style: TypographyStyles.title(24)),
                        SizedBox(width: 4),
                        Text(data['name'].toString().split(' ')[1], style: TypographyStyles.text(24))
                      ],),
                      Row(children: [
                        Text(data['role']+' | '),
                        Icon(Icons.star, color: Themes.mainThemeColor),
                        Text(data['rating']+' Rating',)
                      ],)
                    ],
                  )
                ],
              ),
              Divider(thickness: 1),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('About', style: TypographyStyles.title(20)),
                    Text(placeholder, textAlign: TextAlign.justify),
                    SizedBox(height: 16),
                    Text('Qualifications', style: TypographyStyles.title(20)),
                    Container(
                      height: 128,
                      width: Get.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data['qualifications'].length,
                        itemBuilder: (_,index){
                          return Container(
                            width: Get.width*0.75,
                            margin:const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(16)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Icon(Icons.ac_unit,size: 21),
                                  SizedBox(width: 8),
                                  Text(data['qualifications'][index]['id'].toString(),style: TypographyStyles.title(18))
                                ],),
                                SizedBox(height: 8.0),
                                Text(data['qualifications'][index]['name'], textAlign: TextAlign.justify)
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ): Center(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          )),
          Divider(thickness: 1),
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
    );
  }
}
