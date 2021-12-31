import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Auth/SignIn.dart';
import 'package:north_star/Auth/UserTypeSelection.dart';
import 'package:north_star/Models/AuthUser.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/Themes.dart';
import 'package:north_star/UI/Layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHome extends StatelessWidget {
  const AuthHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    RxBool ready = true.obs;

    void getLoginStatus(){
      SharedPreferences.getInstance().then((prefs){
        bool authStatus = prefs.getBool('auth') ?? false;
        print(authStatus);
        if(authStatus){

          int? userId = prefs.getInt('id');
          int? roleId = prefs.getInt('roleId');
          String? name = prefs.getString('name');
          String? token = prefs.getString('token');
          int? expire = prefs.getInt('expire');
          String? role = prefs.getString('role');

          client.changeToken(token!);
          client.changeExpireIn(expire!);
          client.changeID(userId!);

          authUser.fill(
              userId,
              roleId!,
              name!,
              role!,
              token,
          );
          ready.value = true;
          Get.offAll(()=>Layout());
        } else {
          ready.value = true;
        }
      });
    }


    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            child: Image.asset(
              'assets/images/front.png',
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            bottom: 0,
            top: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Get.width * 0.75,
                  child: Image.asset(
                    'assets/logo_white.png',
                    fit: BoxFit.fitHeight,
                  ),
                )
              ],
            ),
          ),

          Obx(()=> !ready.value ? Positioned(
            left: 0,
            right: 0,
            bottom: 72,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ): Container()),

          Obx(()=> ready.value ? Positioned(
            left: 0,
            right: 0,
            bottom: 72,
            child: Container(
              child: Column(
                children: [
                  Container(
                    width: Get.width * 0.8,
                    height: 58,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        shape: Themes().roundedBorder(12),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFFFC987),
                                  Color(0xFFF1AB56),
                                ]),
                            borderRadius: BorderRadius.circular(12)),
                        child: Container(
                          alignment: Alignment.center,
                          width: Get.width * 0.8,
                          height: 58,
                          child: Text(
                            'Create an Account',
                            style: TextStyle(

                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => UsertypeSelection());
                      },
                    ),
                  )
                ],
              ),
            ),
          ): Container()),
          Obx(()=> ready.value ? Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?',
                      style: TextStyle(color: Colors.white)),
                  TextButton(
                    child: Text('Sign In',
                        style: TextStyle(color: Color(0xFFF3AF5D))),
                    onPressed: () {
                      Get.to(() => SignIn());
                    },
                  )
                ],
              ),
            ),
          ): Container())
        ],
      ),
    );
  }
}
