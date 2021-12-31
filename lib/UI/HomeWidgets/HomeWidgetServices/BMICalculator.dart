import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Models/AuthUser.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/Themes.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:http/http.dart' as http;
import 'package:north_star/Utils/PopUps.dart';

class BMICalculator extends StatelessWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxInt gender = 0.obs;
    RxInt unit = 0.obs;
    RxBool ready = true.obs;
    RxMap result = {}.obs;

    TextEditingController height = TextEditingController();
    TextEditingController weight = TextEditingController();

    void saveResult() async{
      ready.value = false;
      var request = http.MultipartRequest('POST', Uri.parse('http://139.59.111.170/api/bmicalculator'));
      request.headers.addAll(client.getHeader());

      request.fields.addAll({
        'weight_unit': unit.value == 0 ? 'LB':'Kg',
        'weight_value': weight.text,
        'height_value': height.text,
        'height_unit': gender.value == 0 ? 'M':'F',
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
      if(height.text !='' && weight.text != ''){
        saveResult();
      } else {
        showSnack('Empty Values!', 'Please fill all the values');
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('BIM Calculator'),),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(()=>Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Units',style: TypographyStyles.title(16)),
                Row(
                  children: [
                    Radio(groupValue: unit.value, onChanged: (value) {
                      unit.value = int.parse(value.toString());
                    }, value: 0, ),
                    Text('Imperial'),
                    Radio(groupValue: unit.value, onChanged: (value) {
                      unit.value = int.parse(value.toString());
                    }, value: 1,),
                    Text('Metric'),
                  ],
                )
              ],
            )),
            Obx(()=>Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Gender',style: TypographyStyles.title(16)),
                Row(
                  children: [
                    Radio(groupValue: gender.value, onChanged: (value) {
                      gender.value = int.parse(value.toString());
                    }, value: 0, ),
                    Text('Male'),
                    Radio(groupValue: gender.value, onChanged: (value) {
                      gender.value = int.parse(value.toString());
                    }, value: 1,),
                    Text('Female'),
                  ],
                )
              ],
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Height',style: TypographyStyles.title(16)),
                Obx(()=>Row(
                  children: [
                    SizedBox(
                      width: Get.width/3,
                      child: TextField(keyboardType: TextInputType.number,
                        controller: height,
                        decoration: InputDecoration(
                            labelText: unit.value == 0 ? 'Inches':'Meters',
                            border: OutlineInputBorder()
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Weight',style: TypographyStyles.title(16)),
                Row(
                  children: [
                    SizedBox(
                      width: Get.width/3,
                      child: Obx(()=>TextField(
                        controller: weight,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: unit.value == 0 ? 'Libs':'Kilograms',

                            border: OutlineInputBorder()
                        ),
                      ))
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 8),
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
                Obx(()=> Text(result['message'] ?? '', style: TypographyStyles.title(16),))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(()=> Text(result['value'].toString() == 'null' ? '':'BMI: '+result['value'].toString(), style: TypographyStyles.title(16),))
              ],
            )
          ],
        ),
      )
    );
  }
}
