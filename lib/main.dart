import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Auth/AuthHome.dart';
import 'package:north_star/Styles/Themes.dart';
import 'package:north_star/UI/Layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Models/AuthUser.dart';
import 'Plugins/HttpClient.dart';

bool isFirst = true;
bool isAuth = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await checkAuth();
  runApp(NorthStar());
}

Future checkAuth() async {
  print('Checking First Install');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isFirst = prefs.getBool('isFirst') ?? true;

  bool authStatus = prefs.getBool('auth') ?? false;
  print(authStatus);
  if (authStatus) {
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
    isAuth = true;
  } else {
    isAuth = false;
  }
  return true;
}

class NorthStar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'North Star',
        defaultTransition: Transition.fade,
        transitionDuration: Duration(milliseconds: 512),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Themes.mainThemeColor,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme:
                AppBarTheme(elevation: 0, backgroundColor: Colors.white)),
        home: isAuth ? Layout() : AuthHome());
  }
}
