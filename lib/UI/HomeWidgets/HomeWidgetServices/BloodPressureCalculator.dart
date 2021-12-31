import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/Themes.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:north_star/Utils/PopUps.dart';
import 'package:http/http.dart' as http;

class BloodPressureCalculator extends StatefulWidget {
  const BloodPressureCalculator({Key? key}) : super(key: key);

  @override
  _BloodPressureCalculatorState createState() => _BloodPressureCalculatorState();
}

class _BloodPressureCalculatorState extends State<BloodPressureCalculator> {
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
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
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
      appBar: AppBar(
        title: Text('Blood Pressure Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
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
    );
  }
}
