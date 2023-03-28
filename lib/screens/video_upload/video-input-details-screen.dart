import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:storily/components//utils.dart';

class VideoDetailInputScreen extends StatelessWidget {
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
            // videoinputdetailsscreen3FT (1:186)
            width: double.infinity,
            height: 844 * fem,
            decoration: BoxDecoration(
              color: Color(0xfff0f3f6),
            ),
            child: Stack(
              children: [
                Positioned(
                  // backgroundassetsjPB (1:187)
                  left: 7 * fem,
                  top: 17 * fem,
                  child: Container(
                    width: 382 * fem,
                    height: 819 * fem,
                    child: Stack(
                      children: [
                        Positioned(
                          // autogroupy8wqodw (9B3Z9V9t4x522S2yfey8Wq)
                          left: 0 * fem,
                          top: 0 * fem,
                          child: Container(
                            width: 382 * fem,
                            height: 451 * fem,
                            child: Stack(
                              children: [
                                Positioned(
                                  // backgroundrectangledots5bT (1:188)
                                  left: 0 * fem,
                                  top: 171 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 75 * fem,
                                      height: 276 * fem,
                                      child: Image.asset(
                                        'assets/images/video_upload/backgroundrectangledots-2fw.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // backgroundcircledots1khb (1:189)
                                  left: 267 * fem,
                                  top: 32 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 115 * fem,
                                      height: 115 * fem,
                                      child: Image.asset(
                                        'assets/images/video_upload/backgroundcircledots-1-2ow.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // backgroundsquiggleS4d (1:190)
                                  left: 182 * fem,
                                  top: 49 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 58 * fem,
                                      height: 25 * fem,
                                      child: Image.asset(
                                        'assets/images/video_upload/backgroundsquiggle-7t1.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // backgroundtriangleKeD (1:191)
                                  left: 208 * fem,
                                  top: 0 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 34 * fem,
                                      height: 34 * fem,
                                      child: Image.asset(
                                        'assets/images/video_upload/backgroundtriangle-qLH.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // nameinformationRBT (1:194)
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
                                          // hinamegdB (I1:194;3:23)
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
                                          // xxiJy (I1:194;3:24)
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
                                          // welcometoyourdashboard9fB (I1:194;3:25)
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
                                  // addfilecYm (1:199)
                                  left: 32 * fem,
                                  top: 188 * fem,
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(6 * fem,
                                          106 * fem, 6 * fem, 60 * fem),
                                      width: 109 * fem,
                                      height: 191 * fem,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            'assets/images/video_upload/coverredbook-1-bg.png',
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        // coverredaddfiles1S21 (1:201)
                                        child: SizedBox(
                                          width: 97 * fem,
                                          height: 25 * fem,
                                          child: Image.asset(
                                            'assets/images/video_upload/coverredaddfiles-1.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // videoinputfieldauthoriER (1:225)
                                  left: 167 * fem,
                                  top: 258 * fem,
                                  child: Container(
                                    width: 181 * fem,
                                    height: 48 * fem,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // titlebJD (I1:225;1:228)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 3 * fem),
                                          child: RichText(
                                            text: TextSpan(
                                              style: SafeGoogleFont(
                                                'Lexend Deca',
                                                fontSize: 17 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height: 1.25 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'Author(s)',
                                                ),
                                                TextSpan(
                                                  text: '*',
                                                  style: SafeGoogleFont(
                                                    'Lexend Deca',
                                                    fontSize: 17 * ffem,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.25 * ffem / fem,
                                                    color: Color(0xff5cabdf),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // inputfield3hw (I1:225;1:229)
                                          width: double.infinity,
                                          height: 23 * fem,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                'assets/images/video_upload/inputfield-uiM.png',
                                              ),
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                // nameofyourvideoKvM (I1:225;1:229;5:69)
                                                left: 6 * fem,
                                                top: 6 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 83 * fem,
                                                    height: 10 * fem,
                                                    child: Text(
                                                      'Name of the author(s)',
                                                      style: SafeGoogleFont(
                                                        'Lexend Deca',
                                                        fontSize: 7.5 * ffem,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height:
                                                            1.25 * ffem / fem,
                                                        color:
                                                            Color(0xff8f9295),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // inputfieldwwj (I1:225;1:229;5:67)
                                                left: 0 * fem,
                                                top: 0 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 181 * fem,
                                                    height: 23 * fem,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    7 * fem),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xff000000)),
                                                        color:
                                                            Color(0x00d9d9d9),
                                                      ),
                                                      child: TextField(
                                                        maxLines: null,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          focusedBorder:
                                                              InputBorder.none,
                                                          enabledBorder:
                                                              InputBorder.none,
                                                          errorBorder:
                                                              InputBorder.none,
                                                          disabledBorder:
                                                              InputBorder.none,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
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
                                  // videoinputfieldillustratorNGM (1:226)
                                  left: 167 * fem,
                                  top: 330 * fem,
                                  child: Container(
                                    width: 181 * fem,
                                    height: 48 * fem,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // titleqQq (I1:226;1:228)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 3 * fem),
                                          child: RichText(
                                            text: TextSpan(
                                              style: SafeGoogleFont(
                                                'Lexend Deca',
                                                fontSize: 17 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height: 1.25 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'Age Level',
                                                ),
                                                TextSpan(
                                                  text: '*',
                                                  style: SafeGoogleFont(
                                                    'Lexend Deca',
                                                    fontSize: 17 * ffem,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.25 * ffem / fem,
                                                    color: Color(0xff5cabdf),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // inputfieldiWZ (I1:226;1:229)
                                          width: double.infinity,
                                          height: 23 * fem,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                'assets/images/video_upload/inputfield-mHX.png',
                                              ),
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                // nameofyourvideoc69 (I1:226;1:229;5:69)
                                                left: 6 * fem,
                                                top: 6 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 70 * fem,
                                                    height: 10 * fem,
                                                    child: Text(
                                                      'Select an age level',
                                                      style: SafeGoogleFont(
                                                        'Lexend Deca',
                                                        fontSize: 7.5 * ffem,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height:
                                                            1.25 * ffem / fem,
                                                        color:
                                                            Color(0xff8f9295),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // inputfieldF97 (I1:226;1:229;5:67)
                                                left: 0 * fem,
                                                top: 0 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 181 * fem,
                                                    height: 23 * fem,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    7 * fem),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xff000000)),
                                                        color:
                                                            Color(0x00d9d9d9),
                                                      ),
                                                      child: TextField(
                                                        maxLines: null,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          focusedBorder:
                                                              InputBorder.none,
                                                          enabledBorder:
                                                              InputBorder.none,
                                                          errorBorder:
                                                              InputBorder.none,
                                                          disabledBorder:
                                                              InputBorder.none,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
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
                                  // uploadavideobutton5P3 (1:277)
                                  left: 27 * fem,
                                  top: 114 * fem,
                                  child: Container(
                                    width: 330 * fem,
                                    height: 60 * fem,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          // boxZ3K (I1:277;1:22)
                                          left: 0 * fem,
                                          top: 0 * fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 328 * fem,
                                              height: 60 * fem,
                                              child: Image.asset(
                                                'assets/images/video_upload/box-X8R.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // uploadavideo2Bo (I1:277;1:23)
                                          left: 0 * fem,
                                          top: 0 * fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 328 * fem,
                                              height: 60 * fem,
                                              child: Image.asset(
                                                'assets/images/video_upload/upload-a-video.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // xJf7 (I1:277;1:24)
                                          left: 3 * fem,
                                          top: 0 * fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 327 * fem,
                                              height: 60 * fem,
                                              child: Image.asset(
                                                'assets/images/video_upload/x.png',
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
                                  // videoinputfieldtitleAhK (1:227)
                                  left: 167 * fem,
                                  top: 186 * fem,
                                  child: Container(
                                    width: 181 * fem,
                                    height: 48 * fem,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // titleesP (1:228)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 3 * fem),
                                          child: RichText(
                                            text: TextSpan(
                                              style: SafeGoogleFont(
                                                'Lexend Deca',
                                                fontSize: 17 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height: 1.25 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'Title',
                                                  style: SafeGoogleFont(
                                                    'Lexend Deca',
                                                    fontSize: 17 * ffem,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.25 * ffem / fem,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '*',
                                                  style: SafeGoogleFont(
                                                    'Lexend Deca',
                                                    fontSize: 17 * ffem,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.25 * ffem / fem,
                                                    color: Color(0xff5cabdf),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // inputfieldgBo (1:229)
                                          width: double.infinity,
                                          height: 23 * fem,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                'assets/images/video_upload/inputfield-rBP.png',
                                              ),
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                // nameofyourvideonEq (I1:229;5:69)
                                                left: 6 * fem,
                                                top: 6 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 72 * fem,
                                                    height: 10 * fem,
                                                    child: Text(
                                                      'Name of your book',
                                                      style: SafeGoogleFont(
                                                        'Lexend Deca',
                                                        fontSize: 7.5 * ffem,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height:
                                                            1.25 * ffem / fem,
                                                        color:
                                                            Color(0xff8f9295),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // inputfieldSaH (I1:229;5:67)
                                                left: 0 * fem,
                                                top: 0 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 181 * fem,
                                                    height: 23 * fem,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    7 * fem),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xff000000)),
                                                        color:
                                                            Color(0x00d9d9d9),
                                                      ),
                                                      child: TextField(
                                                        maxLines: null,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          focusedBorder:
                                                              InputBorder.none,
                                                          enabledBorder:
                                                              InputBorder.none,
                                                          errorBorder:
                                                              InputBorder.none,
                                                          disabledBorder:
                                                              InputBorder.none,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
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
                          // 4Lm (58631542)
                          left: 24 * fem,
                          top: 403 * fem,
                          child: Container(
                            width: 348 * fem,
                            height: 416 * fem,
                            child: Stack(
                              children: [
                                Positioned(
                                  // autogroup1vu79d7 (9B3Zr3pdGRgTyVPNFe1Vu7)
                                  left: 4 * fem,
                                  top: 348 * fem,
                                  child: Container(
                                    width: 344 * fem,
                                    height: 68 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // backbuttonpz9 (1:294)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              4 * fem, 8 * fem, 0 * fem),
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
                                                    'assets/images/video_upload/drop-shadow-bg-D9f.png',
                                                  ),
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    // box47o (I1:294;1:54)
                                                    left: 0 * fem,
                                                    top: 0 * fem,
                                                    child: Align(
                                                      child: SizedBox(
                                                        width: 150 * fem,
                                                        height: 29 * fem,
                                                        child: Image.asset(
                                                          'assets/images/video_upload/box-JfF.png',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    // backM6u (I1:294;1:55)
                                                    left: 48.5 * fem,
                                                    top: 6 * fem,
                                                    child: Align(
                                                      child: SizedBox(
                                                        width: 49 * fem,
                                                        height: 15 * fem,
                                                        child: Text(
                                                          'DRAFTS',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: SafeGoogleFont(
                                                            'Lexend Deca',
                                                            fontSize: 12 * ffem,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.25 *
                                                                ffem /
                                                                fem,
                                                            color: Color(
                                                                0xff000000),
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
                                        Container(
                                          // autogroup71mfBrd (9B3ZziErn9fTgRhJGE71Mf)
                                          width: 180 * fem,
                                          height: double.infinity,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                // backgroundsquare1JRT (1:192)
                                                left: 112 * fem,
                                                top: 0 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 68 * fem,
                                                    height: 68 * fem,
                                                    child: Image.asset(
                                                      'assets/images/video_upload/backgroundsquare-1-yQy.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // continuebuttonxku (1:295)
                                                left: 0 * fem,
                                                top: 4 * fem,
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
                                                          'assets/images/video_upload/drop-shadow-bg-dT3.png',
                                                        ),
                                                      ),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          // boxnE9 (I1:295;1:61)
                                                          left: 0 * fem,
                                                          top: 0 * fem,
                                                          child: Align(
                                                            child: SizedBox(
                                                              width: 150 * fem,
                                                              height: 29 * fem,
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/video_upload/box-ghj.png',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          // boxTr5 (I1:295;1:63)
                                                          left: 0 * fem,
                                                          top: 0 * fem,
                                                          child: Align(
                                                            child: SizedBox(
                                                              width: 150 * fem,
                                                              height: 29 * fem,
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/video_upload/box-gGV.png',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          // continue9yo (I1:295;1:62)
                                                          left: 54 * fem,
                                                          top: 6 * fem,
                                                          child: Align(
                                                            child: SizedBox(
                                                              width: 41 * fem,
                                                              height: 15 * fem,
                                                              child: Text(
                                                                'SHARE',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    SafeGoogleFont(
                                                                  'Lexend Deca',
                                                                  fontSize:
                                                                      12 * ffem,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  height: 1.25 *
                                                                      ffem /
                                                                      fem,
                                                                  color: Color(
                                                                      0xff000000),
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
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // videoinputfieldtopicsc6h (1:202)
                                  left: 0 * fem,
                                  top: 72 * fem,
                                  child: Container(
                                    width: 325 * fem,
                                    height: 48 * fem,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // topicsHTj (1:203)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 3 * fem),
                                          child: RichText(
                                            text: TextSpan(
                                              style: SafeGoogleFont(
                                                'Lexend Deca',
                                                fontSize: 17 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height: 1.25 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'Topic(s)',
                                                ),
                                                TextSpan(
                                                  text: '*',
                                                  style: SafeGoogleFont(
                                                    'Lexend Deca',
                                                    fontSize: 17 * ffem,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.25 * ffem / fem,
                                                    color: Color(0xff5cabdf),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // inputfieldAA9 (1:204)
                                          width: double.infinity,
                                          height: 23 * fem,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                'assets/images/video_upload/inputfield-uYy.png',
                                              ),
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                // videotopicsEQu (1:206)
                                                left: 6 * fem,
                                                top: 6 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 53 * fem,
                                                    height: 10 * fem,
                                                    child: Text(
                                                      'Video Topic(s)',
                                                      style: SafeGoogleFont(
                                                        'Lexend Deca',
                                                        fontSize: 7.5 * ffem,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height:
                                                            1.25 * ffem / fem,
                                                        color:
                                                            Color(0xff8f9295),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // inputfieldUq3 (1:207)
                                                left: 0 * fem,
                                                top: 0 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 325 * fem,
                                                    height: 23 * fem,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    7 * fem),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xff000000)),
                                                        color:
                                                            Color(0x00d9d9d9),
                                                      ),
                                                      child: TextField(
                                                        maxLines: null,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          focusedBorder:
                                                              InputBorder.none,
                                                          enabledBorder:
                                                              InputBorder.none,
                                                          errorBorder:
                                                              InputBorder.none,
                                                          disabledBorder:
                                                              InputBorder.none,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // downarrowiDb (1:208)
                                                left: 303 * fem,
                                                top: 8 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 9 * fem,
                                                    height: 8 * fem,
                                                    child: Image.asset(
                                                      'assets/images/video_upload/down-arrow-E93.png',
                                                      width: 9 * fem,
                                                      height: 8 * fem,
                                                    ),
                                                  ),
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
                                  // videoinputfielddescriptionyvD (1:209)
                                  left: 0 * fem,
                                  top: 144 * fem,
                                  child: Container(
                                    width: 325 * fem,
                                    height: 106 * fem,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // videodescriptionTqP (1:210)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 3 * fem),
                                          child: RichText(
                                            text: TextSpan(
                                              style: SafeGoogleFont(
                                                'Lexend Deca',
                                                fontSize: 17 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height: 1.25 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'Video Description',
                                                ),
                                                TextSpan(
                                                  text: '*',
                                                  style: SafeGoogleFont(
                                                    'Lexend Deca',
                                                    fontSize: 17 * ffem,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.25 * ffem / fem,
                                                    color: Color(0xff5cabdf),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // inputfieldZG9 (1:211)
                                          width: double.infinity,
                                          height: 81 * fem,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                'assets/images/video_upload/inputfield.png',
                                              ),
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                // whatisyourvideoabout2fX (1:213)
                                                left: 6 * fem,
                                                top: 6 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 98 * fem,
                                                    height: 10 * fem,
                                                    child: Text(
                                                      'What is your video about?',
                                                      style: SafeGoogleFont(
                                                        'Lexend Deca',
                                                        fontSize: 7.5 * ffem,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height:
                                                            1.25 * ffem / fem,
                                                        color:
                                                            Color(0xff8f9295),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // inputfieldreZ (1:214)
                                                left: 0 * fem,
                                                top: 0 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 325 * fem,
                                                    height: 81 * fem,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    7 * fem),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xff000000)),
                                                        color:
                                                            Color(0x00d9d9d9),
                                                      ),
                                                    ),
                                                  ),
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
                                  // videoinputfieldpriceKY9 (1:222)
                                  left: 0 * fem,
                                  top: 0 * fem,
                                  child: Container(
                                    width: 157 * fem,
                                    height: 48 * fem,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // videogenresQZb (1:223)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 3 * fem),
                                          child: RichText(
                                            text: TextSpan(
                                              style: SafeGoogleFont(
                                                'Lexend Deca',
                                                fontSize: 17 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height: 1.25 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'Video Genre(s)',
                                                ),
                                                TextSpan(
                                                  text: '*',
                                                  style: SafeGoogleFont(
                                                    'Lexend Deca',
                                                    fontSize: 17 * ffem,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.25 * ffem / fem,
                                                    color: Color(0xff5cabdf),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // inputfieldiCu (1:224)
                                          width: double.infinity,
                                          height: 23 * fem,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                // inputfieldqHX (I1:224;5:105)
                                                left: 0 * fem,
                                                top: 0 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 140.52 * fem,
                                                    height: 23 * fem,
                                                    child: Image.asset(
                                                      'assets/images/video_upload/inputfield-grR.png',
                                                      width: 140.52 * fem,
                                                      height: 23 * fem,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // inputpriceJgu (I1:224;5:106)
                                                left: 6 * fem,
                                                top: 6 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 47 * fem,
                                                    height: 10 * fem,
                                                    child: Text(
                                                      'Book Genres',
                                                      style: SafeGoogleFont(
                                                        'Lexend Deca',
                                                        fontSize: 7.5 * ffem,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height:
                                                            1.25 * ffem / fem,
                                                        color:
                                                            Color(0xff8f9295),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // inputfieldNAy (I1:224;5:107)
                                                left: 0 * fem,
                                                top: 0 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 157 * fem,
                                                    height: 23 * fem,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    7 * fem),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xff000000)),
                                                        color:
                                                            Color(0x00d9d9d9),
                                                      ),
                                                      child: DropdownButton<
                                                          String?>(
                                                        value: 'Item1',
                                                        onChanged: (String?
                                                            newValue) {},
                                                        items: [
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: 'Item1',
                                                            child:
                                                                Text('Item1'),
                                                          ),
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: 'Item2',
                                                            child:
                                                                Text('Item2'),
                                                          ),
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: 'Item3',
                                                            child:
                                                                Text('Item3'),
                                                          ),
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: 'Item4',
                                                            child:
                                                                Text('Item4'),
                                                          ),
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: 'Item5',
                                                            child:
                                                                Text('Item5'),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // downarrowwdP (3:63)
                                                left: 137.0005493164 * fem,
                                                top: 8 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 9 * fem,
                                                    height: 8 * fem,
                                                    child: Image.asset(
                                                      'assets/images/video_upload/down-arrow-Fa5.png',
                                                      width: 9 * fem,
                                                      height: 8 * fem,
                                                    ),
                                                  ),
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
                                  // inputfieldcDj (3:57)
                                  left: 167 * fem,
                                  top: 25 * fem,
                                  child: Container(
                                    width: 157 * fem,
                                    height: 23 * fem,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          // inputfieldhky (I3:57;5:97)
                                          left: 0 * fem,
                                          top: 0 * fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 140.52 * fem,
                                              height: 23 * fem,
                                              child: Image.asset(
                                                'assets/images/video_upload/inputfield-qHF.png',
                                                width: 140.52 * fem,
                                                height: 23 * fem,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // selectareadinglevelapm (I3:57;5:98)
                                          left: 6 * fem,
                                          top: 6 * fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 48 * fem,
                                              height: 10 * fem,
                                              child: Text(
                                                'Sub Genre(s)',
                                                style: SafeGoogleFont(
                                                  'Lexend Deca',
                                                  fontSize: 7.5 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.25 * ffem / fem,
                                                  color: Color(0xff8f9295),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // inputfieldqEu (I3:57;5:99)
                                          left: 0 * fem,
                                          top: 0 * fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 157 * fem,
                                              height: 23 * fem,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7 * fem),
                                                  border: Border.all(
                                                      color: Color(0xff000000)),
                                                  color: Color(0x00d9d9d9),
                                                ),
                                                child: DropdownButton<String?>(
                                                  value: 'Item1',
                                                  onChanged:
                                                      (String? newValue) {},
                                                  items: [
                                                    DropdownMenuItem<String>(
                                                      value: 'Item1',
                                                      child: Text('Item1'),
                                                    ),
                                                    DropdownMenuItem<String>(
                                                      value: 'Item2',
                                                      child: Text('Item2'),
                                                    ),
                                                    DropdownMenuItem<String>(
                                                      value: 'Item3',
                                                      child: Text('Item3'),
                                                    ),
                                                    DropdownMenuItem<String>(
                                                      value: 'Item4',
                                                      child: Text('Item4'),
                                                    ),
                                                    DropdownMenuItem<String>(
                                                      value: 'Item5',
                                                      child: Text('Item5'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // downarrow2qB (I3:57;5:100)
                                          left: 137.0004882812 * fem,
                                          top: 7 * fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 9 * fem,
                                              height: 8 * fem,
                                              child: Image.asset(
                                                'assets/images/video_upload/down-arrow.png',
                                                width: 9 * fem,
                                                height: 8 * fem,
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
                      ],
                    ),
                  ),
                ),
                Positioned(
                  // ellipse1Vim (1:195)
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
                  // profilenotificationdot19oK (1:196)
                  left: 318 * fem,
                  top: 13 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 27 * fem,
                      height: 27 * fem,
                      child: Image.asset(
                        'assets/images/video_upload/profilenotificationdot-1-4ww.png',
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
