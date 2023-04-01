import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:storily/components/common_upload_book_format.dart';
import '../global/constants/assets.dart';

import 'package:path/path.dart';

class VideoUploader extends StatefulWidget {
  @override
  _VideoUploaderState createState() => _VideoUploaderState();
}

class _VideoUploaderState extends State<VideoUploader> {
  XFile? _videoFile;
  String? _caption;
  String? _uploadedFileURL;
  var imagePicker;

  Future<void> _pickVideo() async {
    final selectedVideo =
    await imagePicker.pickVideo(source: ImageSource.gallery);

    setState(() {
      _videoFile = selectedVideo;
    });
  }

  Future<void> _uploadVideo() async {

    final file = File(_videoFile!.path);
    String bname = basename(file.path);
// Create the file metadata
    final metadata = SettableMetadata(contentType: "video/mp4");

// Create a reference to the Firebase Storage bucket
    final storageRef = FirebaseStorage.instance.ref();

// Upload file and metadata to the path 'videos/'
    final uploadTask = storageRef
        .child("videos/books/${bname}")//YOu also needs author id and time id
        .putFile(file, metadata);

// Listen for state changes, errors, and completion of the upload.
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          print("Upload is paused.");
          break;
        case TaskState.canceled:
          print("Upload was canceled");
          break;
        case TaskState.error:
        // Handle unsuccessful uploads
          break;
        case TaskState.success:
        // Handle successful uploads on complete
        // ...
          setState(() {
              _uploadedFileURL = storageRef.getDownloadURL().toString();
            });
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
  }

