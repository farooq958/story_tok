import 'package:flutter/material.dart';
import '../../../global/constants/color_resources.dart';

class TextFiledClear extends StatefulWidget {
  final controllerProfile;
  final String name;

  TextFiledClear({Key? key, required this.controllerProfile,required this.name}) : super(key: key);

  @override
  State<TextFiledClear> createState() => _TextFiledClearState();
}

class _TextFiledClearState extends State<TextFiledClear> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('####### ${widget.name}');
    widget.controllerProfile.text = widget.name;
    setState(() {
      widget.controllerProfile;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 30),
      child: Stack(
        children:[
          Container(
           // height: 50,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
                'assets/images/profile/submenu_purple_box.png'),
          ),
          // Container(
          //   height: 50,
          //   width: MediaQuery.of(context).size.width,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage(
          //           'assets/images/profile/submenu_purple_box.png'),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(top:10.0,left: 10,right: 10),
            child: TextField(
            controller: widget.controllerProfile,
            style: TextStyle(
                color: ColorResources.colorBlack, fontWeight: FontWeight.w800),
            decoration: InputDecoration(
              // hintText: 'Enter a message',
              hintStyle: TextStyle(
                  color: ColorResources.colorBlack, fontWeight: FontWeight.w800),
              hintText: "My Profile".toUpperCase(),
              border: InputBorder.none,
              // filled: true,
              // fillColor: ColorResources.textfieldProfileBG,
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
              // enabledBorder: OutlineInputBorder(
              //   borderSide:
              //       BorderSide(color: ColorResources.colorBlack, width: 2.0),
              // ),
              // focusedBorder: OutlineInputBorder(
              //   borderSide:
              //       BorderSide(color: ColorResources.colorBlack, width: 3.0),
              // ),
              suffixIcon: IconButton(
                onPressed: widget.controllerProfile.clear,
                icon: Icon(Icons.clear, size: 30, color: ColorResources.colorBlack),
              ),
            ),
        ),
          ),
      ]
      ),
    );
  }
}
