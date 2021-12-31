import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Styles/ButtonStyles.dart';
import 'package:north_star/Styles/TypographyStyles.dart';
import 'package:north_star/UI/HomeWidgets/HomeWidgetStore/StoreItemView.dart';

class HomeWidgetStore extends StatelessWidget {
  const HomeWidgetStore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Store'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Color(0xffF2F2F2),
                      child: TextField(
                        controller: searchController,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          hintText: 'Search Items...',
                          prefixIcon: Icon(Icons.search),

                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 48,
                    child: ElevatedButton(
                      style: ButtonStyles.bigFlatBlackButton(),
                      child: Text('Search'),
                      onPressed: (){

                      },
                    ),
                  )
                ],
              )
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: 16,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 256,
                    childAspectRatio: 2 / 2.5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8),
                itemBuilder: (_,index){
                  return Container(
                    child: Card(
                      elevation: 8,
                      child: InkWell(
                        onTap: (){
                          Get.to(()=>StoreItemView(index: index));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Get.width,
                              color: Colors.amberAccent,
                              height: Get.height * 0.2,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Item #$index', style: TypographyStyles.text(18),),
                                  Text('LKR $index\00.00',style: TypographyStyles.title(18),)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
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
