import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storily/components/page_uploader.dart';
import '../global/constants/assets.dart';
import 'common_upload_book_format.dart';

enum ImageSourceType { gallery, camera }

class UploadBookFormat extends StatefulWidget {
  @override
  UploadBookFormatState createState() => UploadBookFormatState();
}

class UploadBookFormatState extends State<UploadBookFormat>
    with SingleTickerProviderStateMixin {
  List imagesPath = [];
  var total = 0;
  var imagePicker;
  bool addFiles = false;
  bool addFilesForPDF = false;

  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 1000,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
    imagePicker = new ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                uploadBookFormatHeader(
                  '12/03/2023',
                  'Hi, Team',
                  'Welcome to your board',
                ),
                SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    addNewBookWidget(context, Assets.subMenuRedBox,
                        MediaQuery.of(context).size.width * 0.90),
                    addNewBookWidget(context, Assets.subMenuRedText,
                        MediaQuery.of(context).size.width * 0.90),
                    addNewBookWidget(context, Assets.subMenuExit,
                        MediaQuery.of(context).size.width * 0.90),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 6,
                      child: Image.asset(Assets.backgroundRectangleDots),
                    ),
                  ],
                ),
                Column(
                  children: [
                    uploadText(
                        context: context,
                        label: "Please Select Upload Format",
                        fontSize: 30.0),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          // onFocusChange: (c) {
                          //   log(c.toString());
                          //   // addFilesForPDF = false;
                          //   setState(() {});
                          // },
                          onHighlightChanged: (c) {
                            log(c.toString());
                            addFilesForPDF = c;
                            setState(() {});
                          },

                          child: _animatedButton(
                            boolVal: addFilesForPDF,
                            imageUrl: Assets.redDropShadow,
                            context: context,
                            textImageUrl: Assets.pdfTextImage,
                            boxImageUrl: Assets.uploadRedBox,
                            addFilesImageUrl: Assets.redAddFiles,
                          ),
                          onTap: () {
                            // log("donee");
                            // addFilesForPDF = !addFilesForPDF;
                            setState(() {});
                          },
                        ),
                        GestureDetector(
                          onTapDown: _tapDown,
                          onTapUp: _tapUp,
                          child: _animatedButton(
                            boolVal: addFiles,
                            imageUrl: Assets.redDropShadow,
                            context: context,
                            textImageUrl: Assets.imageTextImage,
                            boxImageUrl: Assets.uploadRedBox,
                            addFilesImageUrl: Assets.redAddFiles,
                          ),
                          onTap: () {
                            setState(() {
                              addFiles = true;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    // _controller.forward();
  }

  void _tapUp(TapUpDetails details) async {
    // await _controller.reverse();
    getEventList();
  }

  getEventList() {
    if (addFiles) {
      setState(() {
        addFiles = false;
      });
    }
    if (addFilesForPDF) {
      setState(() {
        addFilesForPDF = false;
      });
    }

    // Future.delayed(Duration(milliseconds: 500), () {
    //   Navigator.push(
    //     context,
    //     PageRouteBuilder(
    //       pageBuilder: (_, __, ___) => PageUploader(),
    //       transitionDuration: Duration(milliseconds: 500),
    //       transitionsBuilder: (_, a, __, c) =>
    //           FadeTransition(opacity: a, child: c),
    //     ),
    //     /*MaterialPageRoute(
    //     builder: (context) => PageUploader(),
    //   ),*/
    //   );
    // }

    // );
  }

  _animatedButton(
      {boolVal,
      imageUrl,
      context,
      boxImageUrl,
      textImageUrl,
      addFilesImageUrl}) {
    return Container(
      decoration: boxDecoration(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // TweenAnimationBuilder<Offset>(
          //   curve: Curves.slowMiddle,
          //   tween: Tween<Offset>(
          //       begin: boolVal ? Offset(0, 0) : Offset(0, 0),
          //       end: boolVal ? Offset(-70, -60) : Offset(10, 5)),
          //   duration: Duration(milliseconds: 500),
          //   builder: (context, value, child) {
          //     return Transform.translate(
          //         offset: Offset(value.dx.clamp(0, 10), value.dy.clamp(-3, 5)),
          //         child: child!);
          //   },
          //   child: dropShadowWidget(
          //     imageUrl: imageUrl,
          //     context: context,
          //   ),
          // ),
          dropShadowWidget(
            imageUrl: imageUrl,
            context: context,
          ),
          TweenAnimationBuilder<Offset>(
            curve: Curves.bounceInOut,
            tween: Tween<Offset>(
                begin: boolVal ? Offset(0, 0) : Offset(0, 0),
                end: boolVal ? Offset(10, 5) : Offset(-70, -60)),
            duration: Duration(milliseconds: 50),
            builder: (context, value, child) {
              return Transform.translate(
                  offset: Offset(value.dx.clamp(0, 10), value.dy.clamp(-3, 5)),
                  child: child!);
            },
            child: addFilesWidget(
              boxImageUrl: boxImageUrl,
              textImageUrl: textImageUrl,
              context: context,
              addFilesImageUrl: addFilesImageUrl,
              imageHeight: MediaQuery.of(context).size.height * 0.06,
            ),
          ),
        ],
      ),
    );
  }
}
