import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:storily/components//utils.dart';

class BookInputDetails extends StatelessWidget {
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
        // bookinputdetailsscreenFsj (5:316)
        width: double.infinity,
        height: 844*fem,
        decoration: BoxDecoration (
          color: Color(0xfff0f3f6),
        ),
        child: Stack(
          children: [
            Positioned(
              // backgroundassetsLuB (5:317)
              left: 7*fem,
              top: 17*fem,
              child: Container(
                width: 382*fem,
                height: 819*fem,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // autogroupvchtcrh (T8ka5zHoNnS1CaEG6bvCHT)
                      width: double.infinity,
                      height: 447*fem,
                      child: Stack(
                        children: [
                          Positioned(
                            // backgroundrectangledotsXim (5:318)
                            left: 0*fem,
                            top: 171*fem,
                            child: Align(
                              child: SizedBox(
                                width: 75*fem,
                                height: 276*fem,
                                child: Image.asset(
                                  'assets/images/book_upload/backgroundrectangledots-jCh.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // backgroundcircledots1QnZ (5:319)
                            left: 267*fem,
                            top: 32*fem,
                            child: Align(
                              child: SizedBox(
                                width: 115*fem,
                                height: 115*fem,
                                child: Image.asset(
                                  'assets/images/book_upload/backgroundcircledots-1.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // backgroundsquiggleujK (5:320)
                            left: 182*fem,
                            top: 49*fem,
                            child: Align(
                              child: SizedBox(
                                width: 58*fem,
                                height: 25*fem,
                                child: Image.asset(
                                  'assets/images/book_upload/backgroundsquiggle-bc1.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // backgroundtrianglep5b (5:321)
                            left: 208*fem,
                            top: 0*fem,
                            child: Align(
                              child: SizedBox(
                                width: 34*fem,
                                height: 34*fem,
                                child: Image.asset(
                                  'assets/images/book_upload/backgroundtriangle-A9B.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // addbookbuttonWUD (5:323)
                            left: 27*fem,
                            top: 114*fem,
                            child: Container(
                              width: 330*fem,
                              height: 60*fem,
                              child: Stack(
                                children: [
                                  Positioned(
                                    // boxQ3o (I5:323;4:30)
                                    left: 0*fem,
                                    top: 0*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 328*fem,
                                        height: 60*fem,
                                        child: Image.asset(
                                          'assets/images/book_upload/box-MDw.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // addabookVqw (I5:323;4:31)
                                    left: 0*fem,
                                    top: 0*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 328*fem,
                                        height: 60*fem,
                                        child: Image.asset(
                                          'assets/images/book_upload/add-a-book-52M.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // xByf (I5:323;4:32)
                                    left: 3*fem,
                                    top: 0*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 327*fem,
                                        height: 60*fem,
                                        child: Image.asset(
                                          'assets/images/book_upload/x-vfF.png',
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
                            // nameinformationu8y (5:324)
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
                                    // hinameaW1 (I5:324;3:23)
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
                                    // xxcBo (I5:324;3:24)
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
                                    // welcometoyourdashboard4Zb (I5:324;3:25)
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
                            // addfileWAh (5:65)
                            left: 32*fem,
                            top: 188*fem,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(6*fem, 106*fem, 6*fem, 60*fem),
                              width: 109*fem,
                              height: 191*fem,
                              decoration: BoxDecoration (
                                image: DecorationImage (
                                  fit: BoxFit.cover,
                                  image: AssetImage (
                                    'assets/images/book_upload/coverredbook-1-bg.png',
                                  ),
                                ),
                              ),
                              child: Center(
                                // coverredaddfiles1wmo (4:64)
                                child: SizedBox(
                                  width: 97*fem,
                                  height: 25*fem,
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom (
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Image.asset(
                                      'assets/images/book_upload/coverredaddfiles-1.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // bookinputfieldauthorEW1 (5:139)
                            left: 167*fem,
                            top: 258*fem,
                            child: Container(
                              width: 181*fem,
                              height: 48*fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // titleXzu (I5:139;5:66)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 3*fem),
                                    child: RichText(
                                      text: TextSpan(
                                        style: SafeGoogleFont (
                                          'Lexend Deca',
                                          fontSize: 17*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Author(s)',
                                          ),
                                          TextSpan(
                                            text: '*',
                                            style: SafeGoogleFont (
                                              'Lexend Deca',
                                              fontSize: 17*ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.25*ffem/fem,
                                              color: Color(0xffef706c),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // inputfieldTQh (I5:139;5:127)
                                    width: double.infinity,
                                    height: 23*fem,
                                    decoration: BoxDecoration (
                                      image: DecorationImage (
                                        fit: BoxFit.cover,
                                        image: AssetImage (
                                          'assets/images/book_upload/inputfield-QgV.png',
                                        ),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          // nameofyourbookk8u (I5:139;5:127;5:69)
                                          left: 6*fem,
                                          top: 6*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 83*fem,
                                              height: 10*fem,
                                              child: Text(
                                                'Name of the author(s)',
                                                style: SafeGoogleFont (
                                                  'Lexend Deca',
                                                  fontSize: 7.5*ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.25*ffem/fem,
                                                  color: Color(0xff8f9295),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // inputfieldoN5 (I5:139;5:127;5:67)
                                          left: 0*fem,
                                          top: 0*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 181*fem,
                                              height: 23*fem,
                                              child: Container(
                                                decoration: BoxDecoration (
                                                  borderRadius: BorderRadius.circular(7*fem),
                                                  border: Border.all(color: Color(0xff000000)),
                                                  color: Color(0x00d9d9d9),
                                                ),
                                                child: TextField(
                                                  maxLines: null,
                                                  decoration: InputDecoration (
                                                    border: InputBorder.none,
                                                    focusedBorder: InputBorder.none,
                                                    enabledBorder: InputBorder.none,
                                                    errorBorder: InputBorder.none,
                                                    disabledBorder: InputBorder.none,
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
                            // bookinputfieldillustratorcKX (5:145)
                            left: 167*fem,
                            top: 330*fem,
                            child: Container(
                              width: 181*fem,
                              height: 48*fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // titletXw (I5:145;5:66)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 3*fem),
                                    child: RichText(
                                      text: TextSpan(
                                        style: SafeGoogleFont (
                                          'Lexend Deca',
                                          fontSize: 17*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Illustrator(s)',
                                          ),
                                          TextSpan(
                                            text: '*',
                                            style: SafeGoogleFont (
                                              'Lexend Deca',
                                              fontSize: 17*ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.25*ffem/fem,
                                              color: Color(0xffef706c),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // inputfieldn13 (I5:145;5:127)
                                    width: double.infinity,
                                    height: 23*fem,
                                    decoration: BoxDecoration (
                                      image: DecorationImage (
                                        fit: BoxFit.cover,
                                        image: AssetImage (
                                          'assets/images/book_upload/inputfield-Rpy.png',
                                        ),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          // nameofyourbookGgu (I5:145;5:127;5:69)
                                          left: 6*fem,
                                          top: 6*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 94*fem,
                                              height: 10*fem,
                                              child: Text(
                                                'Name of the illustrator(s)',
                                                style: SafeGoogleFont (
                                                  'Lexend Deca',
                                                  fontSize: 7.5*ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.25*ffem/fem,
                                                  color: Color(0xff8f9295),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // inputfielduUy (I5:145;5:127;5:67)
                                          left: 0*fem,
                                          top: 0*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 181*fem,
                                              height: 23*fem,
                                              child: Container(
                                                decoration: BoxDecoration (
                                                  borderRadius: BorderRadius.circular(7*fem),
                                                  border: Border.all(color: Color(0xff000000)),
                                                  color: Color(0x00d9d9d9),
                                                ),
                                                child: TextField(
                                                  maxLines: null,
                                                  decoration: InputDecoration (
                                                    border: InputBorder.none,
                                                    focusedBorder: InputBorder.none,
                                                    enabledBorder: InputBorder.none,
                                                    errorBorder: InputBorder.none,
                                                    disabledBorder: InputBorder.none,
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
                    Container(
                      // autogroupq5xbwwT (T8kbFNXBx29GCZxhwnq5Xb)
                      width: double.infinity,
                      height: 372*fem,
                      child: Stack(
                        children: [
                          Positioned(
                            // autogroupazsxTeu (T8kajJYxWN3q1XiRgNAzsX)
                            left: 28*fem,
                            top: 304*fem,
                            child: Container(
                              width: 344*fem,
                              height: 68*fem,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // backbuttonx5s (5:333)
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
                                              'assets/images/book_upload/drop-shadow-bg-6j7.png',
                                            ),
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              // boxASq (I5:333;3:66)
                                              left: 0*fem,
                                              top: 0*fem,
                                              child: Align(
                                                child: SizedBox(
                                                  width: 150*fem,
                                                  height: 29*fem,
                                                  child: Image.asset(
                                                    'assets/images/book_upload/box-zxD.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              // back3Wd (I5:333;3:67)
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
                                    // autogroupuwayJBf (T8kasYpDbnxQkQJE5EUWay)
                                    width: 180*fem,
                                    height: double.infinity,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          // backgroundsquare12dT (5:322)
                                          left: 112*fem,
                                          top: 0*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 68*fem,
                                              height: 68*fem,
                                              child: Image.asset(
                                                'assets/images/book_upload/backgroundsquare-1-L5T.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // continuebuttonjGy (5:334)
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
                                                    'assets/images/book_upload/drop-shadow-bg-W7X.png',
                                                  ),
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    // boxaHb (I5:334;3:71)
                                                    left: 0*fem,
                                                    top: 0*fem,
                                                    child: Align(
                                                      child: SizedBox(
                                                        width: 150*fem,
                                                        height: 29*fem,
                                                        child: Image.asset(
                                                          'assets/images/book_upload/box-FbK.png',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    // continues1o (I5:334;3:72)
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
                            // bookinputfieldtopics8TX (5:257)
                            left: 24*fem,
                            top: 101*fem,
                            child: Container(
                              width: 325*fem,
                              height: 48*fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // topicsDzm (5:240)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 3*fem),
                                    child: RichText(
                                      text: TextSpan(
                                        style: SafeGoogleFont (
                                          'Lexend Deca',
                                          fontSize: 17*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Topic(s)',
                                          ),
                                          TextSpan(
                                            text: '*',
                                            style: SafeGoogleFont (
                                              'Lexend Deca',
                                              fontSize: 17*ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.25*ffem/fem,
                                              color: Color(0xffef706c),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // inputfieldKgR (5:248)
                                    width: double.infinity,
                                    height: 23*fem,
                                    decoration: BoxDecoration (
                                      image: DecorationImage (
                                        fit: BoxFit.cover,
                                        image: AssetImage (
                                          'assets/images/book_upload/inputfield-pUM.png',
                                        ),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          // booktopicsRDf (5:250)
                                          left: 6*fem,
                                          top: 6*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 50*fem,
                                              height: 10*fem,
                                              child: Text(
                                                'Book Topic(s)',
                                                style: SafeGoogleFont (
                                                  'Lexend Deca',
                                                  fontSize: 7.5*ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.25*ffem/fem,
                                                  color: Color(0xff8f9295),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // inputfieldUxd (5:251)
                                          left: 0*fem,
                                          top: 0*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 325*fem,
                                              height: 23*fem,
                                              child: Container(
                                                decoration: BoxDecoration (
                                                  borderRadius: BorderRadius.circular(7*fem),
                                                  border: Border.all(color: Color(0xff000000)),
                                                  color: Color(0x00d9d9d9),
                                                ),
                                                child: DropdownButton<String?>(
                                                  value: 'Item1',
                                                  onChanged: (String? newValue) {},
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
                                          // downarrowGtV (5:256)
                                          left: 303*fem,
                                          top: 8*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 9*fem,
                                              height: 8*fem,
                                              child: Image.asset(
                                                'assets/images/book_upload/down-arrow-L1B.png',
                                                width: 9*fem,
                                                height: 8*fem,
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
                            // bookinputfielddescriptionxmK (5:272)
                            left: 24*fem,
                            top: 173*fem,
                            child: Container(
                              width: 325*fem,
                              height: 106*fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // bookdescriptionrLu (5:266)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 3*fem),
                                    child: RichText(
                                      text: TextSpan(
                                        style: SafeGoogleFont (
                                          'Lexend Deca',
                                          fontSize: 17*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Book Description',
                                          ),
                                          TextSpan(
                                            text: '*',
                                            style: SafeGoogleFont (
                                              'Lexend Deca',
                                              fontSize: 17*ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.25*ffem/fem,
                                              color: Color(0xffef706c),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // inputfieldXrM (5:267)
                                    width: double.infinity,
                                    height: 81*fem,
                                    decoration: BoxDecoration (
                                      image: DecorationImage (
                                        fit: BoxFit.cover,
                                        image: AssetImage (
                                          'assets/images/book_upload/inputfield-9ED.png',
                                        ),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          // whatisyourbookaboutqMF (5:269)
                                          left: 6*fem,
                                          top: 6*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 96*fem,
                                              height: 10*fem,
                                              child: Text(
                                                'What is your book about?',
                                                style: SafeGoogleFont (
                                                  'Lexend Deca',
                                                  fontSize: 7.5*ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.25*ffem/fem,
                                                  color: Color(0xff8f9295),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // inputfield6HB (5:270)
                                          left: 0*fem,
                                          top: 0*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 325*fem,
                                              height: 81*fem,
                                              child: Container(
                                                decoration: BoxDecoration (
                                                  borderRadius: BorderRadius.circular(7*fem),
                                                  border: Border.all(color: Color(0xff000000)),
                                                  color: Color(0x00d9d9d9),
                                                ),
                                                child: TextField(
                                                  maxLines: null,
                                                  decoration: InputDecoration (
                                                    border: InputBorder.none,
                                                    focusedBorder: InputBorder.none,
                                                    enabledBorder: InputBorder.none,
                                                    errorBorder: InputBorder.none,
                                                    disabledBorder: InputBorder.none,
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
                            // bookinputfieldgenresv1K (5:232)
                            left: 24*fem,
                            top: 28*fem,
                            child: Container(
                              width: 324*fem,
                              height: 49*fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // bookgenresarZ (5:219)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 4*fem),
                                    child: RichText(
                                      text: TextSpan(
                                        style: SafeGoogleFont (
                                          'Lexend Deca',
                                          fontSize: 17*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Book Genre(s)',
                                          ),
                                          TextSpan(
                                            text: '*',
                                            style: SafeGoogleFont (
                                              'Lexend Deca',
                                              fontSize: 17*ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.25*ffem/fem,
                                              color: Color(0xffef706c),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // autogroupbxuutVs (T8kbmc9oxbU4aS6e4JbxUu)
                                    width: double.infinity,
                                    height: 23*fem,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // inputfieldCmT (5:220)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 10*fem, 0*fem),
                                          width: 157*fem,
                                          height: double.infinity,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                // inputfieldssb (I5:220;5:97)
                                                left: 0*fem,
                                                top: 0*fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 140.52*fem,
                                                    height: 23*fem,
                                                    child: Image.asset(
                                                      'assets/images/book_upload/inputfield.png',
                                                      width: 140.52*fem,
                                                      height: 23*fem,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // selectareadinglevelM25 (I5:220;5:98)
                                                left: 6*fem,
                                                top: 6*fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 47*fem,
                                                    height: 10*fem,
                                                    child: Text(
                                                      'Book Genres',
                                                      style: SafeGoogleFont (
                                                        'Lexend Deca',
                                                        fontSize: 7.5*ffem,
                                                        fontWeight: FontWeight.w500,
                                                        height: 1.25*ffem/fem,
                                                        color: Color(0xff8f9295),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // inputfieldafX (I5:220;5:99)
                                                left: 0*fem,
                                                top: 0*fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 157*fem,
                                                    height: 23*fem,
                                                    child: Container(
                                                      decoration: BoxDecoration (
                                                        borderRadius: BorderRadius.circular(7*fem),
                                                        border: Border.all(color: Color(0xff000000)),
                                                        color: Color(0x00d9d9d9),
                                                      ),
                                                      child: DropdownButton<String?>(
                                                        value: 'Item1',
                                                        onChanged: (String? newValue) {},
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
                                                // downarrowB9X (I5:220;5:100)
                                                left: 137.0004882812*fem,
                                                top: 7*fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 9*fem,
                                                    height: 8*fem,
                                                    child: Image.asset(
                                                      'assets/images/book_upload/down-arrow.png',
                                                      width: 9*fem,
                                                      height: 8*fem,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // inputfieldTcq (5:226)
                                          width: 157*fem,
                                          height: double.infinity,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                // inputfieldybB (I5:226;5:97)
                                                left: 0*fem,
                                                top: 0*fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 140.52*fem,
                                                    height: 23*fem,
                                                    child: Image.asset(
                                                      'assets/images/book_upload/inputfield-sdF.png',
                                                      width: 140.52*fem,
                                                      height: 23*fem,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // selectareadinglevel4sX (I5:226;5:98)
                                                left: 6*fem,
                                                top: 6*fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 47*fem,
                                                    height: 10*fem,
                                                    child: Text(
                                                      'Book Genres',
                                                      style: SafeGoogleFont (
                                                        'Lexend Deca',
                                                        fontSize: 7.5*ffem,
                                                        fontWeight: FontWeight.w500,
                                                        height: 1.25*ffem/fem,
                                                        color: Color(0xff8f9295),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // inputfieldXm7 (I5:226;5:99)
                                                left: 0*fem,
                                                top: 0*fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 157*fem,
                                                    height: 23*fem,
                                                    child: Container(
                                                      decoration: BoxDecoration (
                                                        borderRadius: BorderRadius.circular(7*fem),
                                                        border: Border.all(color: Color(0xff000000)),
                                                        color: Color(0x00d9d9d9),
                                                      ),
                                                      child: DropdownButton<String?>(
                                                        value: 'Item1',
                                                        onChanged: (String? newValue) {},
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
                                                // downarrow91o (I5:226;5:100)
                                                left: 137.0004882812*fem,
                                                top: 7*fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 9*fem,
                                                    height: 8*fem,
                                                    child: Image.asset(
                                                      'assets/images/book_upload/down-arrow-QYM.png',
                                                      width: 9*fem,
                                                      height: 8*fem,
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
                          ),
                          Positioned(
                            // bookinputfieldreadinglevelRzu (5:121)
                            left: 191*fem,
                            top: -45*fem,
                            child: Container(
                              width: 157*fem,
                              height: 48*fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // readinglevel7sj (5:91)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 3*fem),
                                    child: RichText(
                                      text: TextSpan(
                                        style: SafeGoogleFont (
                                          'Lexend Deca',
                                          fontSize: 17*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Reading Level',
                                          ),
                                          TextSpan(
                                            text: '*',
                                            style: SafeGoogleFont (
                                              'Lexend Deca',
                                              fontSize: 17*ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.25*ffem/fem,
                                              color: Color(0xffef706c),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // inputfieldJqj (5:120)
                                    width: double.infinity,
                                    height: 23*fem,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          // inputfield2mj (I5:120;5:97)
                                          left: 0*fem,
                                          top: 0*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 140.52*fem,
                                              height: 23*fem,
                                              child: Image.asset(
                                                'assets/images/book_upload/inputfield-C13.png',
                                                width: 140.52*fem,
                                                height: 23*fem,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // selectareadinglevel8Jy (I5:120;5:98)
                                          left: 6*fem,
                                          top: 6*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 84*fem,
                                              height: 10*fem,
                                              child: Text(
                                                'Select a Reading Level',
                                                style: SafeGoogleFont (
                                                  'Lexend Deca',
                                                  fontSize: 7.5*ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.25*ffem/fem,
                                                  color: Color(0xff8f9295),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // inputfieldbyF (I5:120;5:99)
                                          left: 0*fem,
                                          top: 0*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 157*fem,
                                              height: 23*fem,
                                              child: Container(
                                                decoration: BoxDecoration (
                                                  borderRadius: BorderRadius.circular(7*fem),
                                                  border: Border.all(color: Color(0xff000000)),
                                                  color: Color(0x00d9d9d9),
                                                ),
                                                child: DropdownButton<String?>(
                                                  value: 'Item1',
                                                  onChanged: (String? newValue) {},
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
                                          // downarrowEWR (I5:120;5:100)
                                          left: 137.0004882812*fem,
                                          top: 7*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 9*fem,
                                              height: 8*fem,
                                              child: Image.asset(
                                                'assets/images/book_upload/down-arrow-tcm.png',
                                                width: 9*fem,
                                                height: 8*fem,
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
                            // bookinputfieldprice7q7 (5:152)
                            left: 24*fem,
                            top: -44*fem,
                            child: Container(
                              width: 157*fem,
                              height: 48*fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // priceDdF (5:103)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 3*fem),
                                    child: RichText(
                                      text: TextSpan(
                                        style: SafeGoogleFont (
                                          'Lexend Deca',
                                          fontSize: 17*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Price',
                                          ),
                                          TextSpan(
                                            text: '*',
                                            style: SafeGoogleFont (
                                              'Lexend Deca',
                                              fontSize: 17*ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.25*ffem/fem,
                                              color: Color(0xffef706c),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // inputfieldMcy (5:151)
                                    width: double.infinity,
                                    height: 23*fem,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          // inputfield64m (I5:151;5:105)
                                          left: 0*fem,
                                          top: 0*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 140.52*fem,
                                              height: 23*fem,
                                              child: Image.asset(
                                                'assets/images/book_upload/inputfield-Mf3.png',
                                                width: 140.52*fem,
                                                height: 23*fem,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // inputpricezA9 (I5:151;5:106)
                                          left: 6*fem,
                                          top: 6*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 42*fem,
                                              height: 10*fem,
                                              child: Text(
                                                'Input Price',
                                                style: SafeGoogleFont (
                                                  'Lexend Deca',
                                                  fontSize: 7.5*ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.25*ffem/fem,
                                                  color: Color(0xff8f9295),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // inputfieldGdT (I5:151;5:107)
                                          left: 0*fem,
                                          top: 0*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 157*fem,
                                              height: 23*fem,
                                              child: Container(
                                                decoration: BoxDecoration (
                                                  borderRadius: BorderRadius.circular(7*fem),
                                                  border: Border.all(color: Color(0xff000000)),
                                                  color: Color(0x00d9d9d9),
                                                ),
                                                child: TextField(
                                                  maxLines: null,
                                                  decoration: InputDecoration (
                                                    border: InputBorder.none,
                                                    focusedBorder: InputBorder.none,
                                                    enabledBorder: InputBorder.none,
                                                    errorBorder: InputBorder.none,
                                                    disabledBorder: InputBorder.none,
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
                            // bookinputfieldtitle7e5 (5:128)
                            left: 167*fem,
                            top: -261*fem,
                            child: Container(
                              width: 181*fem,
                              height: 48*fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // titlepHb (5:66)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 3*fem),
                                    child: RichText(
                                      text: TextSpan(
                                        style: SafeGoogleFont (
                                          'Lexend Deca',
                                          fontSize: 17*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Title',
                                            style: SafeGoogleFont (
                                              'Lexend Deca',
                                              fontSize: 17*ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.25*ffem/fem,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                          TextSpan(
                                            text: '*',
                                            style: SafeGoogleFont (
                                              'Lexend Deca',
                                              fontSize: 17*ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.25*ffem/fem,
                                              color: Color(0xffef706c),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // inputfield68d (5:127)
                                    width: double.infinity,
                                    height: 23*fem,
                                    decoration: BoxDecoration (
                                      image: DecorationImage (
                                        fit: BoxFit.cover,
                                        image: AssetImage (
                                          'assets/images/book_upload/inputfield-MXT.png',
                                        ),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          // nameofyourbookP7j (I5:127;5:69)
                                          left: 6*fem,
                                          top: 6*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 72*fem,
                                              height: 10*fem,
                                              child: Text(
                                                'Name of your book',
                                                style: SafeGoogleFont (
                                                  'Lexend Deca',
                                                  fontSize: 7.5*ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.25*ffem/fem,
                                                  color: Color(0xff8f9295),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // inputfieldr1K (I5:127;5:67)
                                          left: 0*fem,
                                          top: 0*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 181*fem,
                                              height: 23*fem,
                                              child: Container(
                                                decoration: BoxDecoration (
                                                  borderRadius: BorderRadius.circular(7*fem),
                                                  border: Border.all(color: Color(0xff000000)),
                                                  color: Color(0x00d9d9d9),
                                                ),
                                                child: TextField(
                                                  maxLines: null,
                                                  decoration: InputDecoration (
                                                    border: InputBorder.none,
                                                    focusedBorder: InputBorder.none,
                                                    enabledBorder: InputBorder.none,
                                                    errorBorder: InputBorder.none,
                                                    disabledBorder: InputBorder.none,
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
                  ],
                ),
              ),
            ),
            Positioned(
              // ellipse1K9o (5:327)
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
              // profilenotificationdot1np5 (5:328)
              left: 318*fem,
              top: 13*fem,
              child: Align(
                child: SizedBox(
                  width: 27*fem,
                  height: 27*fem,
                  child: Image.asset(
                    'assets/images/book_upload/profilenotificationdot-1-EVK.png',
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