  @override
   build(BuildContext context) {
    if (_videoFile == null) {
      return Scaffold(
          backgroundColor: Colors.grey[300],
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                uploadBookFormatHeader('12/03/2023', 'Hi, Team', 'Welcome to your board'),
                SizedBox(height: 10),
                commonAddBookWidget(context, Assets.uploadVideoHeader, MediaQuery
                    .of(context)
                    .size
                    .width * 0.90),
                SizedBox(height: 10),
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 6,
                      child: Image.asset(Assets.backgroundRectangleDots),
                    ),
                    Column(
                      children: [
                        Text("Please Select Upload Format.", textScaleFactor: 3.5, textAlign: TextAlign.center),
                        SizedBox(height: 30),
                        InkWell(
                          child: addFilesWidget(
                            boxImageUrl: Assets.uploadVideoBox,
                            textImageUrl: Assets.pdfTextImage,
                            context: context,
                            addFilesImageUrl: Assets.uploadVideoAddFilesBox,
                          ),
                          onTap: _pickVideo,
                        )
                      ],
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(Assets.uploadVideoButtonBox, scale: 5),
                    Image.asset(Assets.uploadVideoChooseFromDrafts, scale: 6)
                  ],
                ),
                Expanded(child: SizedBox()),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Container(
                      margin: const EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width / 4,
                      child: Image.asset(Assets.uploadVideoBGSquare),
                    )]
                )
              ],
            ),
          )

      );
    }

    if (_videoFile != null && _caption == null) {
      return Scaffold(
          backgroundColor: Colors.grey[300],
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                uploadBookFormatHeader('12/03/2023', 'Hi, Team', 'Welcome to your board'),
                SizedBox(height: 10),
                commonAddBookWidget(context, Assets.uploadVideoHeader, MediaQuery
                    .of(context)
                    .size
                    .width * 0.90),
                SizedBox(height: 10),
                Stack(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 6,
                          child: Image.asset(Assets.backgroundRectangleDots),
                        )
                  ]),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Image.asset(Assets.uploadVideoBox)
                            ),
                            Text("Video"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child:TextField(
                                maxLines: 5,
                                maxLength: 200,
                                onChanged: (text) {_caption = text;},
                                decoration: InputDecoration(
                                    hintText: "write a caption",
                                    filled: true,
                                    fillColor: Colors.grey[300],
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black, width: 4.0),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: Colors.black, width: 4.0),
                                       borderRadius: BorderRadius.circular(20),
                                     ),
                                )
                            ),
                          )
                          ],
                        ),
                      ],
                    ),
                  ]),
                Expanded(child: Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child:Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Image.asset(Assets.uploadVideoBGSquare)
                              )
                            ]
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(Assets.uploadVideoButtonBox, scale: 7),
                                    Text("DRAFTS")
                                  ],
                                ),
                                InkWell(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(Assets.uploadVideoButtonBox, scale: 7),
                                      Text("SHARE")
                                    ],
                                  ),
                                  onTap: (){ print("hi"); setState(() {});},
                                )
                              ],
                            ),
                            SizedBox(height: 30)
                          ],
                        )
                      ],
                    ),)

                  ],
                ),
              ],
            ),
          )
      );
    }

    if (_caption != null) {
      return Scaffold(
        backgroundColor: Colors.grey[300],
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 95),
                  Row(
                    children: [
                      Container(
                      width: MediaQuery.of(context).size.width / 6,
                      child: Image.asset(Assets.backgroundRectangleDots),
                    )]
                  ),
                  Expanded(child: Container()),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Image.asset(Assets.uploadVideoBGSquare)
                        )
                      ]
                  ),

                ],
              ),
              Column(
                children: [
                  SizedBox(height: 20),
                  uploadBookFormatHeader('12/03/2023', 'Hi, Team', 'Welcome to your board'),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Image.asset(Assets.uploadVideoCoverBox),
                          )
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: 40,
                                child: TextFormField(
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      labelText: "Title",
                                      labelStyle: TextStyle(color: Colors.black, fontSize: 25),
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      hintText: "Name of your book",
                                      filled: true,
                                      fillColor: Colors.grey[300],
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black, width: 4.0),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black, width: 4.0),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    )
                                )
                            ),
                            SizedBox(height: 30),
                            SizedBox(
                                height: 40,
                                child: TextFormField(
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      labelText: "Author(s)",
                                      labelStyle: TextStyle(color: Colors.black, fontSize: 25),
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      hintText: "Name of the author(s)",
                                      filled: true,
                                      fillColor: Colors.grey[300],
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black, width: 4.0),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black, width: 4.0),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    )
                                )
                            ),
                            SizedBox(height: 30),
                            SizedBox(
                                height: 40,
                                child: TextFormField(
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      labelText: "Age Level",
                                      labelStyle: TextStyle(color: Colors.black, fontSize: 25),
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      hintText: "Name of your book",
                                      filled: true,
                                      fillColor: Colors.grey[300],
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black, width: 4.0),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black, width: 4.0),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    )
                                )
                            ),
                          ],
                        )

                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: TextFormField(
                              maxLines: 1,
                              decoration: InputDecoration(
                                labelText: "Video Genre(s)",
                                labelStyle: TextStyle(color: Colors.black, fontSize: 25),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                hintText: "Book genre",
                                filled: true,
                                fillColor: Colors.grey[300],
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 4.0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 4.0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              )
                          )
                      ),
                      SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: TextFormField(
                              maxLines: 1,
                              decoration: InputDecoration(
                                labelText: "",
                                labelStyle: TextStyle(color: Colors.black, fontSize: 25),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                hintText: "Sub Genre(s)",
                                filled: true,
                                fillColor: Colors.grey[300],
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 4.0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 4.0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              )
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width / (1.07),
                      child: TextFormField(
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: "Topics",
                            labelStyle: TextStyle(color: Colors.black, fontSize: 25),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "Book Topic(s)",
                            filled: true,
                            fillColor: Colors.grey[300],
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 4.0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 4.0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          )
                      )
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                      height: 130,
                      width: MediaQuery.of(context).size.width / (1.07),
                      child: TextFormField(
                          maxLines: 10,
                          maxLength: 300,
                          decoration: InputDecoration(
                            labelText: "Topics",
                            labelStyle: TextStyle(color: Colors.black, fontSize: 25),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "What is your book about?",
                            filled: true,
                            fillColor: Colors.grey[300],
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 4.0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 4.0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          )
                      )

                  ),
                  Expanded(child: Container()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(Assets.uploadVideoButtonBox, scale: 7),
                          Text("DRAFTS")
                        ],
                      ),
                      InkWell(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(Assets.uploadVideoButtonBox, scale: 7),
                            Text("SHARE")
                          ],
                        ),
                        onTap: (){ print("hi"); setState(() {});},
                      )
                    ],
                  ),
                  SizedBox(height: 30)


                ],
              )
            ],
          ),
        )
      );
    }
    return Column(
      children: [
        ElevatedButton(
          onPressed: _pickVideo,
          child: Text('debug Choose Video'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _uploadVideo,//_videoFile != null ? _uploadVideo : null,
          child: Text('Upload Video'),
        ),
        _videoFile != null
            ? Text('Video Selected: ${_videoFile!.path}')
            : Container(),

        SizedBox(height: 20),
        // _uploadedFileURL != null
        //     ? VideoPlayer(_uploadedFileURL!)
        //     : Container(),
      ],
    );
  }
}

// class VideoPlayer extends StatefulWidget {
//   final String videoURL;
//
//   VideoPlayer(this.videoURL);
//
//   @override
//   _VideoPlayerState createState() => _VideoPlayerState();
// }
//
// class _VideoPlayerState extends State<VideoPlayer> {
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 16 / 9,
//       child: Container(
//         child: widget.videoURL != null
//             ? Video.network(
//           widget.videoURL,
//           headers: {'Accept-Encoding': 'identity'},
//           key: UniqueKey(),
//           width: 640,
//           height: 360,
//           isLive: false,
//         )
//             : Container(),
//       ),
//     );
//   }
// }