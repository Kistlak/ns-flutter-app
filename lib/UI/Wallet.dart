import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Models/AuthUser.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/IcoMoon.dart';
import 'package:north_star/Styles/Themes.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:http/http.dart' as http;

class Wallet extends StatelessWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    RxBool ready = false.obs;
    RxDouble balance = 0.0.obs;

    var data = {};
    void getTransactionData() async{
      var request = http.Request('GET', Uri.parse(HttpClient.baseURL + '/api/me/ewallets/transactions'));
      request.headers.addAll(client.getHeader());

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = jsonDecode(await response.stream.bytesToString());
        data = res;
        //print(res);
        ready.value = true;
      } else {
        print(response.reasonPhrase);
        ready.value = true;
      }
    }

    void getWalletData() async{
      var request = http.Request('GET', Uri.parse(HttpClient.baseURL + '/api/me/wallets'));
      request.headers.addAll(client.getHeader());

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = jsonDecode(await response.stream.bytesToString());
        balance.value = double.parse(res.toString());
        getTransactionData();
        print(res);
      } else {
        print(response.reasonPhrase);
        ready.value = true;
      }
    }



    getWalletData();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  authUser.role != 'trainer' ?
                  IconButton(onPressed: (){
                    Get.back();
                  }, icon: Icon(Icons.arrow_back)): SizedBox(),
                  Container(
                    child: Icon(IcoMoon.wallet),
                  ),
                  SizedBox(width: 8),
                  Text('eWallet', style: TypographyStyles.title(21),)
                ],
              ),
              SizedBox(height: 8),
              Container(
                width: Get.width,
                child: Card(
                  margin: const EdgeInsets.all(0),
                  shape: Themes().roundedBorder(16),
                  color: Color(0xffF8F8F8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 16),
                      Text('Available Balance', style: TypographyStyles.title(27)),
                      Obx(()=>ready.value ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('\$ ', style: TypographyStyles.title(32)),
                          Text( balance.toString(), style: TypographyStyles.title(48)),
                        ],
                      ): Center(child: CircularProgressIndicator())),
                      Text('Last update on ' + DateTime.now().toIso8601String().split('T')[0]
                          +' '+ DateTime.now().toIso8601String().split('T')[1].split('.')[0]
                          , style: TypographyStyles.title(16)),
                      SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.only(left: 12,right: 12),
                        width: Get.width,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            onPrimary: Colors.white,
                            shape: Themes().roundedBorder(16),
                          ),
                          child: Text('TOPUP CREDITS'),
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Transaction History', style: TypographyStyles.title(21),)
                ],
              ),
              SizedBox(height: 8),
              Expanded(
                child: data.length == 0 ? Center(
                  child: Text('No Transaction History', style: TypographyStyles.text(18),),
                ): ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context,index){

                    return ListTile(
                      title: Text('Deposit'),
                      subtitle: Text('July 21, 2021 12:25'),
                      trailing: Text('\$$index\000',style: TypographyStyles.walletTransactions(16, index % 2),),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
