import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotify_clone/components/voice_recording.dart';

enum ImageSourceType { gallery, camera }

class PageUploader extends StatefulWidget {
  @override
  PageUploaderState createState() => PageUploaderState();
}

class PageUploaderState extends State<PageUploader> {
  var _images = <File>[];
  var total = 0;
  var imagePicker;

  void _addImage(BuildContext context, var type) async {
    _images.add(null);
    _handleURLButtonPress(context, type, total);
    total++;
  }

  void _handleURLButtonPress(BuildContext context, var type, var i) async {
    /* Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImageFromGalleryEx(type)));*/

    var source = type == ImageSourceType.camera
        ? ImageSource.camera
        : ImageSource.gallery;
    XFile image = await imagePicker.pickImage(
        source: source,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      _images[i] = File(image.path);
    });
  }

  @override
  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pick book pages"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  child: GridView.count(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 2,
                      children: List.generate(total + 1, (index) {
                        //return Center(child:Text('Item $index', style: Theme.of(context).textTheme.headline4,));

                        if (index == total) {
                          return Stack(children: [
                            GestureDetector(
                              onTap: () async {
                                await _addImage(
                                    context, ImageSourceType.gallery);
                              },
                              child: Container(
                                width: 200,
                                height: 200,
                                decoration:
                                    BoxDecoration(color: Colors.red[200]),
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.red[200]),
                                  width: 200,
                                  height: 200,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              )),
                            Center(child:Text("Tap to add page")),

                          ]);
                        } else {
                          return Stack(children: [
                            GestureDetector(
                                onTap: () async {
                                  await _handleURLButtonPress(
                                      context, ImageSourceType.gallery, index);
                                },
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration:
                                      BoxDecoration(color: Colors.red[200]),
                                  child: _images[index] != null
                                      ? Image.file(
                                          _images[index],
                                          width: 200.0,
                                          height: 200.0,
                                          fit: BoxFit.fitHeight,
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red[200]),
                                          width: 200,
                                          height: 200,
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                )),
                            Center(child: Text("page ${index + 1}")),

                          ]);
                        }
                      })),
                ),
              ),
              /* Container(
                child: Column(
                  children: <Widget>[
                    MaterialButton(
                      color: Colors.blue,
                      child: Text(
                        "Add Book page",
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        _addImage(context, ImageSourceType.gallery);
                      },
                    ),*/ /*MaterialButton(
                      color: Colors.blue,
                      child: Text(
                        "Pick Image from Camera",
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        _handleURLButtonPress(context, ImageSourceType.camera, 0);
                      },
                    ),*/ /*

                ]
                ),
              ),*/
              //],
              Expanded(
                  flex: 2,
                  child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VoiceRecorder(images: _images)));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        margin: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.mail_outline,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              "RECORD STORIES",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ))),
            ],
          ),
        ));
  }
}

/*class ImageFromGalleryEx extends StatefulWidget {
  final type;
  ImageFromGalleryEx(this.type);

  @override
  ImageFromGalleryExState createState() => ImageFromGalleryExState(this.type);
}*/

/*
class ImageFromGalleryExState extends State<ImageFromGalleryEx> {
  var _image;
  var imagePicker;
  var type;

  ImageFromGalleryExState(this.type);

  @override
  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(type == ImageSourceType.camera
              ? "Image from Camera"
              : "Image from Gallery")),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 52,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                var source = type == ImageSourceType.camera
                    ? ImageSource.camera
                    : ImageSource.gallery;
                XFile image = await imagePicker.pickImage(
                    source: source, imageQuality: 50, preferredCameraDevice: CameraDevice.front);
                setState(() {
                  _image = File(image.path);
                });
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.red[200]),
                child: _image != null
                    ? Image.file(
                  _image,
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.fitHeight,
                )
                    : Container(
                  decoration: BoxDecoration(
                      color: Colors.red[200]),
                  width: 200,
                  height: 200,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}*/
