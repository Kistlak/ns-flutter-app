import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/Themes.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:north_star/Utils/PopUps.dart';

class BodyFatCalculator extends StatelessWidget {
  const BodyFatCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool ready = true.obs;
    RxMap result = {}.obs;
    TextEditingController fua = TextEditingController();
    TextEditingController bua = TextEditingController();
    TextEditingController sow = TextEditingController();
    TextEditingController bbs = TextEditingController();
    TextEditingController age = TextEditingController();
    RxString gender = 'Male'.obs;
    RxString error = ''.obs;

    void saveResult() async{
      ready.value = false;
      var request = http.MultipartRequest('POST', Uri.parse('http://139.59.111.170/api/bodyfatcalculator'));
      request.headers.addAll(client.getHeader());

      request.fields.addAll({
        "frontupperarm": fua.text,
        "backofupperarm": bua.text,
        "sideofthewaist": sow.text,
        "backbelowshoulderblade": bbs.text,
        "age": age.text,
        "gender": gender.value
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = jsonDecode(await response.stream.bytesToString());
        print(res);
        result.value = res;
        ready.value = true;
      } else {
        var res = jsonDecode(await response.stream.bytesToString());
        ready.value = true;
      }
    }

    void getResult(){
      if(fua.text !='' && bua.text != '' && sow.text != '' && bbs.text != ''){
        saveResult();
      } else {
        showSnack('Empty Values!', 'Please fill all the values');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Body Fat Calculator'),
      ),
      body: Column(
        children: [
          Obx(()=>Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Gender'),
              Radio(groupValue: gender.value, onChanged: (value) {
                gender.value = value.toString();
              }, value: 'Male', ),
              Text('Male'),
              Radio(groupValue: gender.value, onChanged: (value) {
                gender.value = value.toString();
              }, value: 'Female',),
              Text('Female'),
            ],
          )),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text('Age'),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: age,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Age',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text('Front of upper arm'),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: fua,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'millimeters',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text('Back of upper arm'),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: bua,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'millimeters',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text('Side of the Waist'),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: sow,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'millimeters',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text('Back Below Shoulder blade'),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: bbs,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'millimeters',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: Get.width,
            height: 58,
            padding: EdgeInsets.symmetric(horizontal: 16),
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
              Obx(()=> Text(result['body_fat_result']  ?? '', style: TypographyStyles.title(16),)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(()=> Text(result['body_fat'] == null ? '' : result['body_fat'].toString(), style: TypographyStyles.title(16),)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(()=> Text(result['0'] == null ? '' : result['0'].toString(), style: TypographyStyles.title(16),)),
            ],
          ),
        ],
      ),
    );
  }
}

