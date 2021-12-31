import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Models/AuthUser.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/Themes.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:http/http.dart' as http;
import 'package:north_star/Utils/PopUps.dart';

class HomeWidgetSlots extends StatelessWidget {
  const HomeWidgetSlots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool ready = false.obs;
    var data = {};
    var slotData = [];

    void getSlotPackages() async{

      ready.value = false;
      var request = http.Request('GET', Uri.parse(HttpClient.baseURL + '/api/app-slot-packages'));
      request.headers.addAll(client.getHeader());

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = jsonDecode(await response.stream.bytesToString());
        slotData = res;
        print(res);
        ready.value = true;
      } else {
        print(await response.stream.bytesToString());
        ready.value = true;
      }
    }

    void getSlots() async{
        ready.value = false;
        var request = http.Request('GET', Uri.parse(HttpClient.baseURL + '/api/trainers/app-slot-packages/'+ authUser.id.toString()));
        request.headers.addAll(client.getHeader());

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          var res = jsonDecode(await response.stream.bytesToString());
          data = res;
          print(res);
          getSlotPackages();
        } else {
          print(await response.stream.bytesToString());
          ready.value = true;
        }


    }



    getSlots();

    return Scaffold(
      appBar: AppBar(title: Text('Slots'),),
      body: Obx(()=> ready.value ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          data['slot_details'].length > 0 ? Container(
            padding: const EdgeInsets.all(16),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: Color(0xff76ADE4),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(),
                    Text('Starter Package',style: TypographyStyles.boldText(16, Colors.white)),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Available Slots',style: TypographyStyles.boldText(16, Colors.white)),
                            Text(data['total_slots'].toString(),style: TypographyStyles.boldText(24, Colors.white)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /*Text('Used Slots',style: TypographyStyles.boldText(16, Colors.white)),
                            Text('5',style: TypographyStyles.boldText(24, Colors.white)),*/
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(data['slot_details'][0]['type'].toString().toUpperCase(),style: TypographyStyles.boldText(16, Colors.white)),
                  ],
                ),
              ),
            ),
          ): Center(
            child: Text('You have no active packages!'),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Upgrade Package', style: TypographyStyles.title(21),),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: slotData.length,
              itemBuilder: (_,index){
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Themes.mainThemeColor,
                        width: 2,
                      ),
                    ),
                    child: InkWell(
                        onTap: (){},
                        child:Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Package #$index',style: TypographyStyles.title(16)),
                                  Text('LKR '+ slotData[index]['amount'],style: TypographyStyles.title(24)),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text('Slots',style: TypographyStyles.title(16)),
                                      Text(slotData[index]['no_of_slots'].toString(),style: TypographyStyles.title(32)),
                                      Visibility(
                                        visible: slotData[index]['is_discount'] == 1,
                                        child: Chip(
                                          label: Text('Promotion '+slotData[index]['discount'].toString()+'% Off',style: TypographyStyles.title(16)),
                                          labelStyle: TypographyStyles.normalText(14, Colors.white),
                                          backgroundColor: Themes.mainThemeColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ): Center(
        child: CircularProgressIndicator(),
      ))
    );
  }
}
