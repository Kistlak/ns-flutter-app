import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Models/AuthUser.dart';
import 'package:north_star/Styles/IcoMoon.dart';
import 'package:north_star/UI/Chats/ChatHome.dart';
import 'package:north_star/UI/Gym.dart';
import 'package:north_star/UI/Home.dart';
import 'package:north_star/UI/Members.dart';
import 'package:north_star/UI/Members/UserView_Bio.dart';
import 'package:north_star/UI/Members/UserView_Progress.dart';
import 'package:north_star/UI/PrivateDoctor/DoctorHome.dart';
import 'package:north_star/UI/PrivateTrainer/TrainerProfile.dart';
import 'package:north_star/UI/PrivateUser/ClientCalories.dart';
import 'package:north_star/UI/PrivateUser/ClientProfile.dart';
import 'package:north_star/UI/Wallet.dart';


class Layout extends StatelessWidget {
  const Layout({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    RxInt currentPage = 0.obs;
    Rx<PageController> pgController = PageController(initialPage: 0).obs;

    Widget bNavBar(){
      return Obx((){
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          currentIndex: currentPage.value,
          onTap: (int index){
            currentPage.value = index;
            pgController.value.jumpToPage(index);
          },
          items: authUser.role != 'general_user' ? [
            BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(IcoMoon.home)
            ),
            authUser.role == 'trainer' ? BottomNavigationBarItem(
                label: 'Members',
                icon: Icon(IcoMoon.members)
            ): BottomNavigationBarItem(
              label: 'Calories',
              icon: Icon(Icons.local_fire_department)
              ),
            authUser.role == 'trainer' ? BottomNavigationBarItem(
                label: 'eWallet',
                icon: Icon(IcoMoon.wallet)
            ):BottomNavigationBarItem(
                label: 'Progress',
                icon: Icon(Icons.addchart)
            ),
            authUser.role == 'trainer' ? BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(Icons.account_circle)
            ):BottomNavigationBarItem(
                label: 'Me',
                icon: Icon(Icons.supervised_user_circle)
                ),
          ] : [
            BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(IcoMoon.home)
            ),
            BottomNavigationBarItem(
                label: 'Me',
                icon: Icon(Icons.supervised_user_circle)
            ),
          ],
        );
      });
    }


    if (authUser.role == 'doctor'){
      return DoctorHome();
    } else {
      return Scaffold(
        bottomNavigationBar: bNavBar(),
        appBar: AppBar(
          title: Container(
            height: 28,
            child: Image.asset('assets/logo_black.png', fit: BoxFit.fitHeight,),
          ),
          actions: [
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.notifications, size: 28),
            ),
            IconButton(
              onPressed: (){
                Get.to(()=>ChatHome());
              },
              icon: Icon(IcoMoon.messages),
            )
          ],
        ),
        body: Obx((){
          return PageView(
            onPageChanged: (index){
              currentPage.value = index;
            },
            controller: pgController.value,
            children: authUser.role != 'general_user' ? [
              Home(),
              authUser.role == 'trainer' ?  Members() : UserCalories(),
              authUser.role == 'trainer' ? Wallet() : UserViewProgress(),
              authUser.role == 'trainer' ? TrainerProfile(): ClientProfile(),
            ] : [
              Home(),
              ClientProfile(),
            ],
          );
        }),
      );
    }
  }
}
