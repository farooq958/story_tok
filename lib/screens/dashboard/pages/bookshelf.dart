import 'package:flutter/material.dart';


class MyBookshelfPage extends StatefulWidget {
 const MyBookshelfPage({Key? key}) : super(key: key);

  @override
  State<MyBookshelfPage> createState() => _MyBookshelfPageState();
}

class _MyBookshelfPageState extends State<MyBookshelfPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
    child: Column(children: [ 
      //
      Text("Bookshelf")
     ],),
    );
  }
}