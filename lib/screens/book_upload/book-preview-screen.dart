import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:storily/components//utils.dart';

class BookPreview extends StatelessWidget {
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
        body:  Container(
      width: double.infinity,
      child: Container(
        // bookpreviewscreenb25 (2:3)
        width: double.infinity,
        height: 844*fem,
        decoration: BoxDecoration (
          color: Color(0xfff0f3f6),
        ),
        child: Stack(
          children: [
            Positioned(
              // backgroundassetsDhf (4:10)
              left: 7*fem,
              top: 17*fem,
              child: Container(
                width: 382*fem,
                height: 819*fem,
                child: Stack(
                  children: [
                    Positioned(
                      // autogroupd6erGvq (T8kXyTycwmSqRGiq7DD6eR)
                      left: 0*fem,
                      top: 171*fem,
                      child: Container(
                        width: 376*fem,
                        height: 555*fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // autogroupn6nqYNZ (T8kYJ3H1E6e4jLX5yYn6nq)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 10.01*fem, 0*fem),
                              width: 332*fem,
                              height: double.infinity,
                              child: Stack(
                                children: [
                                  Positioned(
                                    // backgroundrectangledotsqFB (4:4)
                                    left: 0*fem,
                                    top: 0*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 75*fem,
                                        height: 276*fem,
                                        child: Image.asset(
                                          'assets/images/book_upload/backgroundrectangledots.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // previewboxHss (3:73)
                                    left: 44*fem,
                                    top: 44*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 288*fem,
                                        height: 511*fem,
                                        child: Image.asset(
                                          'assets/images/book_upload/preview-box.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // bookpreviewARs (3:74)
                                    left: 136*fem,
                                    top: 9*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 108*fem,
                                        height: 20*fem,
                                        child: Text(
                                          'Book Preview',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont (
                                            'Lexend Deca',
                                            fontSize: 16*ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.25*ffem/fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // leftarrowYxD (4:19)
                                    left: 2.0067138672*fem,
                                    top: 257.0034179688*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 34*fem,
                                        height: 42*fem,
                                        child: Image.asset(
                                          'assets/images/book_upload/left-arrow.png',
                                          width: 34*fem,
                                          height: 42*fem,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // rightarrowbQh (4:17)
                              margin: EdgeInsets.fromLTRB(0*fem, 1.01*fem, 0*fem, 0*fem),
                              width: 34*fem,
                              height: 42*fem,
                              child: Image.asset(
                                'assets/images/book_upload/right-arrow.png',
                                width: 34*fem,
                                height: 42*fem,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // autogroupouudUDb (T8kXN4pwLjyiFoyfkxoUUd)
                      left: 182*fem,
                      top: 0*fem,
                      child: Container(
                        width: 200*fem,
                        height: 147*fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // autogroupkitmYUM (T8kXcJvCsDBSiQcxd1Kitm)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 25*fem, 0*fem),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    // backgroundtriangleF7s (4:9)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 15*fem),
                                    width: 34*fem,
                                    height: 34*fem,
                                    child: Image.asset(
                                      'assets/images/book_upload/backgroundtriangle-C3F.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    // backgroundsquiggleY6y (4:8)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 2*fem, 0*fem),
                                    width: 58*fem,
                                    height: 25*fem,
                                    child: Image.asset(
                                      'assets/images/book_upload/backgroundsquiggle.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // backgroundcircledots1RgZ (4:7)
                              margin: EdgeInsets.fromLTRB(0*fem, 32*fem, 0*fem, 0*fem),
                              width: 115*fem,
                              height: 115*fem,
                              child: Image.asset(
                                'assets/images/book_upload/backgroundcircledots-1-vJ1.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // autogroupqizkuLq (T8kYbHHGy5zNYoC85BQiZK)
                      left: 28*fem,
                      top: 751*fem,
                      child: Container(
                        width: 344*fem,
                        height: 68*fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // backbuttonC53 (5:281)
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
                                        'assets/images/book_upload/drop-shadow-bg-cFf.png',
                                      ),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        // box12V (I5:281;3:66)
                                        left: 0*fem,
                                        top: 0*fem,
                                        child: Align(
                                          child: SizedBox(
                                            width: 150*fem,
                                            height: 29*fem,
                                            child: Image.asset(
                                              'assets/images/book_upload/box.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        // back5o3 (I5:281;3:67)
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
                              // autogroupgdwbXQ9 (T8kYin4nWPMowxGVA9gdwB)
                              width: 180*fem,
                              height: double.infinity,
                              child: Stack(
                                children: [
                                  Positioned(
                                    // backgroundsquare1Fb3 (4:12)
                                    left: 112*fem,
                                    top: 0*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 68*fem,
                                        height: 68*fem,
                                        child: Image.asset(
                                          'assets/images/book_upload/backgroundsquare-1-59X.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // continuebuttonLsP (5:282)
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
                                              'assets/images/book_upload/drop-shadow-bg-Hsb.png',
                                            ),
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              // boxyfT (I5:282;3:71)
                                              left: 0*fem,
                                              top: 0*fem,
                                              child: Align(
                                                child: SizedBox(
                                                  width: 150*fem,
                                                  height: 29*fem,
                                                  child: Image.asset(
                                                    'assets/images/book_upload/box-iUu.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              // continueGeZ (I5:282;3:72)
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
                    ),
                    Positioned(
                      // addbookbuttonL8d (3:13)
                      left: 27*fem,
                      top: 114*fem,
                      child: Container(
                        width: 322*fem,
                        height: 55*fem,
                        child: Stack(
                          children: [
                            Positioned(
                              // boxp3o (4:30)
                              left: 0*fem,
                              top: 0*fem,
                              child: Align(
                                child: SizedBox(
                                  width: 328*fem,
                                  height: 60*fem,
                                  child: Image.asset(
                                    'assets/images/book_upload/box-VN5.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // addabookV9w (4:31)
                              left: 0*fem,
                              top: 0*fem,
                              child: Align(
                                child: SizedBox(
                                  width: 328*fem,
                                  height: 60*fem,
                                  child: Image.asset(
                                    'assets/images/book_upload/add-a-book.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // xAG5 (4:32)
                              left: 3*fem,
                              top: 0*fem,
                              child: Align(
                                child: SizedBox(
                                  width: 327*fem,
                                  height: 60*fem,
                                  child: Image.asset(
                                    'assets/images/book_upload/x.png',
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
                      // nameinformationSzH (3:22)
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
                              // hinamejyP (3:23)
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
                              // xx1AD (3:24)
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
                              // welcometoyourdashboardsTK (3:25)
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
                  ],
                ),
              ),
            ),
            Positioned(
              // ellipse1XXs (3:28)
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
              // profilenotificationdot1nyb (4:16)
              left: 318*fem,
              top: 13*fem,
              child: Align(
                child: SizedBox(
                  width: 27*fem,
                  height: 27*fem,
                  child: Image.asset(
                    'assets/images/book_upload/profilenotificationdot-1-WaH.png',
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