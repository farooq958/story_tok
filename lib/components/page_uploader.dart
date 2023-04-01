import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storily/components/add_author_description.dart';
import 'package:storily/components/voice_recording.dart';
import '../utils.dart';

enum ImageSourceType { gallery, camera }

class PageUploader extends StatefulWidget {
  @override
  PageUploaderState createState() => PageUploaderState();
}

class PageUploaderState extends State<PageUploader> {
  var _images = <File>[];
  List imagesPath = [];
  var total = 0;
  var imagePicker;

  _addImage(BuildContext context, var type, int index) async {
    await _handleURLButtonPress(context, type, total);
    total++;
  }

  _handleURLButtonPress(BuildContext context, var type, var i) async {
    var source = type == ImageSourceType.camera
        ? ImageSource.camera
        : ImageSource.gallery;
    XFile image = await imagePicker.pickImage(
        source: source,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);

    bool imageExist = false;
    if (_images.length > 0) {
      for (int i = 0; i < _images.length; i++) {
        if (_images[i].path == image.path) {
          setState(() {
            imageExist = true;
          });
          Utils().showToastMessage("You can't choose the same image.", context);
          break;
        }
      }
    }

    if (!imageExist) {
      setState(() {
        _images.add(File(''));
        imagesPath.add(image.path);
        _images[i] = File(image.path);
      });
    }
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
              flex: 9,
              child: Container(
                child: GridView.count(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  children: List.generate(
                    total + 1,
                    (index) {
                      //return Center(child:Text('Item $index', style: Theme.of(context).textTheme.headline4,));

                      if (index == total) {
                        return Stack(children: [
                          GestureDetector(
                            onTap: () async {
                              await _addImage(context, ImageSourceType.gallery, index);
                            },
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(color: Colors.red[200]),
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
                            ),
                          ),
                          Center(
                            child: Text("Tap to add page"),
                          ),
                        ]);
                      } else {
                        return Stack(
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  await _handleURLButtonPress(
                                    context,
                                    ImageSourceType.gallery,
                                    index,
                                  );
                                },
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.red[200],
                                  ),
                                  child: _images[index] != null
                                      ? Image.file(
                                          _images[index],
                                          width: 200.0,
                                          height: 200.0,
                                          fit: BoxFit.fitHeight,
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red[200],
                                          ),
                                          width: 200,
                                          height: 200,
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                )),
                            Center(
                              child: Text(
                                "page ${index + 1}",
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            /* Container(
                child: Column(
                  children: [
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
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VoiceRecorder(_images,),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      // margin: EdgeInsets.fromLTRB(50.0, 0.0, 90.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (_images.length < 4) {
                        Utils().showToastMessage("Book has at least 4 pages.", context);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddAuthorDescription(imagesPath: imagesPath, images: _images),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Text(
                        "Done",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class ImageUploadScreen extends StatefulWidget {
//   @override
//   _ImageUploadScreenState createState() => _ImageUploadScreenState();
// }
//
// class _ImageUploadScreenState extends State<ImageUploadScreen> {
//   List<File> _images = [];
//
//   Future<void> _getImage() async {
//     var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//
//     setState(() {
//       _images.add(image);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Upload Images"),
//       ),
//       body: Container(
//         child: ReorderableListView(
//           children: _images
//               .map((image) => Container(
//             key: ValueKey(image),
//             child: Image.file(image),
//           ))
//               .toList(),
//           onReorder: (oldIndex, newIndex) {
//             setState(() {
//               File image = _images.removeAt(oldIndex);
//               _images.insert(newIndex, image);
//             });
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _getImage,
//         child: Icon(Icons.add_a_photo),
//       ),
//     );
//   }
// }

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
        children: [
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
                      c olor: Colors.red[200]),
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
