import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Auth/AuthHome.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:http/http.dart' as http;
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientProfile extends StatelessWidget {

  const ClientProfile({Key? key}) : super(key: key);


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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(()=>ready.value ? Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundImage: AssetImage('assets/images/front.png'),
                ),
              ],
            ),
            Text(data['name'], style: TypographyStyles.title(24)),
            Text(data['id'].toString(), style: TypographyStyles.text(16)),
            SizedBox(height: 16),
            //User data ui.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Phone', style: TypographyStyles.text(16)),
                    SizedBox(height: 8),
                    Text('Birth Day', style: TypographyStyles.text(16)),
                    SizedBox(height: 8),
                    Text('Email', style: TypographyStyles.text(16)),
                    SizedBox(height: 8),
                    Text('NIC', style: TypographyStyles.text(16)),
                    SizedBox(height: 8),
                    Text('Country', style: TypographyStyles.text(16)),
                    SizedBox(height: 8),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['mobileNo'], style: TypographyStyles.title(16)),
                    SizedBox(height: 8),
                    Text(data['birthDate'], style: TypographyStyles.title(16)),
                    SizedBox(height: 8),
                    Text(data['email'], style: TypographyStyles.title(16)),
                    SizedBox(height: 8),
                    Text(data['nic'], style: TypographyStyles.title(16)),
                    SizedBox(height: 8),
                    Text(data['countryName'], style: TypographyStyles.title(16)),
                    SizedBox(height: 8),
                  ],
                ),
              ],
            ),
            Divider(),
            //title "Emergency Contact"
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Emergency Contact', style: TypographyStyles.title(16)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['emergencyOneName'], style: TypographyStyles.text(16)),
                    SizedBox(height: 8),
                    Text(data['emergencyTwoName'] == null ? '':data['emergencyTwoName'], style: TypographyStyles.title(16)),
                    SizedBox(height: 8),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['emergencyOneContactNo'], style: TypographyStyles.title(16)),
                    SizedBox(height: 8),
                    Text(data['emergencyTwoContactNo']  == null ? '':data['emergencyTwoContactNo'], style: TypographyStyles.title(16)),
                    SizedBox(height: 8),
                  ],
                ),
              ],
            ),
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
        ): Center(
          child: CircularProgressIndicator(),
        )),
      ),
    );
  }
}
