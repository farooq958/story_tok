import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:storily/global/constants/assets.dart';

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

Widget addNewBookWidget(BuildContext context, String imageUrl, width) {
  return Image.asset(
    imageUrl,
    fit: BoxFit.contain,
    width: width,
  );
}

Widget dropShadowWidget({context, imageUrl}) {
  return Container(
    margin: EdgeInsets.only(left: 15.0, top: 22.0),
    height: MediaQuery.of(context).size.width / 2.2,
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
    // margin: EdgeInsets.only(left: 6.0),
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
      maxLines: 2,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
}

class MainMenuWidget extends StatefulWidget {
  MainMenuWidget(
      {Key? key,
      this.boxImageUrl,
      required this.ontap,
      this.addFilesImageUrl,
      this.dropShadow})
      : super(key: key);
  Function()? ontap;
  String? boxImageUrl;
  String? addFilesImageUrl;
  String? dropShadow;
  @override
  State<MainMenuWidget> createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<MainMenuWidget> {
  late bool boolVal;
  ValueNotifier<bool> buttton = ValueNotifier(false);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    boolVal = false;
    print("object");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,

      // onFocusChange: (c) {
      //   log(c.toString());
      //   // addFilesForPDF = false;
      //   setState(() {});
      // },
      onTapDown: (c) async {
        buttton.value = true;
        buttton.notifyListeners();
        // boolVal = c;

        // widget.ontap(() {

        // });
      },
      // onHighlightChanged: (c) async {
      //   buttton.value = c;
      //   buttton.notifyListeners();
      //   // log(c.toString());
      //   // log(boolVal.toString());

      //   // // await Future.delayed(Duration(milliseconds: 10), () {});
      //   // // boolVal = c;
      //   // boolVal = !boolVal;
      //   // setState(() {});
      //   // widget.ontap(() {

      //   // });
      // },
      onTap: widget.ontap,
      // buttton.value = false;
      // buttton.notifyListeners();
      // setState(() {});

      onTapUp: (v) {
        buttton.value = false;
        buttton.notifyListeners();
        // setState(() {});
      },

      child: ValueListenableBuilder<bool>(
          valueListenable: buttton,
          builder: (context, val, child) {
            return Stack(
              children: [
                dropShadowWidget(
                  imageUrl: widget.dropShadow,
                  context: context,
                ),
                TweenAnimationBuilder<Offset>(
                  curve: Curves.bounceInOut,
                  tween: Tween<Offset>(
                      begin: val ? Offset(0, 0) : Offset(0, 0),
                      end: val ? Offset(10, 5) : Offset(-70, -60)),
                  duration: Duration(milliseconds: 10),
                  builder: (context, value, child) {
                    return Transform.translate(
                        offset: Offset(
                            value.dx.clamp(0, 10), value.dy.clamp(-3, 5)),
                        child: child!);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 6.0),
                    height: MediaQuery.of(context).size.height / 3.8,
                    width: MediaQuery.of(context).size.width / 2.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          widget.boxImageUrl!,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          widget.addFilesImageUrl!,
                          width: MediaQuery.of(context).size.height * 0.19,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
    ;
  }
}

Widget mainMenuWidget({
  context,
  boxImageUrl,
  addFilesImageUrl,
}) {
  bool boolVal = false;
  bool addFilesForPDF = false;
  return StatefulBuilder(builder: (context, setState) {
    return InkWell(
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      // onFocusChange: (c) {
      //   log(c.toString());
      //   // addFilesForPDF = false;
      //   setState(() {});
      // },
      onHighlightChanged: (c) {
        log(c.toString());
        addFilesForPDF = c;
        setState(() {});
      },

      onTap: () {
        log("donee");
        // addFilesForPDF = !addFilesForPDF;
        setState(() {});
      },

      child: TweenAnimationBuilder<Offset>(
        curve: Curves.bounceInOut,
        tween: Tween<Offset>(
            begin: boolVal ? Offset(0, 0) : Offset(0, 0),
            end: boolVal ? Offset(10, 5) : Offset(-70, -60)),
        duration: Duration(milliseconds: 50),
        builder: (context, value, child) {
          return Transform.translate(
              offset: Offset(value.dx.clamp(0, 10), value.dy.clamp(-3, 5)),
              child: child!);
        },
        child: Container(
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
        ),
      ),
    );
  });
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
