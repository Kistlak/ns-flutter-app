import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/ButtonStyles.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:http/http.dart' as http;
import 'package:north_star/UI/HomeWidgets/HomeWidgetMeasurements/BMI.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetMeasurements/BloodPressure.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetMeasurements/BloogSugar.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetMeasurements/BodyFat.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetMeasurements/Measurements.dart';
import 'package:north_star/Utils/PopUps.dart';

class HomeWidgetMeasurement extends StatelessWidget {
  const HomeWidgetMeasurement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    RxBool isSelected = false.obs;
    var selectedUser;
    RxList users = [].obs;

    void getResult() async{
      var request = http.Request('GET', Uri.parse('https://ion-groups.live/api/clients?search=${searchController.text}'));

      request.headers.addAll(client.headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var dt = jsonDecode(await response.stream.bytesToString());
        print(dt);
        users.value = dt['data'];

      }
      else {
      print(response.reasonPhrase);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Measurements Inputting'),
      ),
      body: Obx(()=> isSelected.value?  Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('A'),
            ),
            title: Text(selectedUser['name']),
            subtitle: Text(selectedUser['email']),
          ),
          SizedBox(height: 16),
          Container(
            width: Get.width,
            height: 64,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: (){
                Get.to(()=> Measurements(user: selectedUser));
              },
              style: ButtonStyles.bigBlackButton(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Body Measurements'),
                  Icon(Icons.chevron_right)
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            width: Get.width,
            height: 64,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: (){
                Get.to(()=> BloodSugar(user: selectedUser));
              },
              style: ButtonStyles.bigBlackButton(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Blood Sugar'),
                  Icon(Icons.chevron_right)
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            width: Get.width,
            height: 64,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: (){
                Get.to(()=> BodyFat(user: selectedUser));
              },
              style: ButtonStyles.bigBlackButton(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Body Fat and Muscle Mass'),
                  Icon(Icons.chevron_right)
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            width: Get.width,
            height: 64,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: (){
                Get.to(()=> BloodPressure(user: selectedUser));
              },
              style: ButtonStyles.bigBlackButton(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Blood Pressure'),
                  Icon(Icons.chevron_right)
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            width: Get.width,
            height: 64,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: (){
                Get.to(()=> BMI(user: selectedUser));
              },
              style: ButtonStyles.bigBlackButton(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('BMI Info'),
                  Icon(Icons.chevron_right)
                ],
              ),
            ),
          ),
        ],
      ): Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Material(
                    color: Color(0xffF2F2F2),
                    child: TextField(
                      controller: searchController,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Search Members...',
                        prefixIcon: Icon(Icons.search),

                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 48,
                  child: ElevatedButton(
                    style: ButtonStyles.bigFlatBlackButton(),
                    child: Text('Search'),
                    onPressed: (){
                      getResult();
                    },
                  ),
                )
              ],
            )
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (_,index){
                return ListTile(
                  onTap: (){
                      selectedUser = users[index];
                      isSelected.value = true;
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('A'),
                  ),
                  title: Text(users[index]['name']),
                  subtitle: Text(users[index]['email']),
                );
              },
            ),
          )
        ],
      ))
    );
  }
}
