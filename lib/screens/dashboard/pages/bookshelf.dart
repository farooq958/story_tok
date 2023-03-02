import 'package:flutter/material.dart';

class MyBookshelfPage extends StatefulWidget {
  const MyBookshelfPage({Key? key}) : super(key: key);

  @override
  State<MyBookshelfPage> createState() => _MyBookshelfPageState();
}

class _MyBookshelfPageState extends State<MyBookshelfPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.grey,
    
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Container(
        child: Center(
          child: Column(
            children: [
              //
              Text("Bookshelf")
            ],
          ),
        ),
      ),
    );
  }
}
