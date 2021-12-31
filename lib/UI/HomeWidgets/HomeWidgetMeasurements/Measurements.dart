import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/ButtonStyles.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:http/http.dart' as http;
import 'package:north_star/Utils/PopUps.dart';

class Measurements extends StatelessWidget {
  const Measurements({Key? key, this.user}) : super(key: key);
  final user;

  @override
  Widget build(BuildContext context) {

    TextEditingController height = TextEditingController();
    TextEditingController weight = TextEditingController();

    TextEditingController bust = TextEditingController();
    TextEditingController stomach = TextEditingController();

    TextEditingController chest = TextEditingController();
    TextEditingController calves = TextEditingController();

    TextEditingController hips = TextEditingController();
    TextEditingController arm = TextEditingController();

    TextEditingController thigh = TextEditingController();

    void saveMeasurement() async{
      var request = http.Request('POST', Uri.parse(HttpClient.healthBaseURL + '/api/bodypartsmeasurementinputer'));

      request.headers.addAll(client.headers);

      request.body = jsonEncode({
        'height': height.text,
        'weight': weight.text,
        'bust': bust.text,
        'stomach': stomach.text,
        'chest': chest.text,
        'calves': calves.text,
        'hips': hips.text,
        'arm': arm.text,
        'thighs': thigh.text,
        'user_id': user['id'],
        "bustunit": "CM",
        "stomachunit": "CM",
        "chestunit": "CM",
        "calvesunit": "CM",
        "hipsunit": "CM",
        "weightunit": "LB",
        "armunit": "CM",
        "thighsunit": "CM",
        "heightunit": "M",
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        var dt = jsonDecode(await response.stream.bytesToString());
        print(dt);
        showSnack('Success', 'Measurement saved successfully');
      }
      else {
        print(response.reasonPhrase);
      }
    }

    return Scaffold(
        backgroundColor: Color(0xffE2E2E2),
        body: SafeArea(
          child: Container(

            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text('A'),
                      ),
                      title: Text(user['name']),
                      subtitle: Text(user['email']),
                      trailing: IconButton(
                        icon: Icon(Icons.close, color: Colors.black),
                        onPressed: () => Get.back(),
                      )
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text('Body Measurements'.toUpperCase(), style: TypographyStyles.title(19)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: weight,
                              decoration: InputDecoration(
                                labelText: 'Weight',
                                labelStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              controller: height,
                              decoration: InputDecoration(
                                labelText: 'Height',
                                labelStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: bust,
                              decoration: InputDecoration(
                                labelText: 'Bust',
                                labelStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              controller: hips,
                              decoration: InputDecoration(
                                labelText: 'Hips',
                                labelStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: chest,
                              decoration: InputDecoration(
                                labelText: 'Chest',
                                labelStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              controller: thigh,
                              decoration: InputDecoration(
                                labelText: 'Thighs',
                                labelStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: stomach,
                              decoration: InputDecoration(
                                labelText: 'Stomach',
                                labelStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              controller: arm,
                              decoration: InputDecoration(
                                labelText: 'Arm',
                                labelStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: calves,
                              decoration: InputDecoration(
                                labelText: 'Calves',
                                labelStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: Get.width*0.8,
                      height: 56,
                      child: ElevatedButton(
                        style: ButtonStyles.bigBlackButton(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 8),
                            Text('Update')
                          ],
                        ),
                        onPressed: (){
                          saveMeasurement();
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            )
          ),
        )
    );
  }
}
