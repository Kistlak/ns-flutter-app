import 'package:flutter/material.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:north_star/Styles/Themes.dart';

class UserViewHealth extends StatelessWidget {
  const UserViewHealth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('BMI Calculator', style: TypographyStyles.title(21)),
                  Text('Last Updated on: 26th May 2077'),
                  SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color(0xffb6ff92),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Body Mass Index (BMI)',style: TypographyStyles.normalText(14, Colors.green.shade500),),
                            Text('Normal', style: TypographyStyles.boldText(16, Colors.green.shade700),)
                          ],
                        ),
                        Text('21.6', style: TypographyStyles.boldText(24, Colors.green.shade700),),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color(0xffb6ff92),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ponderal  Index (PI)',style: TypographyStyles.normalText(14, Colors.green.shade500),),
                            Text('Normal', style: TypographyStyles.boldText(16, Colors.green.shade700),)
                          ],
                        ),
                        Text('13.46', style: TypographyStyles.boldText(24, Colors.green.shade700),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
                'Health Services Overview',
                style: TypographyStyles.boldText(16, Colors.grey)
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Body Fat Calculator', style: TypographyStyles.title(21)),
                  Text('Last Updated on: 26th May 2077'),
                  SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color(0xffb6ff92),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Body Fat Result',style: TypographyStyles.normalText(14, Colors.green.shade500),),
                            Text('Normal', style: TypographyStyles.boldText(16, Colors.green.shade700),)
                          ],
                        ),
                        Text('21.6%', style: TypographyStyles.boldText(24, Colors.green.shade700),),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color(0xffb6ff92),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Muscle Mass',style: TypographyStyles.normalText(14, Colors.green.shade500),),
                            Text('Normal', style: TypographyStyles.boldText(16, Colors.green.shade700),)
                          ],
                        ),
                        Text('13.46%', style: TypographyStyles.boldText(24, Colors.green.shade700),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Blood Sugar', style: TypographyStyles.title(21)),
                  Text('Last Updated on: 26th May 2077'),
                  SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color(0xffb6ff92),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Fasting Blood Sugar',style: TypographyStyles.normalText(14, Colors.green.shade500),),
                          ],
                        ),
                        Text('Normal', style: TypographyStyles.boldText(24, Colors.green.shade700),),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color(0xfffff9bf),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Post Blood Sugar',style: TypographyStyles.normalText(14, Colors.deepOrange.shade500),),
                          ],
                        ),
                        Text('Impaired Glucose', style: TypographyStyles.boldText(24, Colors.deepOrange),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Blood Pressure', style: TypographyStyles.title(21)),
                  Text('Last Updated on: 26th May 2077'),
                  SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color(0xffffd9bf),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Moderately Increased',style: TypographyStyles.boldText(21, Colors.red),),
                            Text('Possible Hypertension (Stage 2)', style: TypographyStyles.boldText(16, Colors.red),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
