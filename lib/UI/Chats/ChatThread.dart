import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/ButtonStyles.dart';
import 'package:north_star/Styles/Themes.dart';

class ChatThread extends StatelessWidget {
  const ChatThread({Key? key, required this.name, required this.chatID}) : super(key: key);

  final String name;
  final String chatID;

  @override
  Widget build(BuildContext context) {
    RxBool ready = false.obs;
    RxList chats = [].obs;
    RxList users = [].obs;
    TextEditingController searchController = TextEditingController();
    RxBool isSelected = false.obs;
    var selectedUser;

    TextEditingController message = new TextEditingController();

    void getMessages() async{
      print(chatID);
      var request = http.Request(
          'GET', Uri.parse('https://ion-groups.live/api/users/groups/'+chatID+'/messages'));
      request.headers.addAll(client.getHeader());

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = jsonDecode(await response.stream.bytesToString());
        //print(res);
        chats.value = new List.from(res['data'].reversed);
        ready.value = true;
        //print(res);
      } else {
        print(response.reasonPhrase);
        ready.value = true;
      }
    }


    void sendMessage() async {
      var request = http.MultipartRequest('POST', Uri.parse('https://ion-groups.live/api/users/groups/messages'));
      request.headers.addAll(client.getHeader());
      request.fields.addAll({
        'user_id': client.id.toString(),
        'group_id': chatID.toString(),
        'message': message.text
      });
      http.StreamedResponse response = await request.send();
      message.clear();
      if (response.statusCode == 200) {
        var res = jsonDecode(await response.stream.bytesToString());
        print(res);
        getMessages();
      } else {
        print(response.reasonPhrase);
      }
    }

    void getResult() async{
      var request = http.Request('GET', Uri.parse('https://ion-groups.live/api/clients?search=${searchController.text}'));

      request.headers.addAll(client.headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var dt = jsonDecode(await response.stream.bytesToString());
        print(dt);
        users.value = dt['data'];
        isSelected.value = false;
      }
      else {
        print(response.reasonPhrase);
      }
    }

    void addMember() async{
      var request = http.MultipartRequest('POST', Uri.parse('https://ion-groups.live/api/users/groups'));
      request.fields.addAll({
        'group_id': '1',
        'user_id[0]': '21'
      });

      request.headers.addAll(client.headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        print(await response.stream.bytesToString());
        Get.back();
      }
      else {
      print(response.reasonPhrase);
      }
    }

    void showAdd(){
      Get.defaultDialog(
        radius: 8,
        title: 'Add a New Member',
        content: Column(
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
            Container(
              height: Get.height / 2,
              width: Get.width,
              child: Obx(()=> !isSelected.value ? ListView.builder(
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
              ): Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text('A'),
                    ),
                    title: Text(selectedUser['name']),
                    subtitle: Text(selectedUser['email']),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      width: Get.width / 2,
                      child: ElevatedButton(
                        style: ButtonStyles.bigBlackButton(),
                        child: Text('Add'),
                        onPressed: (){
                          addMember();
                        },
                      ),
                    ),
                  )
                ],
              )),
            )
          ],
        )
      );
    }

    getMessages();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        actions: [
          IconButton(onPressed: () {
            showAdd();
          }, icon: Icon(Icons.person_add))],
        title: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.blue,
            ),
            SizedBox(width: 16),
            Text('$name')
          ],
        ),
      ),
      body: Column(
        children: [
          Divider(),
          Expanded(
              child: Obx(()=>ListView.builder(
                reverse: true,
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  print(chats.length);
                  return Row(
                    mainAxisAlignment: index == client.id
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: Card(
                          color:
                          index == client.id ? Color(0xffF8F8F8) : Color(0xffF3AF5D),
                          elevation: 0,

                          child: Padding(
                            padding:const EdgeInsets.all(16),
                            child: Center(child: Text(
                                chats[index]['message'],
                                style: TextStyle(
                                  color: index == client.id ? Colors.black:Colors.white
                                ))
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ))),
          Container(
            color: Color(0xffF8F8F8),
            height: 96,
            width: Get.width,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 56,
                    width: Get.width * 0.75,
                    child: TextField(
                      controller: message,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(64)),
                        hintText: 'Type...',
                      ),
                    ),
                  ),
                  Container(
                    height: 56,
                    width: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: Themes().roundedBorder(256),
                          primary: Color(0xffF1AB56),
                          onPrimary: Colors.white,
                          elevation: 0),
                      onPressed: () {
                        sendMessage();
                      },
                      child: Icon(Icons.send),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
