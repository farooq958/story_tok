import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
                    ),
                    addNewBookWidget(context, Assets.subMenuRedText),
                    addNewBookWidget(context, Assets.subMenuExit),
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
                        context: context, label: "Please Select Upload Format"),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Stack(
                          children: [
                            // if (!addFiles)
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
                        Stack(
                          children: [
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
                        )
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

  updateWidget(value) {
    setState(() {
      addFiles = value;
    });
  }
}
