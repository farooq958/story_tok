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

class UploadBookFormatState extends State<UploadBookFormat> {
  List imagesPath = [];
  var total = 0;
  var imagePicker;
  bool addFiles = false;
  bool addFilesForPDF = false;

  @override
  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
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
                    addNewBookWidget(
                      context,
                      Assets.subMenuRedBox,
                        MediaQuery
                            .of(context)
                            .size
                            .width * 0.90
                    ),
                    addNewBookWidget(context, Assets.subMenuRedText,MediaQuery
                        .of(context)
                        .size
                        .width * 0.90),
                    addNewBookWidget(context, Assets.subMenuExit,MediaQuery
                        .of(context)
                        .size
                        .width * 0.90),
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
                        context: context, label: "Please Select Upload Format", fontSize: 30.0),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          child: Stack(
                            children: [
                              if (!addFilesForPDF)
                                dropShadowWidget(
                                  imageUrl: Assets.redDropShadow,
                                  context: context,
                                ),
                              addFilesWidget(
                                boxImageUrl: Assets.uploadRedBox,
                                textImageUrl: Assets.pdfTextImage,
                                context: context,
                                addFilesImageUrl: Assets.redAddFiles,
                              ),
                            ],
                          ),
                          onTap: () {
                            getEventList("addFilesForPDF");
                          },
                        ),
                        InkWell(
                          child: Stack(
                            children: [
                              if (!addFiles)
                                dropShadowWidget(
                                  imageUrl: Assets.redDropShadow,
                                  context: context,
                                ),
                              addFilesWidget(
                                boxImageUrl: Assets.uploadRedBox,
                                textImageUrl: Assets.imageTextImage,
                                context: context,
                                addFilesImageUrl: Assets.redAddFiles,
                              ),
                            ],
                          ),
                          onTap: () {
                            getEventList("addFiles");
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

  getEventList(val) {
    setState(() {
      if (val == "addFiles") {
        addFiles = true;
      } else {
        addFilesForPDF = true;
      }
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageUploader(),
      ),
    );
  }
}
