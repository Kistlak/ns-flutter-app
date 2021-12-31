import 'dart:convert';
import 'package:north_star/Styles/ButtonStyles.dart';
import  'package:string_similarity/string_similarity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:http/http.dart' as http;
import 'package:north_star/UI/HomeWidgets/HomeWidgetTrainers/TrainerView.dart';
class HomeWidgetTrainers extends StatelessWidget {
  const HomeWidgetTrainers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool ready = false.obs;
    RxList trainers = [].obs;
    String lastSearch = '';
    TextEditingController searchController = TextEditingController();

    Future getGyms() async{
        var request = http.Request('GET', Uri.parse('https://ion-groups.live/api/trainers'));
        request.headers.addAll(client.getHeader());

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          var res = jsonDecode(await response.stream.bytesToString());
          trainers.value = res['data'];
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
      appBar: AppBar(title: Text('Trainers')),
      body: Column(
        children: [
      Padding(
      padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Material(
                color: Colors.white,
                child: TextField(
                  controller: searchController,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Search Trainers...',
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
                    getGyms();
                  } else if (lastSearch != searchController.text){
                    lastSearch = searchController.text;
                    getGyms().then((value){
                      List temp = [];
                      lastSearch = searchController.text;
                      trainers.value.forEach((element) {
                        double fNameSim = element['name'].split(' ')[0].toString().similarityTo(searchController.text);
                        double lNameSim = element['name'].split(' ')[1].toString().similarityTo(searchController.text);
                        if((fNameSim+lNameSim) > 0.5){
                          temp.add(element);
                        }
                      });
                      trainers.value = temp;
                    });
                  } else {
                    List temp = [];
                    lastSearch = searchController.text;
                    trainers.value.forEach((element) {
                      double fNameSim = element['name'].split(' ')[0].toString().similarityTo(searchController.text);
                      double lNameSim = element['name'].split(' ')[1].toString().similarityTo(searchController.text);
                      if((fNameSim+lNameSim) > 0.5){
                        temp.add(element);
                      }
                    });
                    trainers.value = temp;
                  }
                },
              ),
            )
          ],
        )
      ),
          Expanded(
            child: Obx(()=> ready.value ? trainers.length != 0 ? ListView.builder(
              itemCount: trainers.length,
              itemBuilder: (_,index){

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: ListTile(
                      isThreeLine: true,
                      leading: CircleAvatar(
                        radius: 28,
                        child: Text(index.toString()),
                      ),
                      title: Text(trainers[index]['name'], style: TypographyStyles.title(18)),
                      subtitle: Text(trainers[index]['email'] + '| Rating ' + trainers[index]['rating']),
                      onTap: (){
                        Get.to(()=>TrainerView(trainerObj: trainers[index]));
                      },
                    ),
                  ),
                );
              },
            )
                : Center(child: Text('No Trainers Found'),)
                : Center(child: CircularProgressIndicator())),
          )
        ],
      ),
    );
  }
}
