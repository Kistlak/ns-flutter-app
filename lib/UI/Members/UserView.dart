import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/Themes.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetMeasurements.dart';
import 'package:north_star/UI/Members/UserView_Bio.dart';
import 'package:north_star/UI/Members/UserView_Health.dart';
import 'package:north_star/UI/Members/UserView_Progress.dart';
import 'package:http/http.dart' as http;

class UserView extends StatelessWidget {

  const UserView({Key? key, required this.userID}) : super(key: key);

  final int userID;

  @override
  Widget build(BuildContext context) {

    var data = {};
    RxBool ready = false.obs;
    RxInt gender = 1.obs;

    TextEditingController weightController = TextEditingController();
    TextEditingController heightController = TextEditingController();
    TextEditingController ageController = TextEditingController();

    void getData() async{
      var request = http.Request('GET', Uri.parse(HttpClient.baseURL + '/api/users/profiles/'+ userID.toString()));
      request.headers.addAll(client.getHeader());

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = jsonDecode(await response.stream.bytesToString());
        data = res['data'];
        ready.value = true;
      //print(res);
      } else {
      print(await response.stream.bytesToString());
      ready.value = true;
      }
    }

    getData();

    return Scaffold(
      appBar: AppBar(),
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Obx(()=> ready.value ? Column(
          children: [
            Container(
              color: Themes.mainThemeColor,
              padding: const EdgeInsets.all(8),
              child: Center(child: Text('There are 14 Days left until the end of subscription.',
                style: TextStyle(color: Colors.white),
              ),),
            ),
            ListTile(
              title: Text(data['name']),
              subtitle: Text('User ID: '+data['id'].toString()),
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.call),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.message),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 16),
                TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xffF8F8F8),
                    ),
                    onPressed: (){
                      Get.to(()=>HomeWidgetMeasurement());
                    }, child: Row(
                  children: [
                    Icon(Icons.system_update),
                    Text('Update Measurements')
                  ],
                )),
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xffF8F8F8)
                    ),
                    onPressed: (){}, child: Row(
                  children: [
                    Icon(Icons.remove_circle_outline),
                    Text('Remove')
                  ],
                )),
                SizedBox(width: 16),
              ],
            ),
            TabBar(
              labelColor: Themes.mainThemeColor,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(
                  child: Text(
                    "Bio",
                  ),
                ),
                Tab(
                  child: Text(
                    "Progress",
                  ),
                ),
                Tab(
                  child: Text(
                    "Health",
                  ),
                ),
              ],
            ),
            Expanded(
                child: TabBarView(
                  children: [
                    UserViewBio(data: data),
                    UserViewProgress(),
                    UserViewHealth()
                  ],
                )),
          ],
        ):Center(
          child: CircularProgressIndicator(),
        )),
      ),
    );



  }




}
