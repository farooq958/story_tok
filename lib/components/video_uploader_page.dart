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
  String? _uploadedFileURL;
  var imagePicker;
  final ImagePicker _picker = ImagePicker();

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
  Widget build(BuildContext context) {

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
                addNewBookWidget(context, Assets.uploadVideoHeader, MediaQuery
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
                    Image.asset(Assets.uploadVideoChooseFromDraftsBG, scale: 5),
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

    return Column(
      children: <Widget>[

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