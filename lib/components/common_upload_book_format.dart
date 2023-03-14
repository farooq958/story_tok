import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:storily/components/upload_book_format.dart';

Widget uploadBookFormatHeader(String date, String name, String label) {
  return Container(
    child: ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          Text(
            name,
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ],
      ),
      trailing: ProfilePicture(
        name: 'GURI Team',
        radius: 31,
        fontsize: 21,
        img: 'https://avatars.githubusercontent.com/u/37553901?v=4',
      ),
    ),
  );
}

Widget addNewBookWidget(BuildContext context, String imageUrl) {
  return Image.asset(
    imageUrl,
    fit: BoxFit.contain,
    width: MediaQuery.of(context).size.width * 0.90,
  );
}

Widget dropShadowWidget({context, imageUrl}) {
  return Container(
    margin: EdgeInsets.only(left: 8.0),
    height: MediaQuery.of(context).size.height / 3.8,
    width: MediaQuery.of(context).size.width / 2.2,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
          "assets/images/upload_red_dropshadow.png",
        ),
      ),
    ),
  );
}

Widget addFilesWidget({
  context,
  boxImageUrl,
  textImageUrl,
  addFilesImageUrl,
}) {
  return Container(
    margin: EdgeInsets.only(left: 6.0),
    height: MediaQuery.of(context).size.height / 3.8,
    width: MediaQuery.of(context).size.width / 2.2,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
          boxImageUrl,
        ),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: Image.asset(
            textImageUrl,
            height: MediaQuery.of(context).size.height*0.06,
          ),
        ),
        InkWell(
          child: Image.asset(
            addFilesImageUrl,
            width: MediaQuery.of(context).size.height*0.16,
          ),
          onTap: () {
            callBack();
          },
        ),
      ],
    ),
  );
}

Widget uploadText({context, label}) {
  return Container(
    width: MediaQuery.of(context).size.width / 2,
    child: Text(
      label,
      maxLines: 2,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
}

callBack() {
  UploadBookFormat().createState().updateWidget(true);
}
