import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storily/screens/dashboard/widgets/flooting_menu.dart';

import '../../../controllers/main_content_controller.dart';

class MyBookshelfPage extends StatefulWidget {
  const MyBookshelfPage({Key? key}) : super(key: key);

  @override
  State<MyBookshelfPage> createState() => _MyBookshelfPageState();
}

class _MyBookshelfPageState extends State<MyBookshelfPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainContentController>(builder: (contentController) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(""),
        ),
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
