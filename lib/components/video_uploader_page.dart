import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:path/path.dart';

class VideoUploader extends StatefulWidget {
  @override
  _VideoUploaderState createState() => _VideoUploaderState();
}

class _VideoUploaderState extends State<VideoUploader> {
  XFile? _videoFile;
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
  Widget build(BuildContext context) {
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