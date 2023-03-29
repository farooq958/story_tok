
import 'package:flutter/material.dart';

import '../../../global/constants/color_resources.dart';

class TextFiledBio extends StatefulWidget {
  final controllerBio;
  final String bio;
   TextFiledBio({Key? key, required this.controllerBio,required this.bio}) : super(key: key);

  @override
  State<TextFiledBio> createState() => _TextFiledBioState();
}

class _TextFiledBioState extends State<TextFiledBio> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('####### ${widget.bio}');
    widget.controllerBio.text = widget.bio;
    setState(() {
      widget.controllerBio;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
      child: Stack(
          children:[
            Image.asset('assets/images/bio.png'),
            Padding(
              padding: const EdgeInsets.only(top:40.0,left: 10.0,right: 10.0),
              child: Container(
                height: 80,
                child: TextField(
                  controller: widget.controllerBio,
                  maxLines: 100,
                  style: TextStyle(
                      color: ColorResources.colorBlack, fontWeight: FontWeight.w800),
                  decoration: InputDecoration(
                    // hintText: 'Enter a message',
                    hintStyle: TextStyle(
                        color: ColorResources.colorBlack.withOpacity(0.5), fontWeight: FontWeight.w800),
                    hintText: "enter bio",
                    filled: true,
                    fillColor: ColorResources.textfieldProfileBG,
                    border: InputBorder.none,
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10.0),
                    // ),
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide:
                    //   BorderSide(color: ColorResources.colorBlack, width: 3.0),
                    // ),
                    // focusedBorder: OutlineInputBorder(
                    //   borderSide:
                    //   BorderSide(color: ColorResources.colorBlack, width: 3.0),
                    // ),
                    // suffixIcon: IconButton(
                    //   onPressed: widget.controllerProfile.clear,
                    //   icon: Icon(Icons.clear, size: 30, color: ColorResources.colorBlack),
                    // ),
                  ),
                ),
              ),
            )
          ] ),
    );
  }
}
