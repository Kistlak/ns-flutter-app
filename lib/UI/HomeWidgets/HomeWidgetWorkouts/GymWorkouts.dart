import 'package:flutter/material.dart';

class GymWorkouts extends StatelessWidget {
  const GymWorkouts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gym Workouts'),),
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
              itemCount: 16,
              itemBuilder: (_,index){
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }
}
