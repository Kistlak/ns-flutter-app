import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/ButtonStyles.dart';
import 'package:north_star/Styles/Themes.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:http/http.dart' as http;
import 'package:north_star/UI/HomeWidgets/HomeWidgetDoctors/DoctorProfile.dart';
import  'package:string_similarity/string_similarity.dart';

class DoctorsList extends StatelessWidget {
  const DoctorsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    RxBool ready = false.obs;
    RxList doctors = [].obs;
    String lastSearch = '';
    TextEditingController searchController = TextEditingController();

    Future getDoctors() async {
      var request = http.Request('GET', Uri.parse('https://ion-groups.live/api/doctors'));
      request.headers.addAll(client.getHeader());

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = jsonDecode(await response.stream.bytesToString());
        doctors.value = res['data'];
        ready.value = true;
        print(res);
      } else {
        print(response.reasonPhrase);
        ready.value = true;
      }
    }
    getDoctors();



    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Material(
                        color: Color(0xffF5F5F5),
                        child: TextField(
                          controller: searchController,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            hintText: 'Search Doctors...',
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
                          if(searchController.text.isEmpty){
                            getDoctors();
                          } else if (lastSearch != searchController.text){
                            lastSearch = searchController.text;
                            getDoctors().then((value){
                              List temp = [];
                              lastSearch = searchController.text;
                              doctors.value.forEach((element) {
                                double fNameSim = element['name'].split(' ')[0].toString().similarityTo(searchController.text);
                                double lNameSim = element['name'].split(' ')[1].toString().similarityTo(searchController.text);
                                if((fNameSim+lNameSim) > 0.5){
                                  temp.add(element);
                                }
                              });
                              doctors.value = temp;
                            });
                          } else {
                            List temp = [];
                            lastSearch = searchController.text;
                            doctors.value.forEach((element) {
                              double fNameSim = element['name'].split(' ')[0].toString().similarityTo(searchController.text);
                              double lNameSim = element['name'].split(' ')[1].toString().similarityTo(searchController.text);
                              if((fNameSim+lNameSim) > 0.5){
                                temp.add(element);
                              }
                            });
                            doctors.value = temp;
                          }
                        },
                      ),
                    )
                  ],
                )
            ),
            SizedBox(height: 16),
            Expanded(
              child: Obx(()=>ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context,index){
                  return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Material(
                        elevation: 2,
                        color: Color(0xfff5f5f5),
                        borderRadius: BorderRadius.circular(16.0),
                        child: InkWell(
                            borderRadius: BorderRadius.circular(16.0),
                            onTap: (){
                              Get.to(()=>DoctorProfile(doctor: doctors[index]));
                            },
                            child: Padding(
                              child: Row(
                                children: [
                                  CircleAvatar(radius: 32),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(doctors[index]['name'], style: TypographyStyles.boldText(16, Themes.mainThemeColor),),
                                      Text(doctors[index]['name'], style: TypographyStyles.boldText(18, Colors.black),),
                                      Text(doctors[index]['name'], style: TypographyStyles.boldText(14, Colors.grey),),
                                    ],
                                  )
                                ],
                              ),
                              padding: const EdgeInsets.all(8),
                            )
                        ),
                      )
                  );
                },
              )),
            )
          ],
        ),
      ),
    );
  }
}
