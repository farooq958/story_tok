import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storily/components/upload_book_format.dart';
import 'package:storily/screens/auth/helpers/authentication_helper.dart';
import 'package:storily/screens/book_upload/book-confirm-details-screen.dart';
import 'package:storily/screens/book_upload/book-input-details-screen.dart';
import 'package:storily/screens/book_upload/book-preview-screen.dart';
import 'package:storily/screens/schedule_event_flow_screens/main_event_screen.dart';
import 'package:storily/screens/video_upload/upload-video-screen.dart';
import 'package:storily/screens/video_upload/video-preview-screen.dart';

import '../components/common_upload_book_format.dart';
import '../global/constants/assets.dart';
import '../global/methods/methods.dart';
import 'dashboard/profile/author_profile.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AuthenticationHelper().signOut();
          },
        ),
        body: Container(
          color: Color(0xffEEF0F2),
          //color: Color(0xfff0f3f6),

          height: 1.sh,
          width: 1.sw,
          //  padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Stack(
            children: [
              Positioned(
                  // left: 20.sp,
                  top: 70.sp,
                  right: 0,
                  child: Image.asset(
                    "assets/images/background_circledots.png",
                    width: 115.sp,
                    height: 150.sp,
                  )),

              Positioned(
                bottom: 20.sp, // distance from the bottom
                right: 0.sp, // distance from the right
                child: Image.asset(
                  'assets/images/background_square.png',
                  width: 70.sp, // specify the width of the image
                  height: 70.sp, // specify the height of the image
                ),
              ),
              Positioned(
                  //left: 0.sp,
                  //right: 1.sw/2,
                  bottom: 1.sh / 3.5.sp,
                  top: 1.sh / 2.8,
                  child: SizedBox(
                      height: 20.sp,
                      child: Image.asset(
                          "assets/images/background_rectangledots.png"))),
              ListView(
                shrinkWrap: true,
                //padding:  EdgeInsets.symmetric(horizontal: 20.sp)
                children: [
                  //SizedBox(height: 35.sp,),
                  ///Top Design
                  Container(
                    height: 130.sp, color: Colors.transparent,
                    //  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    margin: EdgeInsets.only(left: 20.sp),
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        ///left side
                        UnconstrainedBox(
                          child: Container(
                            height: 120.sp,
                            width: 1.sw / 1.9.sp,
                            color: Colors.transparent,
                            child: ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                SizedBox(
                                  height: 50.sp,
                                ),

                                ///upper date
                                Text(
                                  "13/3/2023",
                                  style: GoogleFonts.lexend(fontSize: 11.sp),
                                ),

                                ///Profile Name
                                Text(
                                  "Hi, Name",
                                  style: GoogleFonts.lexend(
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                FittedBox(
                                    child: Text(
                                  "Welcome to your dashboard",
                                  style: GoogleFonts.lexend(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w200),
                                )),
                              ],
                            ),
                          ),
                        ),

                        ///rigth side
                        UnconstrainedBox(
                          child: Container(
                            height: 130.sp,
                            width: 1.sw / 1.9.sp,
                            color: Colors.transparent,
                            child: ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                SizedBox(
                                  height: 25.sp,
                                ),

                                ///Profile Picture
                                Row(
                                  children: [
                                    Expanded(
                                        child: ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: [
                                        Container(
                                            color: Colors.transparent,
                                            child: Image.asset(
                                              "assets/images/background_triangle.png",
                                              height: 30.sp,
                                              width: 80.sp,
                                            )),
                                        SizedBox(
                                          height: 20.sp,
                                        ),
                                        Container(
                                            color: Colors.transparent,
                                            child: Image.asset(
                                              "assets/images/background_squiggle.png",
                                              height: 30.sp,
                                              width: 80.sp,
                                            )),
                                      ],
                                    )),
                                    Expanded(
                                        flex: 3,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: InkWell(
                                            onTap: () {
                                              goPage(context, AuthorProfile());
                                            },
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: 100.sp,
                                                  width: 90.sp,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Image.asset(
                                                      "assets/images/profile_profile_placeholder.png",
                                                      height: 100.sp,
                                                      width: 90.sp,
                                                    ),
                                                    //minRadius: 30.sp,
                                                    maxRadius: 45.sp,
                                                  ),
                                                ),
                                                Positioned(
                                                    right: 2.sp,
                                                    top: 10.sp,
                                                    child: Image.asset(
                                                      "assets/images/profile_notificationdot.png",
                                                      height: 20.sp,
                                                      width: 20.sp,
                                                    ))
                                              ],
                                            ),
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Checkbox(value: value, onChanged: onChanged)
                        Expanded(
                          child: MainMenuWidget(
                            ontap: () {
                              // v.call();
                              // setState(() {});
                              // goPage(context, BookConfirmDetails());
                              // goPage(context, BookInputDetails());
                              // goPage(context, BookPreview());
                              goPage(context, UploadBookFormat());
                            },
                            key: ValueKey(DateTime.now().toString() + "2"),
                            boxImageUrl: Assets.uploadRedBox,
                            dropShadow: Assets.redDropShadow,
                            // context: context,
                            addFilesImageUrl: Assets.imageTextImageMianBook,
                          ),
                          // child:
                        ),
                        Expanded(
                            child: MainMenuWidget(
                          ontap: () {
                            goPage(context, UploadVideoScreen());
                          },
                          addFilesImageUrl: Assets.imageTextUploanVideoBlue,
                          boxImageUrl: Assets.uploadblueBox,
                          dropShadow: Assets.blueDropShadowMain,
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: MainMenuWidget(
                          ontap: () {
                            goPage(context, MainEventScreenScheduleScreen());
                          },
                          addFilesImageUrl: Assets.imageTexteventyellow,
                          boxImageUrl: Assets.uploadyellowBox,
                          dropShadow: Assets.yellowDropShadowMain,
                        )),
                        Expanded(
                            child: MainMenuWidget(
                          ontap: () {
                            print("----->>> ");
                            goPage(context, AuthorProfile());
                          },
                          addFilesImageUrl: Assets.imageTextMyProfilePurple,
                          boxImageUrl: Assets.uploadpurpleBox,
                          dropShadow: Assets.purpleDropShadowMain,
                        )),
                      ],
                    ),
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "A".toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontFamily: "Proxima Nova Bold"),
                      ),
                      Text(
                        "nalytics".toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            fontFamily: "Proxima Nova Bold"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    // padding: EdgeInsets.symmetric(horizontal: .sp),

                    // height: MediaQuery.of(context).size.height / 13,
                    width: MediaQuery.of(context).size.width / 2.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          Assets.authoranalyticsgreenbox,
                        ),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Image.asset(Assets.authoranalyticsgreencolouredbox),
                        Image.asset(Assets.authoranalyticsgreenicon),
                        Image.asset(Assets.authoranalyticsgreentitle),
                        Positioned(
                          left: 43 * fem,
                          top: 28 * fem,
                          bottom: 1.sp,
                          right: 10.sp,
                          child: Text(
                            "3".toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 23,
                                fontFamily: "Proxima Nova"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),

                    // margin: EdgeInsets.only(left: 6.0, right: 6.0),
                    // height: MediaQuery.of(context).size.height / 13,
                    width: MediaQuery.of(context).size.width / 2.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          Assets.authoranalyticsbluebox,
                        ),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Image.asset(Assets.authoranalyticsbluecolouredbox),
                        Image.asset(Assets.authoranalyticsblueicon),
                        Image.asset(Assets.authoranalyticsbluetitle),
                        Positioned(
                          left: 43 * fem,
                          top: 28 * fem,
                          bottom: 1.sp,
                          right: 10.sp,
                          child: Text(
                            "50".toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 23,
                                fontFamily: "Proxima Nova"),
                          ),
                        ),
                        Positioned(
                          left: 43 * fem,
                          top: 95 * fem,
                          bottom: 1.sp,
                          right: 10.sp,
                          child: Text(
                            "2:30".toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 23,
                                fontFamily: "Proxima Nova"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),

                    // margin: EdgeInsets.only(left: 6.0, right: 6.0),
                    // height: MediaQuery.of(context).size.height / 4s,
                    width: MediaQuery.of(context).size.width / 2.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          Assets.authoranalyticsredbox,
                        ),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Image.asset(Assets.authoranalyticsredcolouredbox),
                        Positioned(
                          left: 30.sp,
                          top: 25.sp,
                          bottom: 1.sp,
                          right: 10.sp,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 200,
                                // width: ,
                                child: Image.asset(Assets.pagepreviewRedPage),
                              ),
                              SizedBox(
                                height: 200,
                                // width: 150,
                                child: Image.asset(Assets.pagepreviewRedPage),
                              ),
                              SizedBox(
                                height: 200,
                                // width: 150,
                                child: Image.asset(Assets.pagepreviewRedPage),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(Assets.authoranalyticsredtitle),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              //SizedBox(height: 80.sp,),
            ],
          ),
        ),
      ),
    );
  }
}
