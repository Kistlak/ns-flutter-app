import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Styles/TypographyStyles.dart';

class HomeWidgetResources extends StatelessWidget {
  const HomeWidgetResources({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String sampleText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

    return Scaffold(
      appBar: AppBar(title: Text('Resources')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Divider(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: Get.width,
              height: 64,
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Color(0xffF2F2F2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                    )
                ),
                onPressed: (){},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Media Library',style: TypographyStyles.normalText(16, Colors.black),),
                    Icon(Icons.arrow_forward,color: Colors.black,)
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: Get.width,
              height: 64,
              child: TextButton(
                style: TextButton.styleFrom(

                    backgroundColor: Color(0xffF2F2F2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                    )
                ),
                onPressed: (){},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Newsletter',style: TypographyStyles.normalText(16, Colors.black),),
                    Icon(Icons.arrow_forward, color: Colors.black,)
                  ],
                ),
              ),
            ),
            ExpansionTile(
              title: Text('Exercise Plan'),
              children: [
                Text(sampleText)
              ],
            ),
            ExpansionTile(
              title: Text('General Info'),
              children: [
                Text(sampleText)
              ],
            ),ExpansionTile(
              title: Text('Diets'),
              children: [
                Text(sampleText)
              ],
            ),
            ExpansionTile(
              title: Text('Acute'),
              children: [
                Text(sampleText)
              ],
            )
          ],
        ),
      ),
    );
  }
}
