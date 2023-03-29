import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:storily/components//utils.dart';

class VideoPreviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("My Storily"),
        ),
        body: Container(
          width: double.infinity,
          child: Container(
            // videopreviewscreenBss (1:13)
            width: double.infinity,
            height: 844 * fem,
            decoration: BoxDecoration(
              color: Color(0xfff0f3f6),
            ),
            child: Stack(
              children: [
                Positioned(
                  // backgroundassetsziq (1:14)
                  left: 7 * fem,
                  top: 17 * fem,
                  child: Container(
                    width: 424 * fem,
                    height: 819 * fem,
                    child: Stack(
                      children: [
                        Positioned(
                          // autogroupwcp5T6d (9B3WjZB3L2WBEqxrjYWcp5)
                          left: 0 * fem,
                          top: 171 * fem,
                          child: Container(
                            width: 332 * fem,
                            height: 555 * fem,
                            child: Stack(
                              children: [
                                Positioned(
                                  // backgroundrectangledotsw1o (1:15)
                                  left: 0 * fem,
                                  top: 0 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 75 * fem,
                                      height: 276 * fem,
                                      child: Image.asset(
                                        'assets/images/video_upload/backgroundrectangledots-US1.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // previewboxDdX (1:30)
                                  left: 44 * fem,
                                  top: 44 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 288 * fem,
                                      height: 511 * fem,
                                      child: Image.asset(
                                        'assets/images/video_upload/preview-box.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // videopreviewVb3 (1:31)
                                  left: 133.5 * fem,
                                  top: 9 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 113 * fem,
                                      height: 20 * fem,
                                      child: Text(
                                        'Video Preview',
                                        textAlign: TextAlign.center,
                                        style: SafeGoogleFont(
                                          'Lexend Deca',
                                          fontSize: 16 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25 * ffem / fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          // autogroupurlhsLh (9B3W5jviVhCFsQojcWuRLH)
                          left: 182 * fem,
                          top: 0 * fem,
                          child: Container(
                            width: 242 * fem,
                            height: 147 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // autogroupbeiqMFs (9B3WMedshLheCGMYwSbeiq)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 25 * fem, 0 * fem),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        // backgroundtrianglepfF (1:18)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 15 * fem),
                                        width: 34 * fem,
                                        height: 34 * fem,
                                        child: Image.asset(
                                          'assets/images/video_upload/backgroundtriangle-vEZ.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        // backgroundsquiggleuRo (1:17)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 2 * fem, 0 * fem),
                                        width: 58 * fem,
                                        height: 25 * fem,
                                        child: Image.asset(
                                          'assets/images/video_upload/backgroundsquiggle-Pk9.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // autogroupbxdjBu7 (9B3WWtsUCGzR46HGQqbxDj)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 32 * fem, 0 * fem, 0 * fem),
                                  width: 157 * fem,
                                  height: 115 * fem,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        // backgroundcircledots1HBT (1:16)
                                        left: 0 * fem,
                                        top: 0 * fem,
                                        child: Align(
                                          child: SizedBox(
                                            width: 115 * fem,
                                            height: 115 * fem,
                                            child: Image.asset(
                                              'assets/images/video_upload/backgroundcircledots-1-SDs.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        // frame1MSD (1:48)
                                        left: 57 * fem,
                                        top: 10 * fem,
                                        child: Container(
                                          width: 100 * fem,
                                          height: 100 * fem,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          // backgroundsquare1Eku (1:19)
                          left: 304 * fem,
                          top: 751 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 68 * fem,
                              height: 68 * fem,
                              child: Image.asset(
                                'assets/images/video_upload/backgroundsquare-1-WkV.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // uploadavideobutton7Zo (1:20)
                          left: 27 * fem,
                          top: 114 * fem,
                          child: Container(
                            width: 322 * fem,
                            height: 55 * fem,
                            child: Stack(
                              children: [
                                Positioned(
                                  // boxCr9 (1:22)
                                  left: 0 * fem,
                                  top: 0 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 328 * fem,
                                      height: 60 * fem,
                                      child: Image.asset(
                                        'assets/images/video_upload/box-QS9.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // uploadavideoUof (1:23)
                                  left: 0 * fem,
                                  top: 0 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 328 * fem,
                                      height: 60 * fem,
                                      child: Image.asset(
                                        'assets/images/video_upload/upload-a-video-5wB.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // xYoX (1:24)
                                  left: 3 * fem,
                                  top: 0 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 327 * fem,
                                      height: 60 * fem,
                                      child: Image.asset(
                                        'assets/images/video_upload/x-KvD.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          // nameinformationSe1 (1:25)
                          left: 24 * fem,
                          top: 18 * fem,
                          child: Container(
                            width: 249 * fem,
                            height: 82 * fem,
                            decoration: BoxDecoration(
                              color: Color(0x00d9d9d9),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  // hinameWds (1:27)
                                  left: 0 * fem,
                                  top: 14 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 135 * fem,
                                      height: 37 * fem,
                                      child: Text(
                                        'Hi, Name\n',
                                        style: SafeGoogleFont(
                                          'Lexend Deca',
                                          fontSize: 29 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.25 * ffem / fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // xxZMF (1:28)
                                  left: 0 * fem,
                                  top: 3 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 69 * fem,
                                      height: 14 * fem,
                                      child: Text(
                                        '00/00/20XX',
                                        style: SafeGoogleFont(
                                          'Lexend Deca',
                                          fontSize: 11 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.25 * ffem / fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // welcometoyourdashboardDwb (1:29)
                                  left: 0 * fem,
                                  top: 47 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 177 * fem,
                                      height: 17 * fem,
                                      child: Text(
                                        'Welcome to your dashboard.',
                                        style: SafeGoogleFont(
                                          'Lexend Deca',
                                          fontSize: 13 * ffem,
                                          fontWeight: FontWeight.w300,
                                          height: 1.25 * ffem / fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          // backbuttonTL9 (1:71)
                          left: 28 * fem,
                          top: 755 * fem,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Container(
                              width: 156 * fem,
                              height: 35 * fem,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'adrop-shadow-bg-PgR.png',
                                  ),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    // boxUFF (1:54)
                                    left: 0 * fem,
                                    top: 0 * fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 150 * fem,
                                        height: 29 * fem,
                                        child: Image.asset(
                                          'assets/images/video_upload/box-aRb.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // backkyT (1:55)
                                    left: 56 * fem,
                                    top: 6 * fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 34 * fem,
                                        height: 15 * fem,
                                        child: Text(
                                          'BACK',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'Lexend Deca',
                                            fontSize: 12 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.25 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // continuebuttonDMF (1:70)
                          left: 192 * fem,
                          top: 755 * fem,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Container(
                              width: 156 * fem,
                              height: 35 * fem,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/images/video_upload/drop-shadow-bg-653.png',
                                  ),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    // box1H7 (1:61)
                                    left: 0 * fem,
                                    top: 0 * fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 150 * fem,
                                        height: 29 * fem,
                                        child: Image.asset(
                                          'assets/images/video_upload/box.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // boxhvd (1:63)
                                    left: 0 * fem,
                                    top: 0 * fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 150 * fem,
                                        height: 29 * fem,
                                        child: Image.asset(
                                          'assets/images/video_upload/box-PJm.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // continueCcV (1:62)
                                    left: 41 * fem,
                                    top: 6 * fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 67 * fem,
                                        height: 15 * fem,
                                        child: Text(
                                          'CONTINUE',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'Lexend Deca',
                                            fontSize: 12 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.25 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  // ellipse1ToK (1:32)
                  left: 250 * fem,
                  top: 13 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 101 * fem,
                      height: 101 * fem,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.5 * fem),
                          border: Border.all(color: Color(0xff000000)),
                          color: Color(0xffd9d9d9),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // profilenotificationdot1Vk1 (1:33)
                  left: 318 * fem,
                  top: 13 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 27 * fem,
                      height: 27 * fem,
                      child: Image.asset(
                        'assets/images/video_upload/profilenotificationdot-1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
