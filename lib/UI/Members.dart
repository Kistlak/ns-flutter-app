import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Models/AuthUser.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/ButtonStyles.dart';
import 'package:north_star/UI/Members/AddMember.dart';
import 'package:north_star/UI/Members/UserView.dart';
import 'package:http/http.dart' as http;

class Members extends StatelessWidget {
  const Members({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    RxList members = [].obs;
    RxBool ready = false.obs;

    void getMembers() async{
      var request = http.Request('GET', Uri.parse(HttpClient.baseURL + '/api/trainers/clients'));
      request.headers.addAll(client.getHeader());

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = jsonDecode(await response.stream.bytesToString());
        members.value = res['data'];
        ready.value = true;
        print(res);
      } else {
      print(response.reasonPhrase);
      ready.value = true;
      }
    }

    void getResult() async{
      var request = http.Request('GET', Uri.parse('https://ion-groups.live/api/clients?search=${searchController.text}'));

      request.headers.addAll(client.headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var dt = jsonDecode(await response.stream.bytesToString());
        print(dt);
        members.value = dt['data'];

      }
      else {
        print(response.reasonPhrase);
      }
    }
    getMembers();

    return Scaffold(
      floatingActionButton: Visibility(
        visible: authUser.role == 'trainer',
        child: FloatingActionButton(
          onPressed: () {
            Get.to(()=>AddMember());
          },
          child: Icon(Icons.add),
        ),
      ),
      backgroundColor: Colors.white,
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
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64), topLeft: Radius.circular(64)),
                  color: Color(0xffF2F2F2),
                  child: Column(
                    children: [
                      SizedBox(height: 4),
                      TextField(
                        controller: searchController,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          hintText: 'Search Members...',
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 52,
                child: ElevatedButton(
                  style: ButtonStyles.bigFlatBlackButton(),
                  child: Text('Search'),
                  onPressed: (){
                    //getResult();
                  },
                ),
              )
            ],
          )
      ),
            SizedBox(height: 16),
            Expanded(
              child: Container(
                color: Color(0xFFF6F6F6),
                child: Obx(()=> ready.value ? ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Material(
                        color: Colors.white,
                        child: ListTile(
                          onTap: (){
                            Get.to(()=>UserView(userID: members[index]['userId']));
                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person),
                          ),
                          title: Text(members[index]['fullName']),
                          subtitle: Text('ID: '+members[index]['userId'].toString()),
                          trailing: Chip(
                            backgroundColor: Color(0xFFF6F6F6),
                            label: Text('14 Days Left'),
                          ),
                        ),
                      ),
                    );
                  },
                ):Center(
                  child: CircularProgressIndicator(),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
