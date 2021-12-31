import 'package:flutter/material.dart';
import 'package:north_star/Styles/TypographyStyles.dart';

class HomeWidgetCalories extends StatelessWidget {
  const HomeWidgetCalories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calories'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Material(
              borderRadius: BorderRadius.circular(16),
              color: Color(0xFFF6F6F6),
              child: TextField(
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(

                  hintText: 'Search Members',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Color(0xFFF6F6F6),
              child: ListView.builder(
                itemCount: 16,
                itemBuilder: (_,index){
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading:CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.blue),
                                title: Text('John Doe'),
                                subtitle: Text('Weight Loss'),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),

                                    decoration: BoxDecoration(
                                        color: Color(0xffB6FF92),
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Current',
                                            style: TypographyStyles.boldText(12, Color(0xff4f9e1d)),),
                                          Text('2400.00',
                                            style: TypographyStyles.boldText(16, Color(0xff4f9e1d)),)
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Color(0xffF6F6F6),
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Target',
                                            style: TypographyStyles.boldText(12, Color(0xff929292)),),
                                          Text('2400.00',
                                            style: TypographyStyles.boldText(16, Color(0xff929292)),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text('Last Updated at 15th Nov 2021'),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 128,
                                    width: 128,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    width: 128,
                                    height: 128,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 8,
                                      value: 0.8,
                                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    width: 104,
                                    height: 104,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 8,
                                      value: 0.9,
                                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    width: 80,
                                    height: 80,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 8,
                                      value: 0.4,
                                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    width: 56,
                                    height: 56,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 8,
                                      value: 0.8,
                                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

        ],
      ),
    );
  }
}
