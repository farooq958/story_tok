import 'package:flutter/material.dart';
import 'package:storily/screens/dashboard/widgets/flooting_menu.dart';

class MyBookshelfPage extends StatefulWidget {
  const  MyBookshelfPage({Key? key}) : super(key: key);

  @override
  State<MyBookshelfPage> createState() => _MyBookshelfPageState();
}

class _MyBookshelfPageState extends State<MyBookshelfPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey,

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

          // personFlootBtn(context),
          // Text("name"),
          SizedBox(height: 30),
        ],
      ),
      body: SafeArea(
      
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Column(children: [ ],),
                  Text(
                    'Following',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.normal,
                    
                    ),
                  ),
                  SizedBox(width: 7),
                  Container(
                    color: Colors.black,
                    height: 10,
                    width: 1.0,
                  ),
                  SizedBox(width: 7),
                  Text(
                    'For You',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                     
                    ),
                  )
                ],
              ),

              //
              
            ],
          ),
        ),
      ),
    );
  }
}
