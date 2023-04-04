import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Query collectionRefAchievment;
  late QuerySnapshot querySnapshotAchievment;
  var achievmentLists = [];

  late Query collectionRefUser;
  late QuerySnapshot querySnapshotUser;
  var userLists = [];
  var earnAchievedLists = [];
  var inProgressAchievedLists = [];

//Aggregation Variable use for day streak
  double level_amount_day_streak = 0.0;
  String display_level_amount_day_streak = '';
  String first_char_level_amount_day_streak = '0';
  String second_char_level_amount_day_streak = '0';
  String third_char_level_amount_day_streak = '';

//Aggregation Variable use for books read
  double level_amount_books_read = 0.0;
  String display_level_amount_books_read = '';
  String first_char_level_amount_books_read = '0';
  String second_char_level_amount_books_read = '0';
  String third_char_level_amount_books_read = '';

//Aggregation Variable use for problem solved
  double level_amount_problem_solved = 0.0;
  String display_level_amount_problem_solved = '';
  String first_char_level_amount_problem_solved = '0';
  String second_char_level_amount_problem_solved = '0';
  String third_char_level_amount_problem_solved = '';

//Aggregation for books read, problem solved, day steak

  double books_read = 0;
  double problem_solved = 0;
  double day_steak = 0;

  var display_books_read = '0';
  var display_problem_solved = '0';
  var display_day_steak = '0';

  var books_read_bgcolor = '';
  var problems_solved_bgcolor = '';
  var day_streak_bgcolor = '';
  var books_read_name = '';
  var problems_solved_name = '';
  var day_streak_name = '';

  late Query collectionRefFavBooks;
  late QuerySnapshot querySnapshotFavBooks;
  var favBooksLists = [];

//Animation for kids progress

  double books_read_plan_height = 430.0;
  double current_books_read_plan_height = 430.0;
  bool isShowBookRead = false;

  double problem_solved_plan_height = 440.0;
  double current_problem_solved_plan_height = 440.0;
  bool isShowProblemSolved = false;

  double day_streak_plan_height = 470.0;
  double current_day_streak_plan_height = 470.0;
  bool isShowDayStreak = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    getAchievmentLevelData();
    getFavouriteBooksData();
  }

  Future<List> getAchievmentLevelData() async {
    collectionRefAchievment = FirebaseFirestore.instance
        .collection('achievement_condition_static')
        .where('uid', isEqualTo: 'JmuMU1mkIIFkFuPjU3vP');

    // Get docs from collection reference
    querySnapshotAchievment = await collectionRefAchievment.get();

    // Get data from docs and convert map to List
    achievmentLists =
        querySnapshotAchievment.docs.map((doc) => doc.data()).toList();

    return achievmentLists;
  }

  Future<void> getEarnAchievmentLevelData(
      List<String> docID, bool isEarnAchievement) async {
    Query query = FirebaseFirestore.instance
        .collection('achievement_condition_static')
        .where(FieldPath.documentId, whereIn: docID);

    // Get docs from collection reference
    querySnapshotAchievment = await query.get();

    // Get data from docs and convert map to List
    if (isEarnAchievement) {
      earnAchievedLists =
          querySnapshotAchievment.docs.map((doc) => doc.data()).toList();
      ;
    } else {
      inProgressAchievedLists =
          querySnapshotAchievment.docs.map((doc) => doc.data()).toList();
      if (inProgressAchievedLists.isNotEmpty) {
        for (int i = 0; i < inProgressAchievedLists.length; i++) {
          if (inProgressAchievedLists[i]['name'] == 'day streak') {
            level_amount_day_streak = 0.0;
            display_level_amount_day_streak = '';
            first_char_level_amount_day_streak = '0';
            second_char_level_amount_day_streak = '0';
            third_char_level_amount_day_streak = '';
            var arrayAggregation = inProgressAchievedLists[i]['aggregation'];
            if (arrayAggregation.length > 0) {
              day_steak += arrayAggregation[0]['books_read'];
              display_day_steak = (day_steak.toInt()).toString();
            }
//Calculation for animation for day streak progress
            Future.delayed(const Duration(milliseconds: 1000), () {
              double avg_day_streak = 0.0;
              avg_day_streak = (day_streak_plan_height * day_steak) / 100;
              current_day_streak_plan_height =
                  day_streak_plan_height - avg_day_streak;
              print('##### TOTAL HEIGHT day_streak $day_streak_plan_height');
              print(
                  '##### CURRENT HEIGHT day_streak $current_day_streak_plan_height');

              setState(() {
                current_day_streak_plan_height;
              });
              Future.delayed(const Duration(milliseconds: 1000), () {
                isShowDayStreak = true;
                setState(() {
                  isShowDayStreak;
                });
              });
            });

            for (int j = 0; j < inProgressAchievedLists.length; j++) {
              if (inProgressAchievedLists[j]['name'] == 'day streak') {
                level_amount_day_streak +=
                    inProgressAchievedLists[j]['level_amount'];
                day_streak_bgcolor = inProgressAchievedLists[j]['color'];
                day_streak_name = inProgressAchievedLists[j]['name'];
              }
            }
            level_amount_day_streak = level_amount_day_streak / 2;
            display_level_amount_day_streak =
                (level_amount_day_streak.toInt()).toString();
            if (display_level_amount_day_streak.length == 3) {
              for (int i = display_level_amount_day_streak.length - 1;
                  i >= 0;
                  i--) {
                if (i == 2) {
                  third_char_level_amount_day_streak =
                      display_level_amount_day_streak[i];
                } else if (i == 1) {
                  second_char_level_amount_day_streak =
                      display_level_amount_day_streak[i];
                } else {
                  first_char_level_amount_day_streak =
                      display_level_amount_day_streak[i];
                }
              }
            } else if (display_level_amount_day_streak.length == 2) {
              for (int i = display_level_amount_day_streak.length - 1;
                  i >= 0;
                  i--) {
                if (i == 1) {
                  second_char_level_amount_day_streak =
                      display_level_amount_day_streak[i];
                } else {
                  first_char_level_amount_day_streak =
                      display_level_amount_day_streak[i];
                }
              }
            }
          } else if (inProgressAchievedLists[i]['name'] == 'problems solved') {
            level_amount_problem_solved = 0.0;
            display_level_amount_problem_solved = '';
            first_char_level_amount_problem_solved = '0';
            second_char_level_amount_problem_solved = '0';
            third_char_level_amount_problem_solved = '';
            var arrayAggregation = inProgressAchievedLists[i]['aggregation'];
            if (arrayAggregation.length > 0) {
              problem_solved += arrayAggregation[0]['books_read'];
              display_problem_solved = (problem_solved.toInt()).toString();
            }
//Calculation for animation for problem solved progress
            Future.delayed(const Duration(milliseconds: 1000), () {
              double avg_problem_solved = 0.0;
              avg_problem_solved =
                  (problem_solved_plan_height * problem_solved) / 100;
              current_problem_solved_plan_height =
                  problem_solved_plan_height - avg_problem_solved;
              print(
                  '##### TOTAL HEIGHT problem_solved $problem_solved_plan_height');
              print(
                  '##### CURRENT HEIGHT problem_solved $current_problem_solved_plan_height');

              setState(() {
                current_problem_solved_plan_height;
              });
              Future.delayed(const Duration(milliseconds: 1000), () {
                isShowProblemSolved = true;
                setState(() {
                  isShowProblemSolved;
                });
              });
            });

            for (int j = 0; j < inProgressAchievedLists.length; j++) {
              if (inProgressAchievedLists[j]['name'] == 'problems solved') {
                level_amount_problem_solved +=
                    inProgressAchievedLists[j]['level_amount'];
                problems_solved_bgcolor = inProgressAchievedLists[j]['color'];
                problems_solved_name = inProgressAchievedLists[j]['name'];
              }
            }
            level_amount_problem_solved = level_amount_problem_solved / 2;
            display_level_amount_problem_solved =
                (level_amount_problem_solved.toInt()).toString();
            if (display_level_amount_problem_solved.length == 3) {
              for (int i = display_level_amount_problem_solved.length - 1;
                  i >= 0;
                  i--) {
                if (i == 2) {
                  third_char_level_amount_problem_solved =
                      display_level_amount_problem_solved[i];
                } else if (i == 1) {
                  second_char_level_amount_problem_solved =
                      display_level_amount_problem_solved[i];
                } else {
                  first_char_level_amount_problem_solved =
                      display_level_amount_problem_solved[i];
                }
              }
            } else if (display_level_amount_problem_solved.length == 2) {
              for (int i = display_level_amount_problem_solved.length - 1;
                  i >= 0;
                  i--) {
                if (i == 1) {
                  second_char_level_amount_problem_solved =
                      display_level_amount_problem_solved[i];
                } else {
                  first_char_level_amount_problem_solved =
                      display_level_amount_problem_solved[i];
                }
              }
            }
          } else if (inProgressAchievedLists[i]['name'] == 'books read') {
            level_amount_books_read = 0.0;
            display_level_amount_books_read = '';
            first_char_level_amount_books_read = '0';
            second_char_level_amount_books_read = '0';
            third_char_level_amount_books_read = '';
            var arrayAggregation = inProgressAchievedLists[i]['aggregation'];
            if (arrayAggregation.length > 0) {
              books_read += arrayAggregation[0]['books_read'];
              display_books_read = (books_read.toInt()).toString();
            }
//Calculation for animation for books read progress
            Future.delayed(const Duration(milliseconds: 1000), () {
              double avg_books_read = 0.0;
              avg_books_read = (books_read_plan_height * books_read) / 100;
              current_books_read_plan_height =
                  books_read_plan_height - avg_books_read;
              print('##### TOTAL HEIGHT $books_read_plan_height');
              print('##### CURRENT HEIGHT $current_books_read_plan_height');

              setState(() {
                current_books_read_plan_height;
              });
              Future.delayed(const Duration(milliseconds: 1000), () {
                isShowBookRead = true;
                setState(() {
                  isShowBookRead;
                });
              });
            });

            for (int j = 0; j < inProgressAchievedLists.length; j++) {
              if (inProgressAchievedLists[j]['name'] == 'books read') {
                level_amount_books_read +=
                    inProgressAchievedLists[j]['level_amount'];
                books_read_bgcolor = inProgressAchievedLists[j]['color'];
                books_read_name = inProgressAchievedLists[j]['name'];
              }
            }
            level_amount_books_read = level_amount_books_read / 2;
            display_level_amount_books_read =
                (level_amount_books_read.toInt()).toString();
            if (display_level_amount_books_read.length == 3) {
              for (int i = display_level_amount_books_read.length - 1;
                  i >= 0;
                  i--) {
                if (i == 2) {
                  third_char_level_amount_books_read =
                      display_level_amount_books_read[i];
                } else if (i == 1) {
                  second_char_level_amount_books_read =
                      display_level_amount_books_read[i];
                } else {
                  first_char_level_amount_books_read =
                      display_level_amount_books_read[i];
                }
              }
            } else if (display_level_amount_books_read.length == 2) {
              for (int i = display_level_amount_books_read.length - 1;
                  i >= 0;
                  i--) {
                if (i == 1) {
                  second_char_level_amount_books_read =
                      display_level_amount_books_read[i];
                } else {
                  first_char_level_amount_books_read =
                      display_level_amount_books_read[i];
                }
              }
            }
          }
        }
      }
    }

    setState(() {
      earnAchievedLists;
      inProgressAchievedLists;
      first_char_level_amount_day_streak;
      second_char_level_amount_day_streak;
      third_char_level_amount_day_streak;
      first_char_level_amount_books_read;
      second_char_level_amount_books_read;
      third_char_level_amount_books_read;
      first_char_level_amount_problem_solved;
      second_char_level_amount_problem_solved;
      third_char_level_amount_problem_solved;
      display_books_read;
      display_problem_solved;
      display_day_steak;
      books_read_bgcolor;
      problems_solved_bgcolor;
      day_streak_bgcolor;
      books_read_name;
      day_streak_name;
      problems_solved_name;
    });
  }

  Future<void> getUserData() async {
    collectionRefUser = FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: ' JmuMU1mkIIFkFuPjU3vP');

    // Get docs from collection reference
    querySnapshotUser = await collectionRefUser.get();

    // Get data from docs and convert map to List
    userLists = querySnapshotUser.docs.map((doc) => doc.data()).toList();

    setState(() {
      userLists;
    });

