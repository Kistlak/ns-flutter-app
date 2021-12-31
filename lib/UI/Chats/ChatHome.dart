import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/Themes.dart';
import 'package:north_star/UI/Chats/ChatThread.dart';

class ChatHome extends StatelessWidget {
  const ChatHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool ready = false.obs;
    RxList chats = [].obs;

    TextEditingController gpName = TextEditingController();



    void getChats() async {
      var request = http.Request(
          'GET', Uri.parse(HttpClient.baseURL+'/api/me/groups'));
      request.headers.addAll(client.getHeader());

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = jsonDecode(await response.stream.bytesToString());
        chats.value = res['data']['groups'];
        ready.value = true;
        print(res);
      } else {
        print(response.reasonPhrase);
        ready.value = true;
      }
    }

    void createGroup() async{
      var request = http.MultipartRequest(
          'POST', Uri.parse(HttpClient.baseURL+'/api/groups'));
      request.headers.addAll(client.getHeader());

      request.fields.addAll({
        'name': gpName.text,
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = jsonDecode(await response.stream.bytesToString());
        chats.value = res['data']['groups'];
        ready.value = true;
        print(res);
        getChats();
        Get.back();
      } else {
        getChats();
        Get.back();
        print(response.reasonPhrase);
        ready.value = true;
      }
    }

    getChats();

    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
            radius: 4,
            title: 'New Group',
            content: Column(
              children: [
                TextField(
                  controller: gpName,
                  decoration: InputDecoration(
                    labelText: 'Group Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Get.back();
                },
              ),
              TextButton(
                child: Text('Create'),
                onPressed: () {
                  createGroup();
                },
              ),

            ],
          );
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Material(
              color: Color(0xFFF6F6F6),
              child: TextField(
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none
                ),
              ),
            ),
          ),
          Divider(),
          Obx(() {
            return Expanded(
              child: ready.value
                  ? ListView.builder(
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.blue,
                              ),
                              /*trailing: index.isEven
                                  ? Container(
                                      height: 32,
                                      width: 48,
                                      child: Card(
                                        child: Center(
                                          child: Text(
                                            '$index',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        shape: Themes().roundedBorder(16),
                                        color: Color(0xff46B100),
                                      ),
                                    )
                                  : Container(
                                      height: 0,
                                      width: 0,
                                    ),*/
                              onTap: () {
                                //print(chats[index].toString());
                                Get.to(() => ChatThread(
                                      name: chats[index]['group']['name'],
                                      chatID: chats[index]['group_id'].toString(),
                                    ));
                              },
                              title: Text(chats[index]['group']['name']),
                              subtitle: Text(chats[index]['group']['updated_at']
                                  .split('T')[0]),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.black.withOpacity(0.125),
                            )
                          ],
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            );
          }),
        ],
      ),
    );
  }
}
