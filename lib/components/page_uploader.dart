import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum ImageSourceType { gallery, camera }

class PageUploader extends StatefulWidget {


  @override
  PageUploaderState createState() => PageUploaderState();
}

class PageUploaderState extends State<PageUploader> {
  var _image;
  var imagePicker;
  void _handleURLButtonPress(BuildContext context, var type) async  {
   /* Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImageFromGalleryEx(type)));*/

      var source = type == ImageSourceType.camera
          ? ImageSource.camera
          : ImageSource.gallery;
      XFile image = await imagePicker.pickImage(
          source: source, imageQuality: 50, preferredCameraDevice: CameraDevice.front);
      setState(() {
        _image = File(image.path);
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

            children: [
              GridView.count(
                shrinkWrap: true,
                  crossAxisCount: 2,
                  children: List.generate(4, (index) {
                    //return Center(child:Text('Item $index', style: Theme.of(context).textTheme.headline4,));
                    return GestureDetector(
                        onTap: () async {
                          /*var source = type == ImageSourceType.camera
                              ? ImageSource.camera
                              : ImageSource.gallery;
                          XFile image = await imagePicker.pickImage(
                              source: source, imageQuality: 50, preferredCameraDevice: CameraDevice.front);
                          setState(() {
                            _image = File(image.path);
                          });*/
                          await _handleURLButtonPress(context, ImageSourceType.gallery);
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
                      )
                    );
                  }
                  )
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    MaterialButton(
                      color: Colors.blue,
                      child: Text(
                        "Pick Image from Gallery",
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        _handleURLButtonPress(context, ImageSourceType.gallery);
                      },
                    ),
                    MaterialButton(
                      color: Colors.blue,
                      child: Text(
                        "Pick Image from Camera",
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        _handleURLButtonPress(context, ImageSourceType.camera);
                      },
                    ),
                ]
                ),
              )
            ],
          ),
        ));
  }
}

class ImageFromGalleryEx extends StatefulWidget {
  final type;
  ImageFromGalleryEx(this.type);

  @override
  ImageFromGalleryExState createState() => ImageFromGalleryExState(this.type);
}

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
}