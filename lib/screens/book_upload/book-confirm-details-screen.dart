import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:storily/components//utils.dart';

class BookConfirmDetails extends StatelessWidget {
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
        // bookconfirmdetailsscreenjt9 (5:352)
        width: double.infinity,
        height: 844*fem,
        decoration: BoxDecoration (
          color: Color(0xfff0f3f6),
        ),
        child: Stack(
          children: [
            Positioned(
              // backgroundassets2MT (5:353)
              left: 7*fem,
              top: 17*fem,
              child: Container(
                width: 382*fem,
                height: 819*fem,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // autogrouphwl9gS1 (T8kePwwdythcmY1sYVHwL9)
                      width: double.infinity,
                      height: 506.32*fem,
                      child: Stack(
                        children: [
                          Positioned(
                            // backgroundrectangledotsbJ5 (5:354)
                            left: 0*fem,
                            top: 171*fem,
                            child: Align(
                              child: SizedBox(
                                width: 75*fem,
                                height: 276*fem,
                                child: Image.asset(
                                  'assets/images/book_upload/backgroundrectangledots-C6h.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // backgroundcircledots1Ucm (5:355)
                            left: 267*fem,
                            top: 32*fem,
                            child: Align(
                              child: SizedBox(
                                width: 115*fem,
                                height: 115*fem,
                                child: Image.asset(
                                  'assets/images/book_upload/backgroundcircledots-1-oYq.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // backgroundsquiggle9D7 (5:356)
                            left: 182*fem,
                            top: 49*fem,
                            child: Align(
                              child: SizedBox(
                                width: 58*fem,
                                height: 25*fem,
                                child: Image.asset(
                                  'assets/images/book_upload/backgroundsquiggle-eQ5.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // backgroundtriangledty (5:357)
                            left: 208*fem,
                            top: 0*fem,
                            child: Align(
                              child: SizedBox(
                                width: 34*fem,
                                height: 34*fem,
                                child: Image.asset(
                                  'assets/images/book_upload/backgroundtriangle.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // coverredbook1YFF (5:444)
                            left: 121*fem,
                            top: 261*fem,
                            child: Align(
                              child: SizedBox(
                                width: 140*fem,
                                height: 245.32*fem,
                                child: Image.asset(
                                  'assets/images/book_upload/coverredbook-1.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // addbookbuttonQYM (5:359)
                            left: 27*fem,
                            top: 114*fem,
                            child: Container(
                              width: 330*fem,
                              height: 60*fem,
                              child: Stack(
                                children: [
                                  Positioned(
                                    // box6vy (I5:359;4:30)
                                    left: 0*fem,
                                    top: 0*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 328*fem,
                                        height: 60*fem,
                                        child: Image.asset(
                                          'assets/images/book_upload/box-yo3.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // addabookoqP (I5:359;4:31)
                                    left: 0*fem,
                                    top: 0*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 328*fem,
                                        height: 60*fem,
                                        child: Image.asset(
                                          'assets/images/book_upload/add-a-book-GZb.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // xJn9 (I5:359;4:32)
                                    left: 3*fem,
                                    top: 0*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 327*fem,
                                        height: 60*fem,
                                        child: Image.asset(
                                          'assets/images/book_upload/x-HQ1.png',
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
                            // nameinformationpVb (5:360)
                            left: 24*fem,
                            top: 18*fem,
                            child: Container(
                              width: 249*fem,
                              height: 82*fem,
                              decoration: BoxDecoration (
                                color: Color(0x00d9d9d9),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    // hinameVrd (I5:360;3:23)
                                    left: 0*fem,
                                    top: 14*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 135*fem,
                                        height: 37*fem,
                                        child: Text(
                                          'Hi, Name\n',
                                          style: SafeGoogleFont (
                                            'Lexend Deca',
                                            fontSize: 29*ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.25*ffem/fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // xxLMT (I5:360;3:24)
                                    left: 0*fem,
                                    top: 3*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 69*fem,
                                        height: 14*fem,
                                        child: Text(
                                          '00/00/20XX',
                                          style: SafeGoogleFont (
                                            'Lexend Deca',
                                            fontSize: 11*ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.25*ffem/fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // welcometoyourdashboardCPf (I5:360;3:25)
                                    left: 0*fem,
                                    top: 47*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 177*fem,
                                        height: 17*fem,
                                        child: Text(
                                          'Welcome to your dashboard.',
                                          style: SafeGoogleFont (
                                            'Lexend Deca',
                                            fontSize: 13*ffem,
                                            fontWeight: FontWeight.w300,
                                            height: 1.25*ffem/fem,
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
                            // pleaseconfirmdetailsfHF (5:446)
                            left: 64*fem,
                            top: 174*fem,
                            child: Align(
                              child: SizedBox(
                                width: 249*fem,
                                height: 80*fem,
                                child: Text(
                                  'Please Confirm \nDetails.',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont (
                                    'Lexend Deca',
                                    fontSize: 32*ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.25*ffem/fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // autogrouppt9phUq (T8kgUtU82BzpGzZbzYPT9P)
                      padding: EdgeInsets.fromLTRB(26*fem, 20.68*fem, 10*fem, 0*fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // autogroupuzkqzTw (T8kezvwMAd6Kxw2uH1uZkq)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 17*fem, 19*fem),
                            width: 329*fem,
                            height: 48*fem,
                            child: Stack(
                              children: [
                                Positioned(
                                  // underlinemainfa5 (5:447)
                                  left: 72*fem,
                                  top: 21*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 43*fem,
                                      height: 3*fem,
                                      child: Container(
                                        decoration: BoxDecoration (
                                          color: Color(0xffef706c),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // underlinesubYtm (5:448)
                                  left: 124*fem,
                                  top: 21*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 44*fem,
                                      height: 3*fem,
                                      child: Container(
                                        decoration: BoxDecoration (
                                          color: Color(0xfff7bbb1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // underlinesubewo (6:73)
                                  left: 177*fem,
                                  top: 21*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 43*fem,
                                      height: 3*fem,
                                      child: Container(
                                        decoration: BoxDecoration (
                                          color: Color(0xfff7bbb1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // underlinesubmFj (6:74)
                                  left: 231*fem,
                                  top: 21*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 43*fem,
                                      height: 3*fem,
                                      child: Container(
                                        decoration: BoxDecoration (
                                          color: Color(0xfff7bbb1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // underlinemainUA9 (6:80)
                                  left: 72*fem,
                                  top: 41*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 43*fem,
                                      height: 3*fem,
                                      child: Container(
                                        decoration: BoxDecoration (
                                          color: Color(0xffef706c),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // underlinesubxr1 (6:81)
                                  left: 124*fem,
                                  top: 41*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 44*fem,
                                      height: 3*fem,
                                      child: Container(
                                        decoration: BoxDecoration (
                                          color: Color(0xfff7bbb1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // underlinesubTXs (6:82)
                                  left: 177*fem,
                                  top: 41*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 43*fem,
                                      height: 3*fem,
                                      child: Container(
                                        decoration: BoxDecoration (
                                          color: Color(0xfff7bbb1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // underlinesub99o (6:83)
                                  left: 231*fem,
                                  top: 41*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 43*fem,
                                      height: 3*fem,
                                      child: Container(
                                        decoration: BoxDecoration (
                                          color: Color(0xfff7bbb1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // rectangle5RND (5:449)
                                  left: 0*fem,
                                  top: 0*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 329*fem,
                                      height: 48*fem,
                                      child: Container(
                                        decoration: BoxDecoration (
                                          borderRadius: BorderRadius.circular(7*fem),
                                          border: Border.all(color: Color(0xff000000)),
                                          color: Color(0x00d9d9d9),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // genre14vy (6:76)
                                  left: 72*fem,
                                  top: 8*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 42*fem,
                                      height: 13*fem,
                                      child: Text(
                                        'Genre#1',
                                        style: SafeGoogleFont (
                                          'Lexend Deca',
                                          fontSize: 10*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // genre2XpZ (6:77)
                                  left: 125*fem,
                                  top: 8*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 42*fem,
                                      height: 13*fem,
                                      child: Text(
                                        'Genre#2',
                                        style: SafeGoogleFont (
                                          'Lexend Deca',
                                          fontSize: 10*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // genre31jj (6:78)
                                  left: 177*fem,
                                  top: 8*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 42*fem,
                                      height: 13*fem,
                                      child: Text(
                                        'Genre#3',
                                        style: SafeGoogleFont (
                                          'Lexend Deca',
                                          fontSize: 10*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // genre4toX (6:79)
                                  left: 231*fem,
                                  top: 8*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 43*fem,
                                      height: 13*fem,
                                      child: Text(
                                        'Genre#4',
                                        style: SafeGoogleFont (
                                          'Lexend Deca',
                                          fontSize: 10*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // topics1ya5 (6:84)
                                  left: 72*fem,
                                  top: 28*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 44*fem,
                                      height: 13*fem,
                                      child: Text(
                                        'Topics#1',
                                        style: SafeGoogleFont (
                                          'Lexend Deca',
                                          fontSize: 10*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // topics2rds (6:85)
                                  left: 125*fem,
                                  top: 28*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 44*fem,
                                      height: 13*fem,
                                      child: Text(
                                        'Topics#2',
                                        style: SafeGoogleFont (
                                          'Lexend Deca',
                                          fontSize: 10*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // topics3xB7 (6:86)
                                  left: 177*fem,
                                  top: 28*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 44*fem,
                                      height: 13*fem,
                                      child: Text(
                                        'Topics#3',
                                        style: SafeGoogleFont (
                                          'Lexend Deca',
                                          fontSize: 10*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // topics42wf (6:87)
                                  left: 231*fem,
                                  top: 28*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 45*fem,
                                      height: 13*fem,
                                      child: Text(
                                        'Topics#4',
                                        style: SafeGoogleFont (
                                          'Lexend Deca',
                                          fontSize: 10*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // group4hY1 (6:98)
                                  left: 284.8692626953*fem,
                                  top: 7*fem,
                                  child: Container(
                                    width: 33*fem,
                                    height: 32.74*fem,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // readinglevel2blueiconBCH (6:99)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 1.56*fem),
                                          width: 20.24*fem,
                                          height: 24.18*fem,
                                          child: Image.asset(
                                            'assets/images/book_upload/readinglevel2blueicon.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Center(
                                          // intermediateFxq (6:100)
                                          child: Text(
                                            'Intermediate',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont (
                                              'Lexend Deca',
                                              fontSize: 5*ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.25*ffem/fem,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // topicsN1s (6:101)
                                  left: 22.5*fem,
                                  top: 28*fem,
                                  child: Center(
                                    child: Align(
                                      child: SizedBox(
                                        width: 38*fem,
                                        height: 15*fem,
                                        child: Text(
                                          'Topics',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont (
                                            'Lexend Deca',
                                            fontSize: 12*ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.25*ffem/fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // genres2cD (6:102)
                                  left: 20.5*fem,
                                  top: 7*fem,
                                  child: Center(
                                    child: Align(
                                      child: SizedBox(
                                        width: 42*fem,
                                        height: 15*fem,
                                        child: Text(
                                          'Genres',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont (
                                            'Lexend Deca',
                                            fontSize: 12*ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.25*ffem/fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // rectangle6tuK (6:88)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 17*fem, 6*fem),
                            width: 329*fem,
                            height: 151*fem,
                            decoration: BoxDecoration (
                              borderRadius: BorderRadius.circular(7*fem),
                              border: Border.all(color: Color(0xff000000)),
                              color: Color(0x00d9d9d9),
                            ),
                          ),
                          Container(
                            // autogroupguk9BdX (T8kg4ZqKACMV2SYLRfGuk9)
                            margin: EdgeInsets.fromLTRB(2*fem, 0*fem, 0*fem, 0*fem),
                            width: double.infinity,
                            height: 68*fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // backbuttontH3 (5:363)
                                  margin: EdgeInsets.fromLTRB(0*fem, 4*fem, 8*fem, 0*fem),
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom (
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Container(
                                      width: 156*fem,
                                      height: 35*fem,
                                      decoration: BoxDecoration (
                                        image: DecorationImage (
                                          fit: BoxFit.cover,
                                          image: AssetImage (
                                            'assets/images/book_upload/drop-shadow-bg.png',
                                          ),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            // boxvUd (I5:363;3:66)
                                            left: 0*fem,
                                            top: 0*fem,
                                            child: Align(
                                              child: SizedBox(
                                                width: 150*fem,
                                                height: 29*fem,
                                                child: Image.asset(
                                                  'assets/images/book_upload/box-PBj.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            // backRgH (I5:363;3:67)
                                            left: 56*fem,
                                            top: 6*fem,
                                            child: Align(
                                              child: SizedBox(
                                                width: 34*fem,
                                                height: 15*fem,
                                                child: Text(
                                                  'BACK',
                                                  textAlign: TextAlign.center,
                                                  style: SafeGoogleFont (
                                                    'Lexend Deca',
                                                    fontSize: 12*ffem,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.25*ffem/fem,
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
                                Container(
                                  // autogroup22jy61j (T8kgCjGNyAePAuBJtz22Jy)
                                  width: 180*fem,
                                  height: double.infinity,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        // backgroundsquare1D6M (5:358)
                                        left: 112*fem,
                                        top: 0*fem,
                                        child: Align(
                                          child: SizedBox(
                                            width: 68*fem,
                                            height: 68*fem,
                                            child: Image.asset(
                                              'assets/images/book_upload/backgroundsquare-1.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        // continuebuttonWLM (5:364)
                                        left: 0*fem,
                                        top: 4*fem,
                                        child: TextButton(
                                          onPressed: () {},
                                          style: TextButton.styleFrom (
                                            padding: EdgeInsets.zero,
                                          ),
                                          child: Container(
                                            width: 156*fem,
                                            height: 35*fem,
                                            decoration: BoxDecoration (
                                              image: DecorationImage (
                                                fit: BoxFit.cover,
                                                image: AssetImage (
                                                  'assets/images/book_upload/drop-shadow-bg-Pyw.png',
                                                ),
                                              ),
                                            ),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  // boxAvh (I5:364;3:71)
                                                  left: 0*fem,
                                                  top: 0*fem,
                                                  child: Align(
                                                    child: SizedBox(
                                                      width: 150*fem,
                                                      height: 29*fem,
                                                      child: Image.asset(
                                                        'assets/images/book_upload/box-UFo.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  // continuerYd (I5:364;3:72)
                                                  left: 41*fem,
                                                  top: 6*fem,
                                                  child: Align(
                                                    child: SizedBox(
                                                      width: 67*fem,
                                                      height: 15*fem,
                                                      child: Text(
                                                        'CONTINUE',
                                                        textAlign: TextAlign.center,
                                                        style: SafeGoogleFont (
                                                          'Lexend Deca',
                                                          fontSize: 12*ffem,
                                                          fontWeight: FontWeight.w500,
                                                          height: 1.25*ffem/fem,
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
                              ],
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
              // ellipse1v2h (5:361)
              left: 250*fem,
              top: 13*fem,
              child: Align(
                child: SizedBox(
                  width: 101*fem,
                  height: 101*fem,
                  child: Container(
                    decoration: BoxDecoration (
                      borderRadius: BorderRadius.circular(50.5*fem),
                      border: Border.all(color: Color(0xff000000)),
                      color: Color(0xffd9d9d9),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // profilenotificationdot1N9b (5:362)
              left: 318*fem,
              top: 13*fem,
              child: Align(
                child: SizedBox(
                  width: 27*fem,
                  height: 27*fem,
                  child: Image.asset(
                    'assets/images/book_upload/profilenotificationdot-1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ) );
  }
}