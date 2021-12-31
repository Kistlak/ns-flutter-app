import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/Themes.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:north_star/Utils/PopUps.dart';
import 'package:http/http.dart' as http;

class BloodPressure extends StatefulWidget {
  const BloodPressure({Key? key, this.user}) : super(key: key);
  final user;

  @override
  _BloodPressureState createState() => _BloodPressureState();
}

class _BloodPressureState extends State<BloodPressure> {
  @override
  Widget build(BuildContext context) {
    RxBool ready = true.obs;
    RxMap result = {}.obs;
    TextEditingController systolicController = TextEditingController();
    TextEditingController diastolicController = TextEditingController();

    void saveResult() async{
      ready.value = false;
      var request = http.MultipartRequest('POST', Uri.parse('http://139.59.111.170/api/bloodpressureCalculator'));
      request.headers.addAll(client.getHeader());

      request.fields.addAll({
        'Systopic_mm_Hg': systolicController.text,
        'lastolio_mm_Hg': diastolicController.text,
        'user_id': widget.user['id'].toString(),
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        var res = jsonDecode(await response.stream.bytesToString());
        print(res);
        result.value = res;
        ready.value = true;
      } else {
        print(await response.stream.bytesToString());
        ready.value = true;
      }
    }

    void getResult(){
      if(systolicController.text !='' && diastolicController.text != ''){
        saveResult();
      } else {
        showSnack('Empty Values!', 'Please fill all the values');
      }
    }

    return Scaffold(
      backgroundColor: Color(0xffE2E2E2),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text('A'),
                        ),
                        title: Text(widget.user['name']),
                        subtitle: Text(widget.user['email']),
                        trailing: IconButton(
                          icon: Icon(Icons.close, color: Colors.black),
                          onPressed: () => Get.back(),
                        )
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: systolicController,
                            decoration: InputDecoration(
                              labelText: 'Systolic',
                              hintText: '120',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: diastolicController,
                            decoration: InputDecoration(
                              labelText: 'Diastolic',
                              hintText: '80',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: Get.width,
                      height: 58,
                      child: Obx(() {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: Themes().roundedBorder(12),
                              primary: Color(0xFF1C1C1C)),
                          child: !ready.value
                              ? Center(
                            child: CircularProgressIndicator(),
                          )
                              : Text(
                            'Calculate',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          onPressed: () {
                            getResult();
                          },
                        );
                      }),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Obx(()=> Text(result['value'] ?? '', style: TypographyStyles.title(16),)))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}
