import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/Themes.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:http/http.dart' as http;
import 'package:north_star/UI/HomeWidgets/HomeWidgetGym/GymView.dart';
class HomeWidgetGym extends StatelessWidget {
  const HomeWidgetGym({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool ready = false.obs;
    RxList gyms = [].obs;

    void getGyms() async{
        var request = http.Request('GET', Uri.parse('https://ion-groups.live/api/gyms'));
        request.headers.addAll(client.getHeader());

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          var res = jsonDecode(await response.stream.bytesToString());
          gyms.value = res['data'];
          ready.value = true;
          print(res);
        } else {
          print(response.reasonPhrase);
          ready.value = true;
        }
    }

    getGyms();

    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(title: Text('Gym')),
      body: Column(
        children: [
          Padding(
          padding: const EdgeInsets.all(16),
          child: Material(
            color: Colors.white,
            child: TextField(
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                hintText: 'Search Gyms...',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none
              ),
            ),
          ),
        ),
          Expanded(
            child: Obx(()=> ready.value ? ListView.builder(
              itemCount: gyms.length,
              itemBuilder: (_,index){
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 28,
                        child: Text(index.toString()),
                      ),
                      title: Text(gyms[index]['name'], style: TypographyStyles.title(18)),
                      subtitle: Text(gyms[index]['email'] + '| Rating ' + gyms[index]['rating']),
                      onTap: (){
                        Get.to(()=>GymView(gymObj: gyms[index]));
                      },
                    ),
                  ),
                );
              },
            ): Center(child: CircularProgressIndicator())),
          )
        ],
      ),
    );
  }
}
