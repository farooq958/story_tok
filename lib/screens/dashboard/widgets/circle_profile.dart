import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../global/constants/color_resources.dart';

class CircleProfile extends StatefulWidget {
  var profileurl;
   CircleProfile({Key? key,required this.profileurl}) : super(key: key);

  @override
  State<CircleProfile> createState() => _CircleProfileState();
}

class _CircleProfileState extends State<CircleProfile> {
  var image;
  var imageURL = '';


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              settingModalBottomSheet(context);
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  border: Border.all(color: ColorResources.colorBlack, width: 3),
                  borderRadius: BorderRadius.circular(50.0),
                  color: ColorResources.colorWhite),
              child: widget.profileurl != ''?ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: CachedNetworkImage(
                  imageUrl:widget.profileurl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      CircularProgressIndicator()
                    //  Image.asset('assets/images/profile.png'),
                  // child: Image.network(
                  //     mainCategoryData[index]
                  //         ['catimage1url']),
                ),
              ):Image.asset('assets/images/profile.png'),
            ),
          )
        ],
      ),
    );
  }

  void settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: new Icon(Icons.camera_alt),
                    title: new Text('Camera'),
                    onTap: () => {uploadProfileImage(true, context)}),
                ListTile(
                  leading: new Icon(Icons.browse_gallery),
                  title: new Text('Gallery'),
                  onTap: () => {uploadProfileImage(false, context)},
                ),
              ],
            ),
          );
        });
  }

  void uploadProfileImage(bool isCamera, BuildContext context) async {
    image = await ImagePicker().pickImage(
      source: !isCamera ? ImageSource.gallery : ImageSource.camera,
      // maxHeight: 512,
      // maxWidth: 512,
      imageQuality: 100,
    );
    if (image != null) {
       Navigator.pop(context);

      Reference ref = FirebaseStorage.instance.ref().child("profile.jpg");
      // await ref.putFile(File(image1.path));
      await ref.putData(await image!.readAsBytes(),
          SettableMetadata(contentType: 'image/jpeg'));
      ref.getDownloadURL().then((value) async {
        print("##### URL $value  $value");
        var docID = '';
        await FirebaseFirestore.instance
            .collection('book_authors')
            .get()
            .then((value1) {
          value1.docs.forEach((element) {
            print(element.id);
            docID = element.id;
          });
        });
        await FirebaseFirestore.instance
            .collection('book_authors')
            .doc(docID)
            .update({
          'avatar_url': value
        });
        setState(() {
          widget.profileurl = value;
        });
      });
    }
  }
}
