import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Auth/UserTypeSelection.dart';
import 'package:north_star/Models/AuthUser.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/Themes.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:north_star/UI/Layout.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    RxBool loading = false.obs;
    void toggle(){
      loading.value = !loading.value;
    }

    TextEditingController userName = new TextEditingController();
    TextEditingController password = new TextEditingController();

    void showSnack(String title, String message){
      Get.snackbar(
          title,
          message,
          margin: const EdgeInsets.all(16),
          backgroundColor: Themes.mainThemeColor.shade900,
          colorText: Colors.white
      );
    }

    void signIn() async{
      if(!userName.text.isEmail){
        showSnack('Incorrect Email', 'Please use the correct email address');
      } else if (password.text.isEmpty){
        showSnack('Incorrect Password', 'Please use the correct password');
      } else {
        toggle();
        var headers = {'Accept': 'application/json'};
        var request = http.MultipartRequest('POST', Uri.parse(HttpClient.baseURL + '/api/login'));
        request.fields.addAll({
          'email': userName.text, //'doctor@northstar.com',//'client@northstar.com',//'admin@northstar.com',
          'password': password.text
        });

        request.headers.addAll(headers);
        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          var res = jsonDecode(await response.stream.bytesToString());



          client.changeToken(res['access_token']);
          client.changeExpireIn(res['expires_in']);
          client.changeID(res['user_id']);

          authUser.fill(
              res['user_id'],
              res['profile']['roleId'],
              res['profile']['name'],
              res['role'][0],
              res['access_token']
          );

          toggle();
          print('Auth Success!');
          print(res);

          SharedPreferences.getInstance().then((prefs) async{
            await prefs.setBool('auth', true);
            await prefs.setInt('id', res['user_id']);
            await prefs.setInt('roleId', res['profile']['roleId']);
            await prefs.setString('name', res['profile']['name']);
            await prefs.setString('token', res['access_token']);
            await prefs.setString('role', res['role'][0]);
            await prefs.setInt('expire', res['expires_in']);
          }).then((value){
            Get.offAll(()=>Layout());
          });
        }
        else {
          print(await response.stream.bytesToString());
          showSnack('Incorrect Email and/or Password', 'Please use the correct password and email');
          toggle();
        }
      }
    }

    void devFastSignIn() async{
      toggle();
      var headers = {'Accept': 'application/json'};
      var request = http.MultipartRequest('POST', Uri.parse(HttpClient.baseURL + '/api/login'));
      request.fields.addAll({
        'email':'doctor@northstar.com', //'doctor@northstar.com',//'client@northstar.com',//'admin@northstar.com',
        'password': 'password'
      });

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = jsonDecode(await response.stream.bytesToString());

        client.changeToken(res['access_token']);
        client.changeExpireIn(res['expires_in']);
        client.changeID(res['user_id']);

        authUser.fill(
          res['user_id'],
          res['profile']['roleId'],
          res['profile']['name'],
          res['role'][0],
          res['access_token']
        );

        toggle();
        print('Auth Success!');
        print(res);

        SharedPreferences.getInstance().then((prefs) async{
          await prefs.setBool('auth', true);
          await prefs.setInt('id', res['user_id']);
          await prefs.setInt('roleId', res['profile']['roleId']);
          await prefs.setString('name', res['profile']['name']);
          await prefs.setString('token', res['access_token']);
          await prefs.setString('role', res['role'][0]);
          await prefs.setInt('expire', res['expires_in']);
        }).then((value){
          Get.offAll(()=>Layout());
        });
      }
      else {
        print(await response.stream.bytesToString());
        showSnack('Incorrect Email and/or Password', 'Please use the correct password and email');
        toggle();
      }
    }

    return Scaffold(
        body: Container(
      height: Get.height,
      child: Stack(
        children: [
          Container(
            width: Get.width,
            child: Image.asset(
              'assets/images/login.png',
              fit: BoxFit.fitWidth,
            ),
          ),

          Positioned(
            left: 32,
            right: 32,
            bottom: 72,
            child: Container(
              child: Card(
                shape: Themes().roundedBorder(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: Get.width * 0.5,
                            child: Image.asset(
                              'assets/logo_black.png',
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text('Login', style: TypographyStyles.title(28)),
                        ],
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: userName,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            labelText: 'Email Address',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)
                            )),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: password,
                        style: TextStyle(fontSize: 18),
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password',

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)
                            )),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          TextButton(
                            child: Text(
                              'Forgot Password?',
                            ),
                            onPressed: () {
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: Get.width,
                        height: 58,
                        child: Obx((){
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: Themes().roundedBorder(12),
                                primary: Color(0xFF1C1C1C)),
                            child: loading.value ? Center(
                              child: CircularProgressIndicator(),
                            ):Text(
                              'Sign In',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            onPressed: () {
                              //devFastSignIn();
                              signIn();
                            },
                          );
                        }),
                      )
                    ],
                  ),
                ),
              )
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?',
                      style: TextStyle(color: Colors.black)),
                  TextButton(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    onPressed: () {
                      Get.to(() => UsertypeSelection());
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
