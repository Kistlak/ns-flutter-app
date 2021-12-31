import 'package:flutter/material.dart';
import 'package:north_star/Styles/TypographyStyles.dart';

class UserCalories extends StatelessWidget {
  const UserCalories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 8,),
                Icon(Icons.local_fire_department, size: 40,),
                SizedBox(width: 8,),
                Text('Calories', style: TypographyStyles.title(24))
              ],
            ),
            Container(
              child: Card(
                  margin: EdgeInsets.all(16),
                  elevation: 0,
                  color: Color(0xffF2F2F2),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Eaten'),
                        Text('0 Cal', style: TypographyStyles.title(24),),
                        SizedBox(height: 16),
                        Text('Remaining'),
                        Text('0 Cal', style: TypographyStyles.title(24),),
                        SizedBox(height: 16),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Carbs'),
                                  Text('250/300g'),
                                ],
                              ),
                              VerticalDivider(width: 1,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Fat'),
                                  Text('250/300g'),
                                ],
                              ),
                              VerticalDivider(width: 1,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Proteins'),
                                  Text('250/300g'),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (_,index){
                    return Card(
                      color: Color(0xffF2F2F2),
                      elevation: 2,
                      child: ListTile(
                        title: Text('Meal $index'),
                        subtitle: Text('0 Cal'),
                        trailing: IconButton(
                          icon: Icon(Icons.add,color: Colors.black,),
                          onPressed: (){},
                        ),
                      ),
                    );
                  },
                ),
              )
            )
          ])
    );
  }
}
