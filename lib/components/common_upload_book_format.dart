import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:storily/global/constants/assets.dart';

Widget uploadBookFormatHeader(String date, String name, String label) {
  return Column(
    children: [
      Container(
        child: ListTile(
          title: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    label,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(width: 20,),
              Column(
                children: [
                  Image.asset(Assets.backgroundTriangle, height: 30, width: 30,),
                  Image.asset(Assets.backgroundSquiggle, height: 60, width: 60,)
                ],
              )
            ],
          ),
          trailing: ProfilePicture(
            name: 'GURI Team',
            radius: 31,
            fontsize: 21,
            img: 'https://avatars.githubusercontent.com/u/37553901?v=4',
          ),
        ),
      ),
    ],
  );
}

Widget commonAddBookWidget(BuildContext context, String imageUrl, width) {
  return Image.asset(
    imageUrl,
    fit: BoxFit.contain,
    width: width,
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
          imageUrl,
        ),
      ),
    ),
  );
}

Widget addFilesWidget(
    {context, boxImageUrl, textImageUrl, addFilesImageUrl, imageHeight}) {
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
          child: Image.asset(textImageUrl, height: imageHeight),
        ),
        // Image.asset(
        //   addFilesImageUrl,
        //   width: MediaQuery.of(context).size.height * 0.16,
        // ),
        if (addFilesImageUrl != '')
          Image.asset(
            addFilesImageUrl,
            width: MediaQuery.of(context).size.height * 0.16,
          ),
      ],
    ),
  );
}

Widget uploadText({context, label, fontSize}) {
  return Container(
    width: MediaQuery.of(context).size.width / 2,
    child: Text(
      label,
      maxLines: 3,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
}

Widget mainMenuWidget({
  context,
  boxImageUrl,
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
        Image.asset(
          addFilesImageUrl,
          width: MediaQuery.of(context).size.height * 0.19,
        ),
      ],
    ),
  );
}

BoxDecoration boxDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(100.0),
    boxShadow: [
      BoxShadow(
        color: Colors.transparent,
        blurRadius: 12.0,
        offset: Offset(0.0, 5.0),
      ),
    ],
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.transparent,
        Colors.transparent,
      ],
    ),
  );
}

Widget backgroundSquare(context) {
  return Stack(
    children: [
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.bottomRight,
        child: Container(
          margin: EdgeInsets.only(right: 10, bottom: 10),
          child: Image.asset(
            Assets.backgroundSquare,
            height: 100,
            width: 100,
          ),
        ),
      )
    ],
  );
}
