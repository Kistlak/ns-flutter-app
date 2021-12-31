import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetWorkouts/AddWorkouts.dart';

class Schedules extends StatelessWidget {
  const Schedules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Schedules'),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(()=>AddWorkouts());
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Material(
              color: Color(0xFFF6F6F6),
              child: TextField(
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    hintText: 'Search Schedules...',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (_,index){
                return Container(
                  padding: const EdgeInsets.all(8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Schedule $index',style: TypographyStyles.title(18),),
                          Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
                          SizedBox(height: 8),
                          Text('Oct 25 2021 | Trainer Name')
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
