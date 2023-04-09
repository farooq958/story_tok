import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:storily/screens/dashboard/widgets/flooting_menu.dart';

import '../../../controllers/main_content_controller.dart';

class MyBookshelfPage extends StatefulWidget {
  const  MyBookshelfPage({Key? key}) : super(key: key);

  @override
  State<MyBookshelfPage> createState() => _MyBookshelfPageState();
}

class _MyBookshelfPageState extends State<MyBookshelfPage> {
String? deiceCurrentTime;
DateTime deviceTime = DateTime.now().toLocal();
var formattedDate = DateFormat('H');

@override
  void initState() {
    deiceCurrentTime = formattedDate.format(deviceTime);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainContentController>(builder: (contentController) {
      return Scaffold(
        /* backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0x00000000),
          elevation: 0,       
        ), */
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            authorFlootBtn(context),
            Text("@user"),
            SizedBox(height: 5),
            likeFlootBtn(context),
            Text("132"),
            SizedBox(height: 5),
            commentFlootBtn(context),
            Text("23"),
            SizedBox(height: 5),
            buyFlootBtn(context),
            SizedBox(height: 5),
            SizedBox(height: 30),
          ],
        ),
        body: SafeArea(
          child: Container(
          decoration: BoxDecoration(
            image:  int.parse(deiceCurrentTime!) <  7
              ? DecorationImage(image: AssetImage("assets/images/book_dart.png"), fit: BoxFit.cover)
              : int.parse(deiceCurrentTime!) > 17 
              ? DecorationImage(image: AssetImage("assets/images/book_dart.png"), fit: BoxFit.cover)
            : DecorationImage(image: AssetImage("assets/images/book_light.png"), fit: BoxFit.cover),
          ),
            padding: EdgeInsets.only(top: 20),
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                mainAxisExtent: 250,
              ),
              children: contentController.bookSource.audiobookList
                  .map(
                    (bookData) => Column(
                      children: [
                        Expanded(
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            child: Image.network(
                              bookData.pageUrl.first.pageUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("${bookData.title}"),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );
    });
  }
}
