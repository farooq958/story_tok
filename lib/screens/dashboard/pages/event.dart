import 'package:flutter/material.dart';


class MyEventPage extends StatefulWidget {
 const MyEventPage({Key? key}) : super(key: key);

  @override
  State<MyEventPage> createState() => _MyEventPageState();
}

class _MyEventPageState extends State<MyEventPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
    child: Column(children: [ 
      //
      Text("MyEventPage")
     ],),
    );
  }
}