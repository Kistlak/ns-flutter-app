import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Styles/ButtonStyles.dart';
import 'package:north_star/Styles/TypographyStyles.dart';

class StoreItemView extends StatelessWidget {
  const StoreItemView({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StoreItemView'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: Get.width,
            height: Get.height / 2,
            color: Colors.amberAccent,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Item #$index', style: TypographyStyles.text(18),),
                        Text('LKR $index\00.00',style: TypographyStyles.title(18),)
                      ],
                    ),
                    ElevatedButton(
                        style: ButtonStyles.bigBlackButton(),
                        onPressed: (){}, child: Text('Buy Now'))
                  ],
                ),
                SizedBox(height: 16),
                Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
                textAlign: TextAlign.justify,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
