import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:storily/components//utils.dart';

class UploadVideoScreen extends StatelessWidget {
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
            // uploadvideoscreenJvy (1:74)
            width: double.infinity,
            height: 844 * fem,
            decoration: BoxDecoration(
              color: Color(0xfff0f3f6),
            ),
            child: Stack(
              children: [
                Positioned(
                  // backgroundassetsnr9 (1:75)
                  left: 7 * fem,
                  top: 17 * fem,
                  child: Container(
                    width: 424 * fem,
                    height: 819 * fem,
                    child: Stack(
                      children: [
                        Positioned(
                          // backgroundsquare15KT (1:80)
                          left: 304 * fem,
                          top: 751 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 68 * fem,
                              height: 68 * fem,
                              child: Image.asset(
                                'assets/images/video_upload/backgroundsquare-1.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // backgroundrectangledotskwP (1:76)
                          left: 0 * fem,
                          top: 171 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 75 * fem,
                              height: 276 * fem,
                              child: Image.asset(
                                'assets/images/video_upload/backgroundrectangledots.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // uploadavideobuttonRGq (1:82)
                          left: 27 * fem,
                          top: 114 * fem,
                          child: Container(
                            width: 330 * fem,
                            height: 60 * fem,
                            child: Stack(
                              children: [
                                Positioned(
                                  // box6ds (I1:82;1:22)
                                  left: 0 * fem,
                                  top: 0 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 328 * fem,
                                      height: 60 * fem,
                                      child: Image.asset(
                                        'assets/images/video_upload/box-zUd.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // uploadavideoBvD (I1:82;1:23)
                                  left: 0 * fem,
                                  top: 0 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 328 * fem,
                                      height: 60 * fem,
                                      child: Image.asset(
                                        'assets/images/video_upload/upload-a-video-wVf.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // x4z1 (I1:82;1:24)
                                  left: 3 * fem,
                                  top: 0 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 327 * fem,
                                      height: 60 * fem,
                                      child: Image.asset(
                                        'assets/images/video_upload/x-ihT.png',
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
                          // wnu (24299751)
                          left: 24 * fem,
                          top: 0 * fem,
                          child: Container(
                            width: 358 * fem,
                            height: 147 * fem,
                            child: Stack(
                              children: [
                                Positioned(
                                  // nameinformationprh (1:83)
                                  left: 0 * fem,
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
                                          // hinameh9o (I1:83;1:27)
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
                                          // xxj6V (I1:83;1:28)
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
                                          // welcometoyourdashboardz2R (I1:83;1:29)
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
                                  // backgroundtriangle1iD (1:79)
                                  left: 184 * fem,
                                  top: 0 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 34 * fem,
                                      height: 34 * fem,
                                      child: Image.asset(
                                        'assets/images/video_upload/backgroundtriangle.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // backgroundsquiggle6Ds (1:78)
                                  left: 158 * fem,
                                  top: 49 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 58 * fem,
                                      height: 25 * fem,
                                      child: Image.asset(
                                        'assets/images/video_upload/backgroundsquiggle.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // backgroundcircledots1AzR (1:77)
                                  left: 243 * fem,
                                  top: 32 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 115 * fem,
                                      height: 115 * fem,
                                      child: Image.asset(
                                        'assets/images/video_upload/backgroundcircledots-1.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // frame14pu (1:81)
                                  left: 300 * fem,
                                  top: 42 * fem,
                                  child: Container(
                                    width: 100 * fem,
                                    height: 100 * fem,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          // B8q (58161555)
                          left: 64 * fem,
                          top: 222 * fem,
                          child: Container(
                            width: 247 * fem,
                            height: 374 * fem,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // pleaseselectuploadformatFuP (1:143)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 42 * fem),
                                  constraints: BoxConstraints(
                                    maxWidth: 247 * fem,
                                  ),
                                  child: Text(
                                    'Please Select Upload Format.',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont(
                                      'Lexend Deca',
                                      fontSize: 32 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.25 * ffem / fem,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                                Container(
                                  // addfilesi2H (1:142)
                                  margin: EdgeInsets.fromLTRB(
                                      29 * fem, 10 * fem, 29 * fem, 18 * fem),
                                  padding: EdgeInsets.fromLTRB(
                                      13 * fem, 39 * fem, 24 * fem, 46 * fem),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/images/video_upload/uploadbluevideobox-bg.png',
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // videohuo (1:138)
                                        margin: EdgeInsets.fromLTRB(
                                            2 * fem, 0 * fem, 0 * fem, 2 * fem),
                                        child: Text(
                                          'VIDEO',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'Lexend Deca',
                                            fontSize: 33 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.25 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // acceptableformatsmp4P1w (1:139)
                                        margin: EdgeInsets.fromLTRB(
                                            2 * fem, 0 * fem, 0 * fem, 8 * fem),
                                        constraints: BoxConstraints(
                                          maxWidth: 87 * fem,
                                        ),
                                        child: Text(
                                          'Acceptable Formats:\n.MP4',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'Lexend Deca',
                                            fontSize: 8.5 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.25 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // image63MP (1:135)
                                        width: 152 * fem,
                                        height: 40 * fem,
                                        child: Image.asset(
                                          'assets/images/video_upload/image-6.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // choosefromdraftsxjF (1:157)
                                  margin: EdgeInsets.fromLTRB(
                                      18 * fem, 0 * fem, 18 * fem, 0 * fem),
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 35 * fem,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            'assets/images/video_upload/dropshadow-bg.png',
                                          ),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            // boxzfw (1:159)
                                            left: 0 * fem,
                                            top: 0 * fem,
                                            child: Align(
                                              child: SizedBox(
                                                width: 205 * fem,
                                                height: 29 * fem,
                                                child: Image.asset(
                                                  'assets/images/video_upload/box-fph.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            // choosefromdrafts5xH (1:160)
                                            left: 11 * fem,
                                            top: 2 * fem,
                                            child: Align(
                                              child: SizedBox(
                                                width: 183 * fem,
                                                height: 25 * fem,
                                                child: Image.asset(
                                                  'assets/images/video_upload/choose-from-drafts.png',
                                                  fit: BoxFit.cover,
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
                      ],
                    ),
                  ),
                ),
                Positioned(
                  // ellipse1Y5B (1:86)
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
                  // profilenotificationdot1zSy (1:87)
                  left: 318 * fem,
                  top: 13 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 27 * fem,
                      height: 27 * fem,
                      child: Image.asset(
                        'assets/images/video_upload/profilenotificationdot-1-KyP.png',
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