// Logic for earned achievement document
    List<String> docIDS = [];

    for (int i = 0; i < userLists.length; i++) {
      for (int j = 0; j < userLists[i]['earned_achievements'].length; j++) {
        String id = (userLists[i]['earned_achievements'][j]);
        docIDS.add(id.replaceAll(' ', ''));
      }
    }

    getEarnAchievmentLevelData(docIDS, true);

//Logic for in progress achievement documents
    List<String> docInProgressIDS = [];
    for (int i = 0; i < userLists.length; i++) {
      for (int j = 0;
          j < userLists[i]['in_progress_achievements'].length;
          j++) {
        String id = (userLists[i]['in_progress_achievements'][j]);
        docInProgressIDS.add(id.replaceAll(' ', ''));
      }
    }
    getEarnAchievmentLevelData(docInProgressIDS, false);
  }

  Future<void> getFavouriteBooksData() async {
    collectionRefFavBooks = FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: ' JmuMU1mkIIFkFuPjU3vP');

    // Get docs from collection reference
    querySnapshotFavBooks = await collectionRefFavBooks.get();

    // Get data from docs and convert map to List
    favBooksLists =
        querySnapshotFavBooks.docs.map((doc) => doc.data()).toList();

    List<String> favBookId = [];
    for (int i = 0; i < favBooksLists.length; i++) {
      for (int j = 0; j < favBooksLists[i]['books_read'].length; j++) {
        if (favBooksLists[i]['books_read'][j]['reading_duration'] > 30) {
          favBookId.add(
              favBooksLists[i]['books_read'][j]['book_id'].replaceAll(' ', ''));
        }
      }
    }

    getFavouriteBookData(favBookId);
  }

  Future<void> getFavouriteBookData(List<String> docID) async {
    favBooksLists = [];
    Query query = FirebaseFirestore.instance
        .collection('booksentity')
        .where(FieldPath.documentId, whereIn: docID);

    // Get docs from collection reference
    querySnapshotFavBooks = await query.get();
    // Get data from docs and convert map to List
    favBooksLists =
        querySnapshotFavBooks.docs.map((doc) => doc.data()).toList();

    setState(() {
      favBooksLists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(240, 243, 246, 1.0),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();

            return true;
          },
          child: SingleChildScrollView(
            child: Stack(children: [
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/images/home/background_kids.png',
                    fit: BoxFit.cover,
                  )),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 60.0, right: 60.0, top: 70.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset(
                                      'assets/images/home/background_kids_triangle.png')),
                              Container(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset(
                                      'assets/images/home/background_kids_dots1.png')),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 115.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 50,
                                  width: 50,
                                  child: Image.asset(
                                      'assets/images/home/background_kids_squiggle2.png')),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                    height: 30,
                                    width: 30,
                                    child: Image.asset(
                                        'assets/images/home/background_kids_squiggle1.png')),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 170,
                          left: 30,
                          right: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      height: 30,
                                      width: 30,
                                      child: Image.asset(
                                          'assets/images/home/background_kids_cross2.png')),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: Container(
                                        height: 15,
                                        width: 15,
                                        child: Image.asset(
                                            'assets/images/home/background_kids_circle2.png')),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 50.0),
                                child: Container(
                                    height: 30,
                                    width: 30,
                                    child: Image.asset(
                                        'assets/images/home/background_kids_circle1.png')),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 70,
                          left: MediaQuery.of(context).size.width / 2 - 80,
                          child: Container(
                              height: 160,
                              width: 170,
                              child: Image.asset(
                                  'assets/images/home/background_kids_circle.png')),
                        ),
                        Positioned(
                          top: 70,
                          left: MediaQuery.of(context).size.width / 2 - 75,
                          child: Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(121, 205, 31, 1.0),
                                borderRadius: BorderRadius.circular(65),
                                border:
                                    Border.all(width: 5, color: Colors.black)),
                            child: userLists.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: CachedNetworkImage(
                                        imageUrl: userLists[0]['profile_url'],
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator()),
                                  )
                                : SizedBox(),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20.0),
                    child: Stack(children: [
                      Container(
                        // height: 30,
                        // width: 30,
                        child: Image.asset(
                            'assets/images/home/readinglevel_textbox.png'),
                      ),
                      Positioned(
                        // left: MediaQuery.of(context).size.width / 2 - 100,
                        top: 2,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                      userLists.isNotEmpty
                                          ? userLists[0]['reading_level'] == 1
                                              ? "Starter"
                                              : userLists[0]['reading_level'] ==
                                                      2
                                                  ? "Beginner"
                                                  : userLists[0][
                                                              'reading_level'] ==
                                                          3
                                                      ? "Intermediate"
                                                      : "Advanced"
                                          : '',
                                      style: TextStyle(
                                        color:
                                            Color.fromRGBO(71, 169, 229, 1.0),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 28.0,
                                      )),
                                  Text("Level Reader!",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    child: userLists.isNotEmpty
                        ? userLists[0]['reading_level'] == 1
                            ? Image.asset(
                                'assets/images/home/home_readinglevel_1_icon.png')
                            : userLists[0]['reading_level'] == 2
                                ? Image.asset(
                                    'assets/images/home/home_readinglevel_2_icon.png')
                                : userLists[0]['reading_level'] == 3
                                    ? Image.asset(
                                        'assets/images/home/home_readinglevel_3_icon.png')
                                    : Image.asset(
                                        'assets/images/home/home_readinglevel_4_icon.png')
                        : SizedBox(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 350,
                      child: Stack(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Positioned(
                            left: 10,
                            child: isShowBookRead
                                ? Container(
                                    height: 330,
                                    child: Stack(children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Stack(
                                                children:[
                                                  isShowBookRead? Container(
                                                      height: 40,
                                                      width: 30,
                                                      child: Image.asset(
                                                          'assets/images/home/numbers_purple_stars_L.png')):SizedBox(),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:20.0,left: 20.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: first_char_level_amount_books_read ==
                                                              '1'
                                                          ? Image.asset(
                                                              'assets/images/home/numbers/blue/1_blue.png')
                                                          : first_char_level_amount_books_read ==
                                                                  '2'
                                                              ? Image.asset(
                                                                  'assets/images/home/numbers/blue/2_blue.png')
                                                              : first_char_level_amount_books_read ==
                                                                      '3'
                                                                  ? Image.asset(
                                                                      'assets/images/home/numbers/blue/3_blue.png')
                                                                  : first_char_level_amount_books_read ==
                                                                          '4'
                                                                      ? Image.asset(
                                                                          'assets/images/home/numbers/blue/4_blue.png')
                                                                      : first_char_level_amount_books_read ==
                                                                              '5'
                                                                          ? Image.asset(
                                                                              'assets/images/home/numbers/blue/5_blue.png')
                                                                          : first_char_level_amount_books_read ==
                                                                                  '6'
                                                                              ? Image.asset(
                                                                                  'assets/images/home/numbers/blue/6_blue.png')
                                                                              : first_char_level_amount_books_read == '7'
                                                                                  ? Image.asset('assets/images/home/numbers/blue/7_blue.png')
                                                                                  : first_char_level_amount_books_read == '8'
                                                                                      ? Image.asset('assets/images/home/numbers/blue/8_blue.png')
                                                                                      : first_char_level_amount_books_read == '9'
                                                                                          ? Image.asset('assets/images/home/numbers/blue/9_blue.png')
                                                                                          : first_char_level_amount_books_read == '0'
                                                                                              ? Image.asset('assets/images/home/numbers/blue/0_blue.png')
                                                                                              : SizedBox()),
                                                  ),
                                              ]),
                                              Stack(
                                                children:[
                                                  isShowBookRead && third_char_level_amount_books_read == ''? Padding(
                                                    padding: const EdgeInsets.only(left:20.0),
                                                    child: Container(
                                                        height: 40,
                                                        width: 30,
                                                        child: Image.asset(
                                                            'assets/images/home/numbers_purple_stars_R.png')),
                                                  ):SizedBox(),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:20.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: second_char_level_amount_books_read ==
                                                              '1'
                                                          ? Image.asset(
                                                              'assets/images/home/numbers/blue/1_blue.png')
                                                          : second_char_level_amount_books_read ==
                                                                  '2'
                                                              ? Image.asset(
                                                                  'assets/images/home/numbers/blue/2_blue.png')
                                                              : second_char_level_amount_books_read ==
                                                                      '3'
                                                                  ? Image.asset(
                                                                      'assets/images/home/numbers/blue/3_blue.png')
                                                                  : second_char_level_amount_books_read ==
                                                                          '4'
                                                                      ? Image.asset(
                                                                          'assets/images/home/numbers/blue/4_blue.png')
                                                                      : second_char_level_amount_books_read ==
                                                                              '5'
                                                                          ? Image.asset(
                                                                              'assets/images/home/numbers/blue/5_blue.png')
                                                                          : second_char_level_amount_books_read ==
                                                                                  '6'
                                                                              ? Image.asset(
                                                                                  'assets/images/home/numbers/blue/6_blue.png')
                                                                              : second_char_level_amount_books_read == '7'
                                                                                  ? Image.asset('assets/images/home/numbers/blue/7_blue.png')
                                                                                  : second_char_level_amount_books_read == '8'
                                                                                      ? Image.asset('assets/images/home/numbers/blue/8_blue.png')
                                                                                      : second_char_level_amount_books_read == '9'
                                                                                          ? Image.asset('assets/images/home/numbers/blue/9_blue.png')
                                                                                          : second_char_level_amount_books_read == '0'
                                                                                              ? Image.asset('assets/images/home/numbers/blue/0_blue.png')
                                                                                              : SizedBox()),
                                                  ),
                                             ] ),
                                              Stack(
                                                children:[
                                                  isShowBookRead && third_char_level_amount_books_read != ''? Padding(
                                                    padding: const EdgeInsets.only(left:20.0),
                                                    child: Container(
                                                        height: 40,
                                                        width: 30,
                                                        child: Image.asset(
                                                            'assets/images/home/numbers_purple_stars_R.png')),
                                                  ):SizedBox(),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:20.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: third_char_level_amount_books_read ==
                                                              '1'
                                                          ? Image.asset(
                                                              'assets/images/home/numbers/blue/1_blue.png')
                                                          : third_char_level_amount_books_read ==
                                                                  '2'
                                                              ? Image.asset(
                                                                  'assets/images/home/numbers/blue/2_blue.png')
                                                              : third_char_level_amount_books_read ==
                                                                      '3'
                                                                  ? Image.asset(
                                                                      'assets/images/home/numbers/blue/3_blue.png')
                                                                  : third_char_level_amount_books_read ==
                                                                          '4'
                                                                      ? Image.asset(
                                                                          'assets/images/home/numbers/blue/4_blue.png')
                                                                      : third_char_level_amount_books_read ==
                                                                              '5'
                                                                          ? Image.asset(
                                                                              'assets/images/home/numbers/blue/5_blue.png')
                                                                          : third_char_level_amount_books_read ==
                                                                                  '6'
                                                                              ? Image.asset(
                                                                                  'assets/images/home/numbers/blue/6_blue.png')
                                                                              : third_char_level_amount_books_read == '7'
                                                                                  ? Image.asset('assets/images/home/numbers/blue/7_blue.png')
                                                                                  : third_char_level_amount_books_read == '8'
                                                                                      ? Image.asset('assets/images/home/numbers/blue/8_blue.png')
                                                                                      : third_char_level_amount_books_read == '9'
                                                                                          ? Image.asset('assets/images/home/numbers/blue/9_blue.png')
                                                                                          : third_char_level_amount_books_read == '0'
                                                                                              ? Image.asset('assets/images/home/numbers/blue/0_blue.png')
                                                                                              : SizedBox()),
                                                  ),
                                              ]),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0, right: 0.0),
                                            child: Stack(children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: RotatedBox(
                                                  quarterTurns: -1,
                                                  child: LinearPercentIndicator(
                                                    width: 240.0,
                                                    lineHeight: 24.0,
                                                    barRadius:
                                                        Radius.circular(10.0),
                                                    percent: books_read / 100,
                                                    // backgroundColor: Color.fromRGBO(71, 169, 229, 0.1),
                                                    // progressColor: Color.fromRGBO(71, 169, 229, 1.0),
                                                    backgroundColor:
                                                        books_read_bgcolor != ''
                                                            ? HexColor(
                                                                    books_read_bgcolor)
                                                                .withOpacity(
                                                                    0.1)
                                                            : Colors
                                                                .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(0.1) : Colors.white,//HexColor("b74093"),
                                                    progressColor: books_read_bgcolor !=
                                                            ''
                                                        ? HexColor(
                                                                books_read_bgcolor)
                                                            .withOpacity(1.0)
                                                        : Colors
                                                            .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(1.0) : Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0, left: 10.0),
                                                child: RotatedBox(
                                                  quarterTurns: -1,
                                                  child: Container(
                                                      width: 220.0,
                                                      height: 26,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 3,
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      )),
                                                ),
                                              ),
                                              // Padding(
                                              //   padding: const EdgeInsets.only(left:3.0),
                                              //   child: Container(
                                              //     height: 80,
                                              //     width: 40,
                                              //     child: Image.asset(
                                              //         'assets/images/home/Kids_progressbar_blueicon.png'),
                                              //   ),
                                              // ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 3.0),
                                                child: AnimatedContainer(
                                                  duration:
                                                      Duration(seconds: 3),
                                                  height:
                                                      current_books_read_plan_height, //430
                                                  width: 40,
                                                  child: Image.asset(
                                                      'assets/images/home/Kids_progressbar_blueicon.png'),
                                                ),
                                              ),
                                            ]),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(
                                          //       top: 5.0, bottom: 10.0, right: 20),
                                          //   child: Column(
                                          //     children: [
                                          //       Text(display_books_read,
                                          //           style: TextStyle(
                                          //             color: books_read_bgcolor != ''
                                          //                 ? HexColor(books_read_bgcolor)
                                          //                     .withOpacity(1.0)
                                          //                 : Colors
                                          //                     .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(1.0) : Colors.white,//Color.fromRGBO(71, 169, 229, 1.0),
                                          //             fontWeight: FontWeight.w600,
                                          //             fontSize: 28.0,
                                          //           )),
                                          //       Text("${books_read_name}!".toUpperCase(),
                                          //           style: TextStyle(
                                          //             color: Colors.black,
                                          //             fontWeight: FontWeight.w700,
                                          //             fontSize: 12.0,
                                          //           ))
                                          //     ],
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      isShowBookRead
                                          ? SizedBox(height: 10)
                                          : SizedBox(),
                                      isShowBookRead
                                          ? Positioned(
                                              left: 35,
                                              bottom: 0,

                                              child: Column(
                                                children: [
                                                  Text(display_books_read,
                                                      style: TextStyle(
                                                        color: books_read_bgcolor !=
                                                                ''
                                                            ? HexColor(
                                                                    books_read_bgcolor)
                                                                .withOpacity(
                                                                    1.0)
                                                            : Colors
                                                                .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(1.0) : Colors.white,//Color.fromRGBO(71, 169, 229, 1.0),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 28.0,
                                                      )),
                                                  Text(
                                                      "${books_read_name}!"
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 9.0,
                                                      ))
                                                ],
                                              ),
                                            )
                                          : SizedBox()
                                    ]),
                                  )
                                : Stack(children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Stack(
                                          children:[
                                            isShowBookRead? Container(
                                                height: 40,
                                                width: 30,
                                                child: Image.asset(
                                                    'assets/images/home/numbers_purple_stars_L.png')):SizedBox(),
                                            Padding(
                                              padding: const EdgeInsets.only(top:20.0,left: 20.0),
                                              child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  child: first_char_level_amount_books_read ==
                                                      '1'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/blue/1_blue.png')
                                                      : first_char_level_amount_books_read ==
                                                      '2'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/blue/2_blue.png')
                                                      : first_char_level_amount_books_read ==
                                                      '3'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/blue/3_blue.png')
                                                      : first_char_level_amount_books_read ==
                                                      '4'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/blue/4_blue.png')
                                                      : first_char_level_amount_books_read ==
                                                      '5'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/blue/5_blue.png')
                                                      : first_char_level_amount_books_read ==
                                                      '6'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/blue/6_blue.png')
                                                      : first_char_level_amount_books_read == '7'
                                                      ? Image.asset('assets/images/home/numbers/blue/7_blue.png')
                                                      : first_char_level_amount_books_read == '8'
                                                      ? Image.asset('assets/images/home/numbers/blue/8_blue.png')
                                                      : first_char_level_amount_books_read == '9'
                                                      ? Image.asset('assets/images/home/numbers/blue/9_blue.png')
                                                      : first_char_level_amount_books_read == '0'
                                                      ? Image.asset('assets/images/home/numbers/blue/0_blue.png')
                                                      : SizedBox()),
                                            ),
                                          ]),
                                      Stack(
                                          children:[
                                            isShowBookRead && third_char_level_amount_books_read == ''? Container(
                                                height: 40,
                                                width: 30,
                                                child: Image.asset(
                                                    'assets/images/home/numbers_purple_stars_R.png')):SizedBox(),
                                            Padding(
                                              padding: const EdgeInsets.only(top:20.0),
                                              child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  child: second_char_level_amount_books_read ==
                                                      '1'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/blue/1_blue.png')
                                                      : second_char_level_amount_books_read ==
                                                      '2'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/blue/2_blue.png')
                                                      : second_char_level_amount_books_read ==
                                                      '3'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/blue/3_blue.png')
                                                      : second_char_level_amount_books_read ==
                                                      '4'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/blue/4_blue.png')
                                                      : second_char_level_amount_books_read ==
                                                      '5'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/blue/5_blue.png')
                                                      : second_char_level_amount_books_read ==
                                                      '6'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/blue/6_blue.png')
                                                      : second_char_level_amount_books_read == '7'
                                                      ? Image.asset('assets/images/home/numbers/blue/7_blue.png')
                                                      : second_char_level_amount_books_read == '8'
                                                      ? Image.asset('assets/images/home/numbers/blue/8_blue.png')
                                                      : second_char_level_amount_books_read == '9'
                                                      ? Image.asset('assets/images/home/numbers/blue/9_blue.png')
                                                      : second_char_level_amount_books_read == '0'
                                                      ? Image.asset('assets/images/home/numbers/blue/0_blue.png')
                                                      : SizedBox()),
                                            ),
                                          ] ),
                                      Stack(
                                          children:[
                                            isShowBookRead && third_char_level_amount_books_read != ''? Padding(
                                              padding: const EdgeInsets.only(left:20.0),
                                              child: Container(
                                                  height: 40,
                                                  width: 30,
                                                  child: Image.asset(
                                                      'assets/images/home/numbers_purple_stars_R.png')),
                                            ):SizedBox(),
                                            Padding(
                                              padding: const EdgeInsets.only(top:20.0),
                                              child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  child: third_char_level_amount_books_read ==
                                                      '1'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/blue/1_blue.png')
                                                      : third_char_level_amount_books_read ==
                                                      '2'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/blue/2_blue.png')
                                                      : third_char_level_amount_books_read ==
                                                      '3'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/blue/3_blue.png')
                                                      : third_char_level_amount_books_read ==
                                                      '4'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/blue/4_blue.png')
                                                      : third_char_level_amount_books_read ==
                                                      '5'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/blue/5_blue.png')
                                                      : third_char_level_amount_books_read ==
                                                      '6'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/blue/6_blue.png')
                                                      : third_char_level_amount_books_read == '7'
                                                      ? Image.asset('assets/images/home/numbers/blue/7_blue.png')
                                                      : third_char_level_amount_books_read == '8'
                                                      ? Image.asset('assets/images/home/numbers/blue/8_blue.png')
                                                      : third_char_level_amount_books_read == '9'
                                                      ? Image.asset('assets/images/home/numbers/blue/9_blue.png')
                                                      : third_char_level_amount_books_read == '0'
                                                      ? Image.asset('assets/images/home/numbers/blue/0_blue.png')
                                                      : SizedBox()),
                                            ),
                                          ]),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0, right: 0.0),
                                    child: Stack(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0),
                                        child: RotatedBox(
                                          quarterTurns: -1,
                                          child: LinearPercentIndicator(
                                            width: 240.0,
                                            lineHeight: 24.0,
                                            barRadius:
                                            Radius.circular(10.0),
                                            percent: books_read / 100,
                                            // backgroundColor: Color.fromRGBO(71, 169, 229, 0.1),
                                            // progressColor: Color.fromRGBO(71, 169, 229, 1.0),
                                            backgroundColor:
                                            books_read_bgcolor != ''
                                                ? HexColor(
                                                books_read_bgcolor)
                                                .withOpacity(
                                                0.1)
                                                : Colors
                                                .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(0.1) : Colors.white,//HexColor("b74093"),
                                            progressColor: books_read_bgcolor !=
                                                ''
                                                ? HexColor(
                                                books_read_bgcolor)
                                                .withOpacity(1.0)
                                                : Colors
                                                .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(1.0) : Colors.white,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 10.0),
                                        child: RotatedBox(
                                          quarterTurns: -1,
                                          child: Container(
                                              width: 220.0,
                                              height: 26,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 3,
                                                    color:
                                                    Colors.black),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(10.0),
                                              )),
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(left:3.0),
                                      //   child: Container(
                                      //     height: 80,
                                      //     width: 40,
                                      //     child: Image.asset(
                                      //         'assets/images/home/Kids_progressbar_blueicon.png'),
                                      //   ),
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3.0),
                                        child: AnimatedContainer(
                                          duration:
                                          Duration(seconds: 3),
                                          height:
                                          current_books_read_plan_height, //430
                                          width: 40,
                                          child: Image.asset(
                                              'assets/images/home/Kids_progressbar_blueicon.png'),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       top: 5.0, bottom: 10.0, right: 20),
                                  //   child: Column(
                                  //     children: [
                                  //       Text(display_books_read,
                                  //           style: TextStyle(
                                  //             color: books_read_bgcolor != ''
                                  //                 ? HexColor(books_read_bgcolor)
                                  //                     .withOpacity(1.0)
                                  //                 : Colors
                                  //                     .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(1.0) : Colors.white,//Color.fromRGBO(71, 169, 229, 1.0),
                                  //             fontWeight: FontWeight.w600,
                                  //             fontSize: 28.0,
                                  //           )),
                                  //       Text("${books_read_name}!".toUpperCase(),
                                  //           style: TextStyle(
                                  //             color: Colors.black,
                                  //             fontWeight: FontWeight.w700,
                                  //             fontSize: 12.0,
                                  //           ))
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                              isShowBookRead
                                  ? SizedBox(height: 10)
                                  : SizedBox(),
                              isShowBookRead
                                  ? Positioned(
                                left: 35,
                                bottom: 0,

                                child: Column(
                                  children: [
                                    Text(display_books_read,
                                        style: TextStyle(
                                          color: books_read_bgcolor !=
                                              ''
                                              ? HexColor(
                                              books_read_bgcolor)
                                              .withOpacity(
                                              1.0)
                                              : Colors
                                              .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(1.0) : Colors.white,//Color.fromRGBO(71, 169, 229, 1.0),
                                          fontWeight:
                                          FontWeight.w600,
                                          fontSize: 28.0,
                                        )),
                                    Text(
                                        "${books_read_name}!"
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight:
                                          FontWeight.w700,
                                          fontSize: 9.0,
                                        ))
                                  ],
                                ),
                              )
                                  : SizedBox()
                            ]),
                          ),
                          Positioned(
                            left: (MediaQuery.of(context).size.width / 2) - 45,
                            child: isShowProblemSolved
                                ? Container(
                                    height: 330,
                                    child: Stack(children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Stack(
                                                children:[
                                                  isShowProblemSolved? Container(
                                                      height: 40,
                                                      width: 30,
                                                      child: Image.asset(
                                                          'assets/images/home/numbers_green_stars_L.png')):SizedBox(),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:20.0,left: 20.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: first_char_level_amount_problem_solved ==
                                                              '1'
                                                          ? Image.asset(
                                                              'assets/images/home/numbers/green/1_green.png')
                                                          : first_char_level_amount_problem_solved ==
                                                                  '2'
                                                              ? Image.asset(
                                                                  'assets/images/home/numbers/green/2_green.png')
                                                              : first_char_level_amount_problem_solved ==
                                                                      '3'
                                                                  ? Image.asset(
                                                                      'assets/images/home/numbers/green/3_green.png')
                                                                  : first_char_level_amount_problem_solved ==
                                                                          '4'
                                                                      ? Image.asset(
                                                                          'assets/images/home/numbers/green/4_green.png')
                                                                      : first_char_level_amount_problem_solved ==
                                                                              '5'
                                                                          ? Image.asset(
                                                                              'assets/images/home/numbers/green/5_green.png')
                                                                          : first_char_level_amount_problem_solved ==
                                                                                  '6'
                                                                              ? Image.asset(
                                                                                  'assets/images/home/numbers/green/6_green.png')
                                                                              : first_char_level_amount_problem_solved == '7'
                                                                                  ? Image.asset('assets/images/home/numbers/green/7_green.png')
                                                                                  : first_char_level_amount_problem_solved == '8'
                                                                                      ? Image.asset('assets/images/home/numbers/green/8_green.png')
                                                                                      : first_char_level_amount_problem_solved == '9'
                                                                                          ? Image.asset('assets/images/home/numbers/green/9_green.png')
                                                                                          : first_char_level_amount_problem_solved == '0'
                                                                                              ? Image.asset('assets/images/home/numbers/green/0_green.png')
                                                                                              : SizedBox()),
                                                  ),
                                              ]),
                                              Stack(
                                                children:[
                                                  isShowProblemSolved && third_char_level_amount_problem_solved == ''? Padding(
                                                    padding: const EdgeInsets.only(left:20.0),
                                                    child: Container(
                                                        height: 40,
                                                        width: 30,
                                                        child: Image.asset(
                                                            'assets/images/home/numbers_green_stars_R.png')),
                                                  ):SizedBox(),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:20.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: second_char_level_amount_problem_solved ==
                                                              '1'
                                                          ? Image.asset(
                                                              'assets/images/home/numbers/green/1_green.png')
                                                          : second_char_level_amount_problem_solved ==
                                                                  '2'
                                                              ? Image.asset(
                                                                  'assets/images/home/numbers/green/2_green.png')
                                                              : second_char_level_amount_problem_solved ==
                                                                      '3'
                                                                  ? Image.asset(
                                                                      'assets/images/home/numbers/green/3_green.png')
                                                                  : second_char_level_amount_problem_solved ==
                                                                          '4'
                                                                      ? Image.asset(
                                                                          'assets/images/home/numbers/green/4_green.png')
                                                                      : second_char_level_amount_problem_solved ==
                                                                              '5'
                                                                          ? Image.asset(
                                                                              'assets/images/home/numbers/green/5_green.png')
                                                                          : second_char_level_amount_problem_solved ==
                                                                                  '6'
                                                                              ? Image.asset(
                                                                                  'assets/images/home/numbers/green/6_green.png')
                                                                              : second_char_level_amount_problem_solved == '7'
                                                                                  ? Image.asset('assets/images/home/numbers/green/7_green.png')
                                                                                  : second_char_level_amount_problem_solved == '8'
                                                                                      ? Image.asset('assets/images/home/numbers/green/8_green.png')
                                                                                      : second_char_level_amount_problem_solved == '9'
                                                                                          ? Image.asset('assets/images/home/numbers/green/9_green.png')
                                                                                          : second_char_level_amount_problem_solved == '0'
                                                                                              ? Image.asset('assets/images/home/numbers/green/0_green.png')
                                                                                              : SizedBox()),
                                                  ),
                                             ] ),
                                              Stack(
                                                children:[
                                                  isShowProblemSolved && third_char_level_amount_problem_solved != ''? Padding(
                                                    padding: const EdgeInsets.only(left:20.0),
                                                    child: Container(
                                                        height: 40,
                                                        width: 30,
                                                        child: Image.asset(
                                                            'assets/images/home/numbers_green_stars_R.png')),
                                                  ):SizedBox(),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:20.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: third_char_level_amount_problem_solved ==
                                                              '1'
                                                          ? Image.asset(
                                                              'assets/images/home/numbers/green/1_green.png')
                                                          : third_char_level_amount_problem_solved ==
                                                                  '2'
                                                              ? Image.asset(
                                                                  'assets/images/home/numbers/green/2_green.png')
                                                              : third_char_level_amount_problem_solved ==
                                                                      '3'
                                                                  ? Image.asset(
                                                                      'assets/images/home/numbers/green/3_green.png')
                                                                  : third_char_level_amount_problem_solved ==
                                                                          '4'
                                                                      ? Image.asset(
                                                                          'assets/images/home/numbers/green/4_green.png')
                                                                      : third_char_level_amount_problem_solved ==
                                                                              '5'
                                                                          ? Image.asset(
                                                                              'assets/images/home/numbers/green/5_green.png')
                                                                          : third_char_level_amount_problem_solved ==
                                                                                  '6'
                                                                              ? Image.asset(
                                                                                  'assets/images/home/numbers/green/6_green.png')
                                                                              : third_char_level_amount_problem_solved == '7'
                                                                                  ? Image.asset('assets/images/home/numbers/green/7_green.png')
                                                                                  : third_char_level_amount_problem_solved == '8'
                                                                                      ? Image.asset('assets/images/home/numbers/green/8_green.png')
                                                                                      : third_char_level_amount_problem_solved == '9'
                                                                                          ? Image.asset('assets/images/home/numbers/green/9_green.png')
                                                                                          : third_char_level_amount_problem_solved == '0'
                                                                                              ? Image.asset('assets/images/home/numbers/green/0_green.png')
                                                                                              : SizedBox()),
                                                  ),
                                             ] ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0, right: 25),
                                            child: Stack(children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: RotatedBox(
                                                  quarterTurns: -1,
                                                  child: LinearPercentIndicator(
                                                    width: 240.0,
                                                    lineHeight: 24.0,
                                                    barRadius:
                                                        Radius.circular(10.0),
                                                    percent:
                                                        problem_solved / 100,
                                                    backgroundColor:
                                                        problems_solved_bgcolor !=
                                                                ''
                                                            ? HexColor(
                                                                    problems_solved_bgcolor)
                                                                .withOpacity(
                                                                    0.1)
                                                            : Colors
                                                                .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[1]['color']!).withOpacity(0.1) : Colors.white,//Color.fromRGBO(121, 205, 31, 0.1),
                                                    progressColor:
                                                        problems_solved_bgcolor !=
                                                                ''
                                                            ? HexColor(
                                                                    problems_solved_bgcolor)
                                                                .withOpacity(
                                                                    1.0)
                                                            : Colors
                                                                .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[1]['color']!).withOpacity(1.0) : Colors.white,//Color.fromRGBO(121, 205, 31, 1.0),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0, left: 10.0),
                                                child: RotatedBox(
                                                  quarterTurns: -1,
                                                  child: Container(
                                                      width: 220.0,
                                                      height: 26,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 3,
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      )),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 3.0),
                                                child: AnimatedContainer(
                                                  duration:
                                                      Duration(seconds: 3),
                                                  height:
                                                      current_problem_solved_plan_height, //430
                                                  width: 40,
                                                  child: Image.asset(
                                                      'assets/images/home/Kids_progressbar_greenicon.png'),
                                                ),
                                              ),
                                            ]),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(
                                          //       top: 5.0, bottom: 10.0, right: 20),
                                          //   child: Column(
                                          //     children: [
                                          //       Text(display_problem_solved,
                                          //           style: TextStyle(
                                          //             color: problems_solved_bgcolor != ''
                                          //                 ? HexColor(
                                          //                         problems_solved_bgcolor)
                                          //                     .withOpacity(1.0)
                                          //                 : Colors
                                          //                     .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[1]['color']!).withOpacity(1.0) : Colors.white,//Color.fromRGBO(121, 205, 31, 1.0),
                                          //             fontWeight: FontWeight.w600,
                                          //             fontSize: 28.0,
                                          //           )),
                                          //       Text(
                                          //           "${problems_solved_name}!"
                                          //               .toUpperCase(),
                                          //           style: TextStyle(
                                          //             color: Colors.black,
                                          //             fontWeight: FontWeight.w700,
                                          //             fontSize: 12.0,
                                          //           ))
                                          //     ],
                                          //   ),
                                          // )
                                        ],
                                      ),
                                      isShowProblemSolved
                                          ? SizedBox(height: 10)
                                          : SizedBox(),
                                      isShowProblemSolved
                                          ? Positioned(
                                               left: 18,
                                              //right:10,
                                              bottom: 0,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                    child: Text(
                                                        display_problem_solved,
                                                        style: TextStyle(
                                                          color: problems_solved_bgcolor !=
                                                                  ''
                                                              ? HexColor(
                                                                      problems_solved_bgcolor)
                                                                  .withOpacity(
                                                                      1.0)
                                                              : Colors
                                                                  .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[1]['color']!).withOpacity(1.0) : Colors.white,//Color.fromRGBO(121, 205, 31, 1.0),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 28.0,
                                                        )),
                                                  ),
                                                  Text(
                                                      "${problems_solved_name}!"
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 9.0,
                                                      ))
                                                ],
                                              ),
                                            )
                                          : SizedBox()
                                    ]),
                                  )
                                : Stack(children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Stack(
                                          children:[
                                            isShowProblemSolved? Container(
                                                height: 40,
                                                width: 30,
                                                child: Image.asset(
                                                    'assets/images/home/numbers_green_stars_L.png')):SizedBox(),
                                            Padding(
                                              padding: const EdgeInsets.only(top:20.0,left: 20.0),
                                              child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  child: first_char_level_amount_problem_solved ==
                                                      '1'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/green/1_green.png')
                                                      : first_char_level_amount_problem_solved ==
                                                      '2'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/green/2_green.png')
                                                      : first_char_level_amount_problem_solved ==
                                                      '3'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/green/3_green.png')
                                                      : first_char_level_amount_problem_solved ==
                                                      '4'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/green/4_green.png')
                                                      : first_char_level_amount_problem_solved ==
                                                      '5'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/green/5_green.png')
                                                      : first_char_level_amount_problem_solved ==
                                                      '6'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/green/6_green.png')
                                                      : first_char_level_amount_problem_solved == '7'
                                                      ? Image.asset('assets/images/home/numbers/green/7_green.png')
                                                      : first_char_level_amount_problem_solved == '8'
                                                      ? Image.asset('assets/images/home/numbers/green/8_green.png')
                                                      : first_char_level_amount_problem_solved == '9'
                                                      ? Image.asset('assets/images/home/numbers/green/9_green.png')
                                                      : first_char_level_amount_problem_solved == '0'
                                                      ? Image.asset('assets/images/home/numbers/green/0_green.png')
                                                      : SizedBox()),
                                            ),
                                          ]),
                                      Stack(
                                          children:[
                                            isShowProblemSolved && third_char_level_amount_problem_solved == ''? Padding(
                                              padding: const EdgeInsets.only(left:20.0),
                                              child: Container(
                                                  height: 40,
                                                  width: 30,
                                                  child: Image.asset(
                                                      'assets/images/home/numbers_green_stars_R.png')),
                                            ):SizedBox(),
                                            Padding(
                                              padding: const EdgeInsets.only(top:20.0),
                                              child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  child: second_char_level_amount_problem_solved ==
                                                      '1'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/green/1_green.png')
                                                      : second_char_level_amount_problem_solved ==
                                                      '2'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/green/2_green.png')
                                                      : second_char_level_amount_problem_solved ==
                                                      '3'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/green/3_green.png')
                                                      : second_char_level_amount_problem_solved ==
                                                      '4'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/green/4_green.png')
                                                      : second_char_level_amount_problem_solved ==
                                                      '5'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/green/5_green.png')
                                                      : second_char_level_amount_problem_solved ==
                                                      '6'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/green/6_green.png')
                                                      : second_char_level_amount_problem_solved == '7'
                                                      ? Image.asset('assets/images/home/numbers/green/7_green.png')
                                                      : second_char_level_amount_problem_solved == '8'
                                                      ? Image.asset('assets/images/home/numbers/green/8_green.png')
                                                      : second_char_level_amount_problem_solved == '9'
                                                      ? Image.asset('assets/images/home/numbers/green/9_green.png')
                                                      : second_char_level_amount_problem_solved == '0'
                                                      ? Image.asset('assets/images/home/numbers/green/0_green.png')
                                                      : SizedBox()),
                                            ),
                                          ] ),
                                      Stack(
                                          children:[
                                            isShowProblemSolved && third_char_level_amount_problem_solved != ''? Padding(
                                              padding: const EdgeInsets.only(left:20.0),
                                              child: Container(
                                                  height: 40,
                                                  width: 30,
                                                  child: Image.asset(
                                                      'assets/images/home/numbers_green_stars_R.png')),
                                            ):SizedBox(),
                                            Padding(
                                              padding: const EdgeInsets.only(top:20.0),
                                              child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  child: third_char_level_amount_problem_solved ==
                                                      '1'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/green/1_green.png')
                                                      : third_char_level_amount_problem_solved ==
                                                      '2'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/green/2_green.png')
                                                      : third_char_level_amount_problem_solved ==
                                                      '3'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/green/3_green.png')
                                                      : third_char_level_amount_problem_solved ==
                                                      '4'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/green/4_green.png')
                                                      : third_char_level_amount_problem_solved ==
                                                      '5'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/green/5_green.png')
                                                      : third_char_level_amount_problem_solved ==
                                                      '6'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/green/6_green.png')
                                                      : third_char_level_amount_problem_solved == '7'
                                                      ? Image.asset('assets/images/home/numbers/green/7_green.png')
                                                      : third_char_level_amount_problem_solved == '8'
                                                      ? Image.asset('assets/images/home/numbers/green/8_green.png')
                                                      : third_char_level_amount_problem_solved == '9'
                                                      ? Image.asset('assets/images/home/numbers/green/9_green.png')
                                                      : third_char_level_amount_problem_solved == '0'
                                                      ? Image.asset('assets/images/home/numbers/green/0_green.png')
                                                      : SizedBox()),
                                            ),
                                          ] ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0, right: 25),
                                    child: Stack(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0),
                                        child: RotatedBox(
                                          quarterTurns: -1,
                                          child: LinearPercentIndicator(
                                            width: 240.0,
                                            lineHeight: 24.0,
                                            barRadius:
                                            Radius.circular(10.0),
                                            percent:
                                            problem_solved / 100,
                                            backgroundColor:
                                            problems_solved_bgcolor !=
                                                ''
                                                ? HexColor(
                                                problems_solved_bgcolor)
                                                .withOpacity(
                                                0.1)
                                                : Colors
                                                .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[1]['color']!).withOpacity(0.1) : Colors.white,//Color.fromRGBO(121, 205, 31, 0.1),
                                            progressColor:
                                            problems_solved_bgcolor !=
                                                ''
                                                ? HexColor(
                                                problems_solved_bgcolor)
                                                .withOpacity(
                                                1.0)
                                                : Colors
                                                .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[1]['color']!).withOpacity(1.0) : Colors.white,//Color.fromRGBO(121, 205, 31, 1.0),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 10.0),
                                        child: RotatedBox(
                                          quarterTurns: -1,
                                          child: Container(
                                              width: 220.0,
                                              height: 26,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 3,
                                                    color:
                                                    Colors.black),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(10.0),
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3.0),
                                        child: AnimatedContainer(
                                          duration:
                                          Duration(seconds: 3),
                                          height:
                                          current_problem_solved_plan_height, //430
                                          width: 40,
                                          child: Image.asset(
                                              'assets/images/home/Kids_progressbar_greenicon.png'),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       top: 5.0, bottom: 10.0, right: 20),
                                  //   child: Column(
                                  //     children: [
                                  //       Text(display_problem_solved,
                                  //           style: TextStyle(
                                  //             color: problems_solved_bgcolor != ''
                                  //                 ? HexColor(
                                  //                         problems_solved_bgcolor)
                                  //                     .withOpacity(1.0)
                                  //                 : Colors
                                  //                     .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[1]['color']!).withOpacity(1.0) : Colors.white,//Color.fromRGBO(121, 205, 31, 1.0),
                                  //             fontWeight: FontWeight.w600,
                                  //             fontSize: 28.0,
                                  //           )),
                                  //       Text(
                                  //           "${problems_solved_name}!"
                                  //               .toUpperCase(),
                                  //           style: TextStyle(
                                  //             color: Colors.black,
                                  //             fontWeight: FontWeight.w700,
                                  //             fontSize: 12.0,
                                  //           ))
                                  //     ],
                                  //   ),
                                  // )
                                ],
                              ),
                              isShowProblemSolved
                                  ? SizedBox(height: 10)
                                  : SizedBox(),
                              isShowProblemSolved
                                  ? Positioned(
                                left: 18,
                                //right:10,
                                bottom: 0,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          right: 10.0),
                                      child: Text(
                                          display_problem_solved,
                                          style: TextStyle(
                                            color: problems_solved_bgcolor !=
                                                ''
                                                ? HexColor(
                                                problems_solved_bgcolor)
                                                .withOpacity(
                                                1.0)
                                                : Colors
                                                .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[1]['color']!).withOpacity(1.0) : Colors.white,//Color.fromRGBO(121, 205, 31, 1.0),
                                            fontWeight:
                                            FontWeight.w600,
                                            fontSize: 28.0,
                                          )),
                                    ),
                                    Text(
                                        "${problems_solved_name}!"
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight:
                                          FontWeight.w700,
                                          fontSize: 9.0,
                                        ))
                                  ],
                                ),
                              )
                                  : SizedBox()
                            ]),
                          ),
                          Positioned(
                            right: 0,
                            child: isShowDayStreak
                                ? Container(
                                    height: 330,
                                    child: Stack(children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Stack(
                                                children:[
                                                  isShowDayStreak? Container(
                                                      height: 40,
                                                      width: 30,
                                                      child: Image.asset(
                                                          'assets/images/home/numbers_yellow_stars_L.png')):SizedBox(),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:20.0,top:20.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: first_char_level_amount_day_streak ==
                                                              '1'
                                                          ? Image.asset(
                                                              'assets/images/home/numbers/red/1_red.png')
                                                          : first_char_level_amount_day_streak ==
                                                                  '2'
                                                              ? Image.asset(
                                                                  'assets/images/home/numbers/red/2_red.png')
                                                              : first_char_level_amount_day_streak ==
                                                                      '3'
                                                                  ? Image.asset(
                                                                      'assets/images/home/numbers/red/3_red.png')
                                                                  : first_char_level_amount_day_streak ==
                                                                          '4'
                                                                      ? Image.asset(
                                                                          'assets/images/home/numbers/red/4_red.png')
                                                                      : first_char_level_amount_day_streak ==
                                                                              '5'
                                                                          ? Image.asset(
                                                                              'assets/images/home/numbers/red/5_red.png')
                                                                          : first_char_level_amount_day_streak ==
                                                                                  '6'
                                                                              ? Image.asset(
                                                                                  'assets/images/home/numbers/red/6_red.png')
                                                                              : first_char_level_amount_day_streak == '7'
                                                                                  ? Image.asset('assets/images/home/numbers/red/7_red.png')
                                                                                  : first_char_level_amount_day_streak == '8'
                                                                                      ? Image.asset('assets/images/home/numbers/red/8_red.png')
                                                                                      : first_char_level_amount_day_streak == '9'
                                                                                          ? Image.asset('assets/images/home/numbers/red/9_red.png')
                                                                                          : first_char_level_amount_day_streak == '0'
                                                                                              ? Image.asset('assets/images/home/numbers/red/0_red.png')
                                                                                              : SizedBox()),
                                                  ),
                                              ]),
                                              Stack(
                                                children:[
                                                  isShowDayStreak && third_char_level_amount_day_streak == ''? Padding(
                                                      padding: const EdgeInsets.only(left:20.0),
                                                      child: Container(
                                                          height: 40,
                                                          width: 30,
                                                          child: Image.asset(
                                                              'assets/images/home/numbers_yellow_stars_R.png'))):SizedBox(),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:20.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: second_char_level_amount_day_streak ==
                                                              '1'
                                                          ? Image.asset(
                                                              'assets/images/home/numbers/red/1_red.png')
                                                          : second_char_level_amount_day_streak ==
                                                                  '2'
                                                              ? Image.asset(
                                                                  'assets/images/home/numbers/red/2_red.png')
                                                              : second_char_level_amount_day_streak ==
                                                                      '3'
                                                                  ? Image.asset(
                                                                      'assets/images/home/numbers/red/3_red.png')
                                                                  : second_char_level_amount_day_streak ==
                                                                          '4'
                                                                      ? Image.asset(
                                                                          'assets/images/home/numbers/red/4_red.png')
                                                                      : second_char_level_amount_day_streak ==
                                                                              '5'
                                                                          ? Image.asset(
                                                                              'assets/images/home/numbers/red/5_red.png')
                                                                          : second_char_level_amount_day_streak ==
                                                                                  '6'
                                                                              ? Image.asset(
                                                                                  'assets/images/home/numbers/red/6_red.png')
                                                                              : second_char_level_amount_day_streak == '7'
                                                                                  ? Image.asset('assets/images/home/numbers/red/7_red.png')
                                                                                  : second_char_level_amount_day_streak == '8'
                                                                                      ? Image.asset('assets/images/home/numbers/red/8_red.png')
                                                                                      : second_char_level_amount_day_streak == '9'
                                                                                          ? Image.asset('assets/images/home/numbers/red/9_red.png')
                                                                                          : second_char_level_amount_day_streak == '0'
                                                                                              ? Image.asset('assets/images/home/numbers/red/0_red.png')
                                                                                              : SizedBox()),
                                                  ),
                                             ] ),
                                              Stack(
                                                children:[
                                                  isShowDayStreak && third_char_level_amount_day_streak != ''? Padding(
                                                    padding: const EdgeInsets.only(left:20.0),
                                                    child: Container(
                                                        height: 40,
                                                        width: 30,
                                                        child: Image.asset(
                                                            'assets/images/home/numbers_yellow_stars_R.png')),
                                                  ):SizedBox(),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:20.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: third_char_level_amount_day_streak ==
                                                              '1'
                                                          ? Image.asset(
                                                              'assets/images/home/numbers/red/1_red.png')
                                                          : third_char_level_amount_day_streak ==
                                                                  '2'
                                                              ? Image.asset(
                                                                  'assets/images/home/numbers/red/2_red.png')
                                                              : third_char_level_amount_day_streak ==
                                                                      '3'
                                                                  ? Image.asset(
                                                                      'assets/images/home/numbers/red/3_red.png')
                                                                  : third_char_level_amount_day_streak ==
                                                                          '4'
                                                                      ? Image.asset(
                                                                          'assets/images/home/numbers/red/4_red.png')
                                                                      : third_char_level_amount_day_streak ==
                                                                              '5'
                                                                          ? Image.asset(
                                                                              'assets/images/home/numbers/red/5_red.png')
                                                                          : third_char_level_amount_day_streak ==
                                                                                  '6'
                                                                              ? Image.asset(
                                                                                  'assets/images/home/numbers/red/6_red.png')
                                                                              : third_char_level_amount_day_streak == '7'
                                                                                  ? Image.asset('assets/images/home/numbers/red/7_red.png')
                                                                                  : third_char_level_amount_day_streak == '8'
                                                                                      ? Image.asset('assets/images/home/numbers/red/8_red.png')
                                                                                      : third_char_level_amount_day_streak == '9'
                                                                                          ? Image.asset('assets/images/home/numbers/red/9_red.png')
                                                                                          : third_char_level_amount_day_streak == '0'
                                                                                              ? Image.asset('assets/images/home/numbers/red/0_red.png')
                                                                                              : SizedBox()),
                                                  ),
                                              ]),
                                            ],
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0, right: 0),
                                              child: Stack(children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      right: 20.0,bottom: 35),
                                                  child: RotatedBox(
                                                    quarterTurns: -1,
                                                    child: LinearPercentIndicator(
                                                      width: 240.0,
                                                      lineHeight: 24.0,
                                                      barRadius:
                                                          Radius.circular(10.0),
                                                      percent: day_steak / 100,
                                                      backgroundColor:
                                                          day_streak_bgcolor != ''
                                                              ? HexColor(
                                                                      day_streak_bgcolor)
                                                                  .withOpacity(
                                                                      0.1)
                                                              : Colors
                                                                  .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[2]['color']!).withOpacity(0.1) : Colors.white,//Color.fromRGBO(242, 25, 43, 0.1),
                                                      progressColor: day_streak_bgcolor !=
                                                              ''
                                                          ? HexColor(
                                                                  day_streak_bgcolor)
                                                              .withOpacity(1.0)
                                                          : Colors
                                                              .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[2]['color']!).withOpacity(1.0) : Colors.white,//Color.fromRGBO(242, 25, 43, 1.0),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 10.0, right: 20),
                                                  child: RotatedBox(
                                                    quarterTurns: -1,
                                                    child: Container(
                                                        width: 220.0,
                                                        height: 26,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 3,
                                                              color:
                                                                  Colors.black),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                        )),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top:60.0),
                                                  child: AnimatedContainer(
                                                    duration:
                                                        Duration(seconds: 3),
                                                    height:
                                                        current_day_streak_plan_height, //430
                                                    width: 25,
                                                    //color: Colors.red,
                                                    child: Image.asset(
                                                        'assets/images/home/Kids_progressbar_redicon.png'),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ),

                                        ],
                                      ),

                                      isShowDayStreak
                                          ? Positioned(
                                              right: 47,
                                              bottom: 0,
                                              child: Column(
                                                children: [
                                                  Text(display_day_steak,
                                                      style: TextStyle(
                                                        color: day_streak_bgcolor !=
                                                                ''
                                                            ? HexColor(
                                                                    day_streak_bgcolor)
                                                                .withOpacity(
                                                                    1.0)
                                                            : Colors
                                                                .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[2]['color']!).withOpacity(1.0) : Colors.white,//Color.fromRGBO(242, 25, 43, 1.0),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 28.0,
                                                      )),
                                                  Text(
                                                      "${day_streak_name}!"
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 9.0,
                                                      ))
                                                ],
                                              ),
                                            )
                                          : SizedBox()
                                    ]),
                                  )
                                : Stack(children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Stack(
                                          children:[
                                            isShowDayStreak? Container(
                                                height: 40,
                                                width: 30,
                                                child: Image.asset(
                                                    'assets/images/home/numbers_yellow_stars_L.png')):SizedBox(),
                                            Padding(
                                              padding: const EdgeInsets.only(left:20.0,top:20.0),
                                              child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  child: first_char_level_amount_day_streak ==
                                                      '1'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/red/1_red.png')
                                                      : first_char_level_amount_day_streak ==
                                                      '2'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/red/2_red.png')
                                                      : first_char_level_amount_day_streak ==
                                                      '3'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/red/3_red.png')
                                                      : first_char_level_amount_day_streak ==
                                                      '4'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/red/4_red.png')
                                                      : first_char_level_amount_day_streak ==
                                                      '5'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/red/5_red.png')
                                                      : first_char_level_amount_day_streak ==
                                                      '6'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/red/6_red.png')
                                                      : first_char_level_amount_day_streak == '7'
                                                      ? Image.asset('assets/images/home/numbers/red/7_red.png')
                                                      : first_char_level_amount_day_streak == '8'
                                                      ? Image.asset('assets/images/home/numbers/red/8_red.png')
                                                      : first_char_level_amount_day_streak == '9'
                                                      ? Image.asset('assets/images/home/numbers/red/9_red.png')
                                                      : first_char_level_amount_day_streak == '0'
                                                      ? Image.asset('assets/images/home/numbers/red/0_red.png')
                                                      : SizedBox()),
                                            ),
                                          ]),
                                      Stack(
                                          children:[
                                            isShowDayStreak && third_char_level_amount_day_streak == ''? Padding(
                                                padding: const EdgeInsets.only(left:20.0),
                                                child: Container(
                                                    height: 40,
                                                    width: 30,
                                                    child: Image.asset(
                                                        'assets/images/home/numbers_yellow_stars_R.png'))):SizedBox(),
                                            Padding(
                                              padding: const EdgeInsets.only(top:20.0),
                                              child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  child: second_char_level_amount_day_streak ==
                                                      '1'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/red/1_red.png')
                                                      : second_char_level_amount_day_streak ==
                                                      '2'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/red/2_red.png')
                                                      : second_char_level_amount_day_streak ==
                                                      '3'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/red/3_red.png')
                                                      : second_char_level_amount_day_streak ==
                                                      '4'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/red/4_red.png')
                                                      : second_char_level_amount_day_streak ==
                                                      '5'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/red/5_red.png')
                                                      : second_char_level_amount_day_streak ==
                                                      '6'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/red/6_red.png')
                                                      : second_char_level_amount_day_streak == '7'
                                                      ? Image.asset('assets/images/home/numbers/red/7_red.png')
                                                      : second_char_level_amount_day_streak == '8'
                                                      ? Image.asset('assets/images/home/numbers/red/8_red.png')
                                                      : second_char_level_amount_day_streak == '9'
                                                      ? Image.asset('assets/images/home/numbers/red/9_red.png')
                                                      : second_char_level_amount_day_streak == '0'
                                                      ? Image.asset('assets/images/home/numbers/red/0_red.png')
                                                      : SizedBox()),
                                            ),
                                          ] ),
                                      Stack(
                                          children:[
                                            isShowDayStreak && third_char_level_amount_day_streak != ''? Padding(
                                              padding: const EdgeInsets.only(left:20.0),
                                              child: Container(
                                                  height: 40,
                                                  width: 30,
                                                  child: Image.asset(
                                                      'assets/images/home/numbers_yellow_stars_R.png')),
                                            ):SizedBox(),
                                            Padding(
                                              padding: const EdgeInsets.only(top:20.0),
                                              child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  child: third_char_level_amount_day_streak ==
                                                      '1'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/red/1_red.png')
                                                      : third_char_level_amount_day_streak ==
                                                      '2'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/red/2_red.png')
                                                      : third_char_level_amount_day_streak ==
                                                      '3'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/red/3_red.png')
                                                      : third_char_level_amount_day_streak ==
                                                      '4'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/red/4_red.png')
                                                      : third_char_level_amount_day_streak ==
                                                      '5'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/red/5_red.png')
                                                      : third_char_level_amount_day_streak ==
                                                      '6'
                                                      ? Image.asset(
                                                      'assets/images/home/numbers/red/6_red.png')
                                                      : third_char_level_amount_day_streak == '7'
                                                      ? Image.asset('assets/images/home/numbers/red/7_red.png')
                                                      : third_char_level_amount_day_streak == '8'
                                                      ? Image.asset('assets/images/home/numbers/red/8_red.png')
                                                      : third_char_level_amount_day_streak == '9'
                                                      ? Image.asset('assets/images/home/numbers/red/9_red.png')
                                                      : third_char_level_amount_day_streak == '0'
                                                      ? Image.asset('assets/images/home/numbers/red/0_red.png')
                                                      : SizedBox()),
                                            ),
                                          ]),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0, right: 0),
                                    child: Stack(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 20.0,bottom: 55),
                                        child: RotatedBox(
                                          quarterTurns: -1,
                                          child: LinearPercentIndicator(
                                            width: 240.0,
                                            lineHeight: 24.0,
                                            barRadius:
                                            Radius.circular(10.0),
                                            percent: day_steak / 100,
                                            backgroundColor:
                                            day_streak_bgcolor != ''
                                                ? HexColor(
                                                day_streak_bgcolor)
                                                .withOpacity(
                                                0.1)
                                                : Colors
                                                .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[2]['color']!).withOpacity(0.1) : Colors.white,//Color.fromRGBO(242, 25, 43, 0.1),
                                            progressColor: day_streak_bgcolor !=
                                                ''
                                                ? HexColor(
                                                day_streak_bgcolor)
                                                .withOpacity(1.0)
                                                : Colors
                                                .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[2]['color']!).withOpacity(1.0) : Colors.white,//Color.fromRGBO(242, 25, 43, 1.0),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, right: 20),
                                        child: RotatedBox(
                                          quarterTurns: -1,
                                          child: Container(
                                              width: 220.0,
                                              height: 26,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 3,
                                                    color:
                                                    Colors.black),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(10.0),
                                              )),
                                        ),
                                      ),
                                      AnimatedContainer(
                                        duration:
                                        Duration(seconds: 3),
                                        height:
                                        current_day_streak_plan_height, //430
                                        width: 25,
                                        //color: Colors.red,
                                        child: Image.asset(
                                            'assets/images/home/Kids_progressbar_redicon.png'),
                                      ),
                                    ]),
                                  ),

                                ],
                              ),

                              isShowDayStreak
                                  ? Positioned(
                                right: 30,
                                bottom: 0,
                                child: Column(
                                  children: [
                                    Text(display_day_steak,
                                        style: TextStyle(
                                          color: day_streak_bgcolor !=
                                              ''
                                              ? HexColor(
                                              day_streak_bgcolor)
                                              .withOpacity(
                                              1.0)
                                              : Colors
                                              .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[2]['color']!).withOpacity(1.0) : Colors.white,//Color.fromRGBO(242, 25, 43, 1.0),
                                          fontWeight:
                                          FontWeight.w600,
                                          fontSize: 28.0,
                                        )),
                                    Text(
                                        "${day_streak_name}!"
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight:
                                          FontWeight.w700,
                                          fontSize: 9.0,
                                        ))
                                  ],
                                ),
                              )
                                  : SizedBox()
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Stack(children: [
                      Container(
                        // height: 30,
                        // width: 30,
                        child: Image.asset(
                            'assets/images/home/achievements_textbox.png'),
                      ),
                      Positioned(
                        left: 10, //MediaQuery.of(context).size.width / 2 - 130,
                        top: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Way to go!",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22.0,
                                )),
                            Text("Look at all your achievements!",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0,
                                ))
                          ],
                        ),
                      )
                    ]),
                  ),
                  Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Container(
                        //height: 50,
                        width: MediaQuery.of(context).size.width / 2,
                        child: Image.asset(
                            'assets/images/home/yourachievements_text.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 100.0, top: 10.0, left: 10.0),
                      child: GridView.builder(
                        itemCount: earnAchievedLists.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10.0, left: 10.0, right: 10.0),
                            child: Stack(children: [
                              Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      child: CachedNetworkImage(
                                          imageUrl: earnAchievedLists[index]
                                              ['badge_image'],
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) =>
                                              Transform.scale(
                                                scale: 0.5,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Color.fromRGBO(
                                                      216, 209, 231, 1.0),
                                                ),
                                              )),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 160,
                            width: 150,
                            child: Image.asset(
                              'assets/images/home/orange_cheer.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0),
                    child: Row(
                      children: [
                        Container(
                          //height: 50,
                          width: MediaQuery.of(context).size.width / 2,
                          child: Image.asset(
                              'assets/images/home/favouritebook_text.png'),
                        ),
                      ],
                    ),
                  ),
                  Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 100.0, left: 10.0),
                      child: GridView.builder(
                        itemCount: favBooksLists.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          // return bookListRow(bookLists[index]);
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10.0, left: 10.0, right: 10.0),
                            child: Stack(children: [
                              Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                        height: 50,
                                        width: 70,
                                        child: CachedNetworkImage(
                                            imageUrl: favBooksLists[index]
                                                            ['cover_url'] !=
                                                        null &&
                                                    favBooksLists[index]
                                                            ['cover_url'] !=
                                                        ''
                                                ? favBooksLists[index]
                                                    ['cover_url']
                                                : '',
                                            // fit: BoxFit.fill,
                                            placeholder: (context, url) =>
                                                Transform.scale(
                                                  scale: 0.5,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Color.fromRGBO(
                                                        216, 209, 231, 1.0),
                                                  ),
                                                ))
                                        //   //  Image.asset('assets/images/profile.png'),
                                        //   // child: Image.network(
                                        //   //     mainCategoryData[index]
                                        //   //         ['catimage1url']),
                                        // ),
                                        // child: Image.asset(
                                        //     'assets/images/home/kidsevent_preview_yellow_box.png'),
                                        ),
                                  ),
                                ],
                              ),

                              // Container(
                              //   // height: 150,
                              //   decoration: BoxDecoration(
                              //     image: DecorationImage(
                              //       image: AssetImage(
                              //           'assets/images/books/pagepreview_red_page.png'),
                              //     ),
                              //   ),
                              // ),
                            ]),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            child: Image.asset(
                                'assets/images/home/background_kids_square.png'),
                          ),
                        ],
                      ),
                    )
                  ]),
                ],
              ),
            ]),
          ),
        ));
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
