import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../auth/helpers/authentication_helper.dart';

class Home extends StatefulWidget {
  String? uid = '';
   Home({Key? key,this.uid}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Query collectionRefAchievment;
  late QuerySnapshot querySnapshotAchievment;
  var achievmentLists = [];

  late Query collectionRefGameCondition;
  late QuerySnapshot querySnapshotGameCondition;
  var gameConditionLists = [];

  late Query collectionRefUser;
  late QuerySnapshot querySnapshotUser;
  var userLists = [];
  var earnAchievedLists = [];
  var inProgressAchievedLists = [];
  var inProgressAchievedNameLists = [];

//Dynamic Achievement var declaration
  var level_amount = [];
  var display_level_amount = [];
  var first_char_level_amount = [];
  var second_char_level_amount = [];
  var third_char_level_amount = [];
  var achievement_bgcolor = [];
  var achievement_name = [];
  var aggregation_rules = [];
  var total = [];
  var avgAmount = [];

  String first_char_level_amount_ach1 = '0';
  String second_char_level_amount_ach1 = '';
  String third_char_level_amount_ach1 = '';

  String first_char_level_amount_ach2 = '0';
  String second_char_level_amount_ach2 = '';
  String third_char_level_amount_ach2 = '';

  String first_char_level_amount_ach3 = '0';
  String second_char_level_amount_ach3 = '0';
  String third_char_level_amount_ach3 = '';

  late Query collectionRefFavBooks;
  late QuerySnapshot querySnapshotFavBooks;
  var favBooksLists = [];

  late Query collectionAvatar;
  late QuerySnapshot querySnapshotAvatar;
  var avatarLists = [];

//Animation for kids progress

  double ach1_plan_height = 430.0;
  double current_ach1_plan_height = 430.0;

  double ach2_plan_height = 440.0;
  double current_ach2_plan_height = 440.0;

  double ach3_plan_height = 470.0;
  double current_ach3_plan_height = 470.0;

  double problem_solved_plan_height = 440.0;
  double current_problem_solved_plan_height = 440.0;
  bool isShowProblemSolved = false;

  double day_streak_plan_height = 470.0;
  double current_day_streak_plan_height = 470.0;
  bool isShow1Achievement = false;
  bool isShow2Achievement = false;
  bool isShow3Achievement = false;

  double reading_time_plan_height = 430.0;
  double current_reading_time_plan_height = 430.0;
  bool isShowReadingTime = false;

  var profileUrlKey = '';
  var profileUrl = '';
  var achievementProfileUrl = '';

  int favBookThreshold = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    getAchievmentLevelData();
    getGameConditionData();
    getFavouriteBooksData();
  }

  Future<List> getAchievmentLevelData() async {
    collectionRefAchievment = FirebaseFirestore.instance
        .collection('achievement_condition_static')
        .where('uid', isEqualTo: 'DrknGaaPXCf0Aca0SHRF');

    // Get docs from collection reference
    querySnapshotAchievment = await collectionRefAchievment.get();

    // Get data from docs and convert map to List
    achievmentLists =
        querySnapshotAchievment.docs.map((doc) => doc.data()).toList();

    return achievmentLists;
  }

  Future<void> getGameConditionData() async {
    collectionRefGameCondition = FirebaseFirestore.instance
        .collection('in_game_conditions');

    // Get docs from collection reference
    querySnapshotGameCondition = await collectionRefGameCondition.get();

    // Get data from docs and convert map to List
    gameConditionLists = querySnapshotGameCondition.docs.map((doc) => doc.data()).toList();

    if(gameConditionLists.isNotEmpty) {
      favBookThreshold = gameConditionLists[0]['favorate_book_threashhold'];
      print("#### GAME THRESHOLD $favBookThreshold");
    }

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
          inProgressAchievedNameLists.add(inProgressAchievedLists[i]['name']);
//Stored aggregation rules
          var arrayAggregation = inProgressAchievedLists[i]['aggregation'];
          if (arrayAggregation.length > 0) {
            aggregation_rules.add(arrayAggregation);
          }
        }
        print('#### Aggregation RULES Array ${aggregation_rules}');
        //print('#### AGGREGATION RULES ${aggregation_rules.length > 0 ? aggregation_rules[0] : ''}');
        for (int i = 0; i < inProgressAchievedLists.length; i++) {
          if (inProgressAchievedLists[i]['Is_aggregate_field_value'] == false) {
            print('#### AGGREGATION RULE calculate for ${aggregation_rules[i]}');
            // print('#### User List ${userLists[i]}');
            String name = '';
            String key2 = '';
            if (aggregation_rules[i].length > 0) {
              name = aggregation_rules[i][0];
              if (aggregation_rules[i].length >= 2) {
                key2 = aggregation_rules[i][1];
              }
            }
            print('#### name $name');
            for (int i = 0; i < userLists.length; i++) {
              if (userLists[i].containsKey(name)) {
                print('#### key exists');
                if (aggregation_rules[i].length >= 2) {
                  var dic = userLists[i][name];
                  for (int j = 0; j < dic.length; j++) {
                    if (dic[j].containsKey(key2)) {
                      total += dic[j][key2].length;
                    }
                  }
                }
              else
                {
                  total.add(userLists[i][name].length);//
                }
                print('total is ${userLists[i][name].length}');
              } else {
                print('#### key not exists');
                var snackBar = SnackBar(content: Text('key not exists'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }
          } else {
            String key1 = '';
            String key2 = '';
            if (aggregation_rules[i].length > 0) {
              key1 = aggregation_rules[i][0];
              //print('#### Aggregation RULES Array ${aggregation_rules}');
              if (aggregation_rules[i].length >= 2) {
                key2 = aggregation_rules[i][1];
              }
            }
            num cnt = 0;
            for (int i = 0; i < userLists.length; i++) {
              if (userLists[i].containsKey(key1)) {
                print('#### Aggregation key exists');
                var dic = userLists[i][key1];
                print('#### Aggregation Dic $dic');
                for (int j = 0; j < dic.length; j++) {
                  if (dic[j].containsKey(key2)) {
                    cnt += dic[j][key2];
                  }
                }
              } else {
                print('#### Aggregation key not exists');
                var snackBar =
                    SnackBar(content: Text('Aggregation key not exists'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }
            total.add(cnt);
            print('#### Total AGGRE $total');
          }
          print('#### Total $total');

          level_amount.add(inProgressAchievedLists[i]['level_amount']);
          achievement_bgcolor.add(inProgressAchievedLists[i]['color']);
          achievement_name.add(inProgressAchievedLists[i]['name']);
          avgAmount.add(100/level_amount[i]);

          print('#### level_amount $i ${level_amount[i]}');
          print('#### achievement_bgcolor $i ${achievement_bgcolor[i]}');
          print('#### achievement_name $i ${achievement_name[i]}');
          print('#### AVG AMOUNT $i ${avgAmount[i]}');

          // if (inProgressAchievedLists.length == 1) {
          var number = (level_amount[i].toInt()).toString();
          if (number.length == 3) {
            for (int k = number.length - 1; k >= 0; k--) {
              if (k == 2) {
                if (i == 0) {
                  third_char_level_amount_ach1 = number[k];
                } else if (i == 1) {
                  third_char_level_amount_ach2 = number[k];
                } else {
                  third_char_level_amount_ach3 = number[k];
                }
              } else if (k == 1) {
                if (i == 0) {
                  second_char_level_amount_ach1 = number[k];
                } else if (i == 1) {
                  second_char_level_amount_ach2 = number[k];
                } else {
                  second_char_level_amount_ach3 = number[k];
                }
              } else {
                if (i == 0) {
                  first_char_level_amount_ach1 = number[k];
                } else if (i == 1) {
                  first_char_level_amount_ach2 = number[k];
                } else {
                  first_char_level_amount_ach3 = number[k];
                }
              }
            }
          } else if (number.length == 2) {
            for (int k = number.length - 1; k >= 0; k--) {
              if (k == 1) {
                if (i == 0) {
                  second_char_level_amount_ach1 = number[k];
                } else if (i == 1) {
                  second_char_level_amount_ach2 = number[k];
                } else {
                  second_char_level_amount_ach3 = number[k];
                }
              } else {
                if (i == 0) {
                  first_char_level_amount_ach1 = number[k];
                } else if (i == 1) {
                  first_char_level_amount_ach2 = number[k];
                } else {
                  first_char_level_amount_ach3 = number[k];
                }
              }
            }
          }else if(number.length == 1){

            if (i == 0) {
              first_char_level_amount_ach1 = number[0];
            } else if (i == 1) {
              first_char_level_amount_ach2 = number[0];
            } else {
              first_char_level_amount_ach3 = number[0];
            }
          }
          if (i == 0) {
            //Calculation for animation for Achievement 1 progress
            Future.delayed(const Duration(milliseconds: 1000), () {
              double avg_books_read = 0.0;
              avg_books_read = (ach1_plan_height * total[i]) / 100;
              current_ach1_plan_height = ach1_plan_height - avg_books_read;
              print('##### TOTAL HEIGHT ACH1 $ach1_plan_height');
              print('##### CURRENT HEIGHT ACH1 $current_ach1_plan_height');

              setState(() {
                current_ach1_plan_height;
              });
              Future.delayed(const Duration(milliseconds: 1000), () {
                isShow1Achievement = true;
                setState(() {
                  isShow1Achievement;
                });
              });
            });
          } else if (i == 1) {
            //Calculation for animation for Achievement 1 progress
            Future.delayed(const Duration(milliseconds: 1000), () {
              double avg_books_read = 0.0;
              avg_books_read = (ach2_plan_height * total[i]) / 100;
              current_ach2_plan_height = ach2_plan_height - avg_books_read;
              print('##### TOTAL HEIGHT ACH2 $ach2_plan_height');
              print('##### CURRENT HEIGHT ACH2 $current_ach2_plan_height');

              setState(() {
                current_ach2_plan_height;
              });
              Future.delayed(const Duration(milliseconds: 1000), () {
                isShow2Achievement = true;
                setState(() {
                  isShow2Achievement;
                });
              });
            });
          } else {
            //Calculation for animation for Achievement 1 progress
            Future.delayed(const Duration(milliseconds: 1000), () {
              double avg_books_read = 0.0;
              avg_books_read = (ach3_plan_height * total[i]) / 100;
              current_ach3_plan_height = ach3_plan_height - avg_books_read;
              print('##### TOTAL HEIGHT ACH3 $ach3_plan_height');
              print('##### CURRENT HEIGHT ACH3 $current_ach3_plan_height');

              setState(() {
                current_ach3_plan_height;
              });
              Future.delayed(const Duration(milliseconds: 1000), () {
                isShow3Achievement = true;
                setState(() {
                  isShow3Achievement;
                });
              });
            });
          }
          //   }
        }
      }
    }

    setState(() {
      earnAchievedLists;
      inProgressAchievedLists;
      level_amount;
      achievement_bgcolor;
      achievement_name;
    });
  }

  Future<void> getUserData() async {
    collectionRefUser = FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: widget.uid);

    // Get docs from collection reference
    querySnapshotUser = await collectionRefUser.get();

    // Get data from docs and convert map to List
    userLists = querySnapshotUser.docs.map((doc) => doc.data()).toList();

    setState(() {
      userLists;
    });

// Logic for earned achievement document
    List<String> docIDS = [];

    print("#### USER LIST ${userLists.toString()}");

    for (int i = 0; i < userLists.length; i++) {
      for (int j = 0; j < userLists[i]['earned_achievements'].length; j++) {
        String id = (userLists[i]['earned_achievements'][j]);
        docIDS.add(id.replaceAll(' ', ''));
      }
    }
    if(docIDS.isNotEmpty) {
      getEarnAchievmentLevelData(docIDS, true);
    }

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
    if(docInProgressIDS.isNotEmpty) {
      getEarnAchievmentLevelData(docInProgressIDS, false);
    }

    profileUrlKey = userLists.isNotEmpty ? userLists[0]['profile_url'] : '';
    getProfileData();
  }

  Future<void> getProfileData() async {
    var collection =
    FirebaseFirestore.instance.collection('kids_avatar_collection_static');
    var docSnapshot = await collection.doc('vEHmJgUnjM5nq09wzkU9').get();
    if (docSnapshot.exists) {
      avatarLists = [];
      Map<String, dynamic>? data = docSnapshot.data();
      avatarLists = data?['avatar_collection']; // <-- The value you want to retrieve.
      print("#### AVATAR LIST ${avatarLists.toString()}");

      for (int i = 0; i < avatarLists.length; i++) {
           if(avatarLists[i]['name'] == profileUrlKey){
             profileUrl = avatarLists[i]['icon'];
             achievementProfileUrl = avatarLists[i]['wave'];
           }
      }
      setState(() {
        profileUrl;
        achievementProfileUrl;
      });
    }

    /*  collectionAvatar =
        FirebaseFirestore.instance.collection('kids_avatar_collection_static');

    // Get docs from collection reference
    querySnapshotAvatar = await collectionAvatar.get();

    // Get data from docs and convert map to ListAGGREGATION RULES
    avatarLists = querySnapshotAvatar.docs.map((doc) => doc.data()).toList();

    for (int i = 0; i < avatarLists.length; i++) {
      if (avatarLists[i].containsKey(profileUrlKey)) {
        print('#### key exists');
        var arrayAvatarList = avatarLists[i][profileUrlKey];
        profileUrl = arrayAvatarList['icon'];
        achievementProfileUrl = arrayAvatarList['wave'];

        setState(() {
          profileUrl;
        });
      } else {
        print('#### key not exists');
        var snackBar = SnackBar(
            content:
                Text('$profileUrlKey key not exists in avatar collection'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }*/
  }

  Future<void> getFavouriteBooksData() async {
    collectionRefFavBooks = FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: widget.uid);

    // Get docs from collection reference
    querySnapshotFavBooks = await collectionRefFavBooks.get();

    // Get data from docs and convert map to List
    favBooksLists =
        querySnapshotFavBooks.docs.map((doc) => doc.data()).toList();

    List<String> favBookId = [];
    for (int i = 0; i < favBooksLists.length; i++) {
      for (int j = 0; j < favBooksLists[i]['books_read'].length; j++) {
        if (favBooksLists[i]['books_read'][j]['reading_duration'] > favBookThreshold) {
          favBookId.add(
              favBooksLists[i]['books_read'][j]['book_id'].replaceAll(' ', ''));
        }
      }
    }
    print("### FAV BOOK ${favBookId.length}");

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

    // favBooksLists
    //     .sort((a, b) => a['reading_duration'].compareTo(b['reading_duration']));

    print("### FAV BOOKlist ${favBooksLists.length}");

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
                            child: profileUrl != ''
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: CachedNetworkImage(
                                        imageUrl: profileUrl,
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
      height: 350,
      child: ListView.builder(
      shrinkWrap: true,
      itemCount: 1,
      scrollDirection: Axis.horizontal,
      itemBuilder: (ctx,int) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                    //width: MediaQuery.of(context).size.width,
                    height: 350,
                    child: Stack(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Row(
                            mainAxisAlignment:
                            inProgressAchievedLists.length == 1
                                ? MainAxisAlignment.center
                                : inProgressAchievedLists.length == 2
                                ? MainAxisAlignment.spaceEvenly
                                : MainAxisAlignment.spaceBetween,
                            children: [
                              inProgressAchievedLists.length >= 1
                                  ? isShow1Achievement
                                  ? Container(
                                height: 350,
                                child: Stack(children: [
                                  Column(
                                    children: [
                                      Container(

                                          child:Column(
                                            children: [

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      height: 40,
                                                      width: 30,
                                                      child: Image.asset(
                                                          'assets/images/home/numbers_purple_stars_L.png')),

                                                  Padding(
                                                    padding: const EdgeInsets.only(top:30.0),
                                                    child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        child: first_char_level_amount_ach1 ==
                                                            '1'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/blue/1_blue.png')
                                                            : first_char_level_amount_ach1 ==
                                                            '2'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/blue/2_blue.png')
                                                            : first_char_level_amount_ach1 ==
                                                            '3'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/blue/3_blue.png')
                                                            : first_char_level_amount_ach1 == '4'
                                                            ? Image.asset('assets/images/home/numbers/blue/4_blue.png')
                                                            : first_char_level_amount_ach1 == '5'
                                                            ? Image.asset('assets/images/home/numbers/blue/5_blue.png')
                                                            : first_char_level_amount_ach1 == '6'
                                                            ? Image.asset('assets/images/home/numbers/blue/6_blue.png')
                                                            : first_char_level_amount_ach1 == '7'
                                                            ? Image.asset('assets/images/home/numbers/blue/7_blue.png')
                                                            : first_char_level_amount_ach1 == '8'
                                                            ? Image.asset('assets/images/home/numbers/blue/8_blue.png')
                                                            : first_char_level_amount_ach1 == '9'
                                                            ? Image.asset('assets/images/home/numbers/blue/9_blue.png')
                                                            : first_char_level_amount_ach1 == '0'
                                                            ? Image.asset('assets/images/home/numbers/blue/0_blue.png')
                                                            : SizedBox()),
                                                  ),
                                                  second_char_level_amount_ach1 != '' ?
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:30.0),
                                                    child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        child: second_char_level_amount_ach1 ==
                                                            '1'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/blue/1_blue.png')
                                                            : second_char_level_amount_ach1 ==
                                                            '2'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/blue/2_blue.png')
                                                            : second_char_level_amount_ach1 ==
                                                            '3'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/blue/3_blue.png')
                                                            : second_char_level_amount_ach1 == '4'
                                                            ? Image.asset('assets/images/home/numbers/blue/4_blue.png')
                                                            : second_char_level_amount_ach1 == '5'
                                                            ? Image.asset('assets/images/home/numbers/blue/5_blue.png')
                                                            : second_char_level_amount_ach1 == '6'
                                                            ? Image.asset('assets/images/home/numbers/blue/6_blue.png')
                                                            : second_char_level_amount_ach1 == '7'
                                                            ? Image.asset('assets/images/home/numbers/blue/7_blue.png')
                                                            : second_char_level_amount_ach1 == '8'
                                                            ? Image.asset('assets/images/home/numbers/blue/8_blue.png')
                                                            : second_char_level_amount_ach1 == '9'
                                                            ? Image.asset('assets/images/home/numbers/blue/9_blue.png')
                                                            : second_char_level_amount_ach1 == '0'
                                                            ? Image.asset('assets/images/home/numbers/blue/0_blue.png')
                                                            : SizedBox(width: 0)),
                                                  ):
                                                  SizedBox(width: 0),
                                                  third_char_level_amount_ach1 != '' ?
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:30.0),
                                                    child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        child: third_char_level_amount_ach1 ==
                                                            '1'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/blue/1_blue.png')
                                                            : third_char_level_amount_ach1 ==
                                                            '2'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/blue/2_blue.png')
                                                            : third_char_level_amount_ach1 ==
                                                            '3'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/blue/3_blue.png')
                                                            : third_char_level_amount_ach1 == '4'
                                                            ? Image.asset('assets/images/home/numbers/blue/4_blue.png')
                                                            : third_char_level_amount_ach1 == '5'
                                                            ? Image.asset('assets/images/home/numbers/blue/5_blue.png')
                                                            : third_char_level_amount_ach1 == '6'
                                                            ? Image.asset('assets/images/home/numbers/blue/6_blue.png')
                                                            : third_char_level_amount_ach1 == '7'
                                                            ? Image.asset('assets/images/home/numbers/blue/7_blue.png')
                                                            : third_char_level_amount_ach1 == '8'
                                                            ? Image.asset('assets/images/home/numbers/blue/8_blue.png')
                                                            : third_char_level_amount_ach1 == '9'
                                                            ? Image.asset('assets/images/home/numbers/blue/9_blue.png')
                                                            : third_char_level_amount_ach1 == '0'
                                                            ? Image.asset('assets/images/home/numbers/blue/0_blue.png')
                                                            : SizedBox(width: 0)),
                                                  ):
                                                  SizedBox(width: 0),
                                                  Container(
                                                      height: 40,
                                                      width: 30,
                                                      child: Image
                                                          .asset(
                                                          'assets/images/home/numbers_purple_stars_R.png'))
                                                ],
                                              )
                                            ],
                                          )
                                      ),



                                      Expanded(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              top: 5.0,
                                              right: 0.0,
                                              bottom: 45),
                                          child: Stack(children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  left: 10.0),
                                              child: RotatedBox(
                                                quarterTurns: -1,
                                                child:
                                                LinearPercentIndicator(
                                                  width: 240.0,
                                                  lineHeight: 24.0,
                                                  barRadius: Radius
                                                      .circular(
                                                      10.0),
                                                  percent:
                                                  (total[0] * avgAmount[0]) / 100,
                                                  // backgroundColor: Color.fromRGBO(71, 169, 229, 0.1),
                                                  // progressColor: Color.fromRGBO(71, 169, 229, 1.0),
                                                  backgroundColor: achievement_bgcolor[
                                                  0] !=
                                                      ''
                                                      ? HexColor(
                                                      achievement_bgcolor[
                                                      0])
                                                      .withOpacity(
                                                      0.1)
                                                      : Colors
                                                      .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(0.1) : Colors.white,//HexColor("b74093"),
                                                  progressColor: achievement_bgcolor[
                                                  0] !=
                                                      ''
                                                      ? HexColor(
                                                      achievement_bgcolor[
                                                      0])
                                                      .withOpacity(
                                                      1.0)
                                                      : Colors
                                                      .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(1.0) : Colors.white,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  top: 10.0,
                                                  left: 10.0),
                                              child: RotatedBox(
                                                quarterTurns: -1,
                                                child: Container(
                                                    width: 220.0,
                                                    height: 26,
                                                    decoration:
                                                    BoxDecoration(
                                                      border: Border.all(
                                                          width: 3,
                                                          color: Colors
                                                              .black),
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          10.0),
                                                    )),
                                              ),
                                            ),
                                            Padding(
                                              padding: total[0]*avgAmount[0] >=
                                                  0 &&
                                                  total[0]*avgAmount[0] <= 50
                                                  ? EdgeInsets.only(
                                                left: 3.0,
                                                top: total[0]*avgAmount[0] >=
                                                    0 &&
                                                    total[0]*avgAmount[0] <=
                                                        20
                                                    ? 180
                                                    : total[0]*avgAmount[0] > 20 &&
                                                    total[0]*avgAmount[0] <= 30
                                                    ? 130
                                                    : total[0]*avgAmount[0] > 30 && total[0]*avgAmount[0] <= 40
                                                    ? 90
                                                    : total[0]*avgAmount[0] > 40 && total[0]*avgAmount[0] <= 50
                                                    ? 20
                                                    : 0,
                                              )
                                                  : EdgeInsets.only(
                                                left: 3.0,
                                                bottom: total[0]*avgAmount[0] >
                                                    50 &&
                                                    total[0]*avgAmount[0] <=
                                                        60
                                                    ? 20
                                                    : total[0]*avgAmount[0] > 60 &&
                                                    total[0]*avgAmount[0] <= 70
                                                    ? 70
                                                    : total[0]*avgAmount[0] > 70 && total[0]*avgAmount[0] <= 80
                                                    ? 110
                                                    : total[0]*avgAmount[0] > 80 && total[0]*avgAmount[0] <= 90
                                                    ? 160
                                                    : 170,
                                              ),
                                              child:
                                              AnimatedContainer(
                                                //color: Colors.red,
                                                duration: Duration(
                                                    seconds: 2),
                                                height:
                                                current_ach1_plan_height, //430
                                                width: 40,
                                                child: Image.asset(
                                                    'assets/images/home/Kids_progressbar_blueicon.png'),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  isShow1Achievement
                                      ? Positioned(
                                    left: 0, //35,
                                    bottom: 5,
                                    child: Container(
                                      width:second_char_level_amount_ach1 == '' && third_char_level_amount_ach1 == ''?95:third_char_level_amount_ach1 == ''?115:145,

                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .center,
                                        children: [
                                          Text(
                                              total[0]
                                                  .toString(),
                                              style: TextStyle(
                                                color: achievement_bgcolor[
                                                0] !=
                                                    ''
                                                    ? HexColor(achievement_bgcolor[
                                                0])
                                                    .withOpacity(
                                                    1.0)
                                                    : Colors
                                                    .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(1.0) : Colors.white,//Color.fromRGBO(71, 169, 229, 1.0),
                                                fontWeight:
                                                FontWeight
                                                    .w600,
                                                fontSize: 28.0,
                                              )),
                                          Text(
                                              "${achievement_name[0]}"
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                color: Colors
                                                    .black,
                                                fontWeight:
                                                FontWeight
                                                    .w700,
                                                fontSize: 9.0,
                                              ))
                                        ],
                                      ),
                                    ),
                                  )
                                      : SizedBox()
                                ]),
                              )
                                  : Stack(children: [
                                Column(
                                  children: [
                                    Container(

                                        child:Column(
                                          children: [

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                    height: 40,
                                                    width: 30,
                                                    child: Image.asset(
                                                        'assets/images/home/numbers_purple_stars_L.png')),

                                                Padding(
                                                  padding: const EdgeInsets.only(top:30.0),
                                                  child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: first_char_level_amount_ach1 ==
                                                          '1'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/blue/1_blue.png')
                                                          : first_char_level_amount_ach1 ==
                                                          '2'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/blue/2_blue.png')
                                                          : first_char_level_amount_ach1 ==
                                                          '3'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/blue/3_blue.png')
                                                          : first_char_level_amount_ach1 == '4'
                                                          ? Image.asset('assets/images/home/numbers/blue/4_blue.png')
                                                          : first_char_level_amount_ach1 == '5'
                                                          ? Image.asset('assets/images/home/numbers/blue/5_blue.png')
                                                          : first_char_level_amount_ach1 == '6'
                                                          ? Image.asset('assets/images/home/numbers/blue/6_blue.png')
                                                          : first_char_level_amount_ach1 == '7'
                                                          ? Image.asset('assets/images/home/numbers/blue/7_blue.png')
                                                          : first_char_level_amount_ach1 == '8'
                                                          ? Image.asset('assets/images/home/numbers/blue/8_blue.png')
                                                          : first_char_level_amount_ach1 == '9'
                                                          ? Image.asset('assets/images/home/numbers/blue/9_blue.png')
                                                          : first_char_level_amount_ach1 == '0'
                                                          ? Image.asset('assets/images/home/numbers/blue/0_blue.png')
                                                          : SizedBox()),
                                                ),
                                                second_char_level_amount_ach1 != '' ?
                                                Padding(
                                                  padding: const EdgeInsets.only(top:30.0),
                                                  child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: second_char_level_amount_ach1 ==
                                                          '1'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/blue/1_blue.png')
                                                          : second_char_level_amount_ach1 ==
                                                          '2'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/blue/2_blue.png')
                                                          : second_char_level_amount_ach1 ==
                                                          '3'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/blue/3_blue.png')
                                                          : second_char_level_amount_ach1 == '4'
                                                          ? Image.asset('assets/images/home/numbers/blue/4_blue.png')
                                                          : second_char_level_amount_ach1 == '5'
                                                          ? Image.asset('assets/images/home/numbers/blue/5_blue.png')
                                                          : second_char_level_amount_ach1 == '6'
                                                          ? Image.asset('assets/images/home/numbers/blue/6_blue.png')
                                                          : second_char_level_amount_ach1 == '7'
                                                          ? Image.asset('assets/images/home/numbers/blue/7_blue.png')
                                                          : second_char_level_amount_ach1 == '8'
                                                          ? Image.asset('assets/images/home/numbers/blue/8_blue.png')
                                                          : second_char_level_amount_ach1 == '9'
                                                          ? Image.asset('assets/images/home/numbers/blue/9_blue.png')
                                                          : second_char_level_amount_ach1 == '0'
                                                          ? Image.asset('assets/images/home/numbers/blue/0_blue.png')
                                                          : SizedBox(width: 0)),
                                                ):
                                                SizedBox(width: 0),
                                                third_char_level_amount_ach1 != '' ?
                                                Padding(
                                                  padding: const EdgeInsets.only(top:30.0),
                                                  child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: third_char_level_amount_ach1 ==
                                                          '1'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/blue/1_blue.png')
                                                          : third_char_level_amount_ach1 ==
                                                          '2'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/blue/2_blue.png')
                                                          : third_char_level_amount_ach1 ==
                                                          '3'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/blue/3_blue.png')
                                                          : third_char_level_amount_ach1 == '4'
                                                          ? Image.asset('assets/images/home/numbers/blue/4_blue.png')
                                                          : third_char_level_amount_ach1 == '5'
                                                          ? Image.asset('assets/images/home/numbers/blue/5_blue.png')
                                                          : third_char_level_amount_ach1 == '6'
                                                          ? Image.asset('assets/images/home/numbers/blue/6_blue.png')
                                                          : third_char_level_amount_ach1 == '7'
                                                          ? Image.asset('assets/images/home/numbers/blue/7_blue.png')
                                                          : third_char_level_amount_ach1 == '8'
                                                          ? Image.asset('assets/images/home/numbers/blue/8_blue.png')
                                                          : third_char_level_amount_ach1 == '9'
                                                          ? Image.asset('assets/images/home/numbers/blue/9_blue.png')
                                                          : third_char_level_amount_ach1 == '0'
                                                          ? Image.asset('assets/images/home/numbers/blue/0_blue.png')
                                                          : SizedBox(width: 0)),
                                                ):
                                                SizedBox(width: 0),
                                                Container(
                                                    height: 40,
                                                    width: 30,
                                                    child: Image
                                                        .asset(
                                                        'assets/images/home/numbers_purple_stars_R.png'))
                                              ],
                                            )
                                          ],
                                        )
                                    ),


                                    Expanded(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            top: 5.0,
                                            right: 0.0,
                                            bottom: 45),
                                        child: Stack(children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(
                                                left: 10.0),
                                            child: RotatedBox(
                                              quarterTurns: -1,
                                              child:
                                              LinearPercentIndicator(
                                                width: 240.0,
                                                lineHeight: 24.0,
                                                barRadius: Radius
                                                    .circular(
                                                    10.0),
                                                percent:
                                                0 / 100,
                                                // backgroundColor: Color.fromRGBO(71, 169, 229, 0.1),
                                                // progressColor: Color.fromRGBO(71, 169, 229, 1.0),
                                                backgroundColor: achievement_bgcolor[
                                                0] !=
                                                    ''
                                                    ? HexColor(
                                                    achievement_bgcolor[
                                                    0])
                                                    .withOpacity(
                                                    0.1)
                                                    : Colors
                                                    .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(0.1) : Colors.white,//HexColor("b74093"),
                                                progressColor: achievement_bgcolor[
                                                0] !=
                                                    ''
                                                    ? HexColor(
                                                    achievement_bgcolor[
                                                    0])
                                                    .withOpacity(
                                                    1.0)
                                                    : Colors
                                                    .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(1.0) : Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(
                                                top: 10.0,
                                                left: 10.0),
                                            child: RotatedBox(
                                              quarterTurns: -1,
                                              child: Container(
                                                  width: 220.0,
                                                  height: 26,
                                                  decoration:
                                                  BoxDecoration(
                                                    border: Border.all(
                                                        width: 3,
                                                        color: Colors
                                                            .black),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        10.0),
                                                  )),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top:170.0),
                                            child: AnimatedContainer(
                                              //color: Colors.red,
                                              duration: Duration(
                                                  seconds: 2),
                                              height:
                                              current_ach1_plan_height, //430
                                              width: 40,
                                              child: Image.asset(
                                                  'assets/images/home/Kids_progressbar_blueicon.png'),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                                isShow1Achievement
                                    ? Positioned(
                                  left: 0, //35,
                                  bottom: 5,
                                  child: Container(
                                    width:second_char_level_amount_ach1 == '' && third_char_level_amount_ach1 == ''?95:third_char_level_amount_ach1 == ''?115:145,

                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .center,
                                      children: [
                                        Text(
                                            total[0]
                                                .toString(),
                                            style: TextStyle(
                                              color: achievement_bgcolor[
                                              0] !=
                                                  ''
                                                  ? HexColor(achievement_bgcolor[
                                              0])
                                                  .withOpacity(
                                                  1.0)
                                                  : Colors
                                                  .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(1.0) : Colors.white,//Color.fromRGBO(71, 169, 229, 1.0),
                                              fontWeight:
                                              FontWeight
                                                  .w600,
                                              fontSize: 28.0,
                                            )),
                                        Text(
                                            "${achievement_name[0]}"
                                                .toUpperCase(),
                                            style: TextStyle(
                                              color: Colors
                                                  .black,
                                              fontWeight:
                                              FontWeight
                                                  .w700,
                                              fontSize: 9.0,
                                            ))
                                      ],
                                    ),
                                  ),
                                )
                                    : SizedBox()
                              ])
                                  : SizedBox(),
                              inProgressAchievedLists.length >= 2
                                  ? isShow2Achievement
                                  ? Container(
                                height: 350,
                                child: Stack(children: [
                                  Column(
                                    children: [
                                      Container(

                                          child:Column(
                                            children: [

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      height: 40,
                                                      width: 30,
                                                      child: Image.asset(
                                                          'assets/images/home/numbers_green_stars_L.png')),

                                                  Padding(
                                                    padding: const EdgeInsets.only(top:30.0),
                                                    child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        child: first_char_level_amount_ach2 ==
                                                            '1'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/green/1_green.png')
                                                            : first_char_level_amount_ach2 ==
                                                            '2'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/green/2_green.png')
                                                            : first_char_level_amount_ach2 ==
                                                            '3'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/green/3_green.png')
                                                            : first_char_level_amount_ach2 == '4'
                                                            ? Image.asset('assets/images/home/numbers/green/4_green.png')
                                                            : first_char_level_amount_ach2 == '5'
                                                            ? Image.asset('assets/images/home/numbers/green/5_green.png')
                                                            : first_char_level_amount_ach2 == '6'
                                                            ? Image.asset('assets/images/home/numbers/green/6_green.png')
                                                            : first_char_level_amount_ach2 == '7'
                                                            ? Image.asset('assets/images/home/numbers/green/7_green.png')
                                                            : first_char_level_amount_ach2 == '8'
                                                            ? Image.asset('assets/images/home/numbers/green/8_green.png')
                                                            : first_char_level_amount_ach2 == '9'
                                                            ? Image.asset('assets/images/home/numbers/green/9_green.png')
                                                            : first_char_level_amount_ach2 == '0'
                                                            ? Image.asset('assets/images/home/numbers/green/0_green.png')
                                                            : SizedBox()),
                                                  ),
                                                  second_char_level_amount_ach2 != '' ?
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:30.0),
                                                    child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        child: second_char_level_amount_ach2 ==
                                                            '1'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/green/1_green.png')
                                                            : second_char_level_amount_ach2 ==
                                                            '2'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/green/2_green.png')
                                                            : second_char_level_amount_ach2 ==
                                                            '3'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/green/3_green.png')
                                                            : second_char_level_amount_ach2 == '4'
                                                            ? Image.asset('assets/images/home/numbers/green/4_green.png')
                                                            : second_char_level_amount_ach2 == '5'
                                                            ? Image.asset('assets/images/home/numbers/green/5_green.png')
                                                            : second_char_level_amount_ach2 == '6'
                                                            ? Image.asset('assets/images/home/numbers/green/6_green.png')
                                                            : second_char_level_amount_ach2 == '7'
                                                            ? Image.asset('assets/images/home/numbers/green/7_green.png')
                                                            : second_char_level_amount_ach2 == '8'
                                                            ? Image.asset('assets/images/home/numbers/green/8_green.png')
                                                            : second_char_level_amount_ach2 == '9'
                                                            ? Image.asset('assets/images/home/numbers/green/9_green.png')
                                                            : second_char_level_amount_ach2 == '0'
                                                            ? Image.asset('assets/images/home/numbers/green/0_green.png')
                                                            : SizedBox()),
                                                  ):
                                                  SizedBox(width: 0),
                                                  third_char_level_amount_ach2 != '' ?
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:30.0),
                                                    child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        child: third_char_level_amount_ach2 ==
                                                            '1'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/green/1_green.png')
                                                            : third_char_level_amount_ach2 ==
                                                            '2'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/green/2_green.png')
                                                            : third_char_level_amount_ach2 ==
                                                            '3'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/green/3_green.png')
                                                            : third_char_level_amount_ach2 == '4'
                                                            ? Image.asset('assets/images/home/numbers/green/4_green.png')
                                                            : third_char_level_amount_ach2 == '5'
                                                            ? Image.asset('assets/images/home/numbers/green/5_green.png')
                                                            : third_char_level_amount_ach2 == '6'
                                                            ? Image.asset('assets/images/home/numbers/green/6_green.png')
                                                            : third_char_level_amount_ach2 == '7'
                                                            ? Image.asset('assets/images/home/numbers/green/7_green.png')
                                                            : third_char_level_amount_ach2 == '8'
                                                            ? Image.asset('assets/images/home/numbers/green/8_green.png')
                                                            : third_char_level_amount_ach2 == '9'
                                                            ? Image.asset('assets/images/home/numbers/green/9_green.png')
                                                            : third_char_level_amount_ach2 == '0'
                                                            ? Image.asset('assets/images/home/numbers/green/0_green.png')
                                                            : SizedBox()),
                                                  ):
                                                  SizedBox(width: 0),
                                                  Container(
                                                      height: 40,
                                                      width: 30,
                                                      child: Image
                                                          .asset(
                                                          'assets/images/home/numbers_green_stars_R.png'))
                                                ],
                                              )
                                            ],
                                          )
                                      ),




                                   
                                      Expanded(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              top: 5.0,
                                              right: 0.0,
                                              bottom: 45),
                                          child: Stack(children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  left: 10.0),
                                              child: RotatedBox(
                                                quarterTurns: -1,
                                                child:
                                                LinearPercentIndicator(
                                                  width: 240.0,
                                                  lineHeight: 24.0,
                                                  barRadius: Radius
                                                      .circular(
                                                      10.0),
                                                  percent:
                                                  total[1]*avgAmount[1] /
                                                      100,
                                                  // backgroundColor: Color.fromRGBO(71, 169, 229, 0.1),
                                                  // progressColor: Color.fromRGBO(71, 169, 229, 1.0),
                                                  backgroundColor: achievement_bgcolor[
                                                  1] !=
                                                      ''
                                                      ? HexColor(
                                                      achievement_bgcolor[
                                                      1])
                                                      .withOpacity(
                                                      0.1)
                                                      : Colors
                                                      .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(0.1) : Colors.white,//HexColor("b74093"),
                                                  progressColor: achievement_bgcolor[
                                                  1] !=
                                                      ''
                                                      ? HexColor(
                                                      achievement_bgcolor[
                                                      1])
                                                      .withOpacity(
                                                      1.0)
                                                      : Colors
                                                      .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(1.0) : Colors.white,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  top: 10.0,
                                                  left: 10.0),
                                              child: RotatedBox(
                                                quarterTurns: -1,
                                                child: Container(
                                                    width: 220.0,
                                                    height: 26,
                                                    decoration:
                                                    BoxDecoration(
                                                      border: Border.all(
                                                          width: 3,
                                                          color: Colors
                                                              .black),
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          10.0),
                                                    )),
                                              ),
                                            ),
                                            Padding(
                                              padding: total[1]*avgAmount[1] >=
                                                  0 &&
                                                  total[1]*avgAmount[1] <= 50
                                                  ? EdgeInsets.only(
                                                left: 3.0,
                                                top: total[1]*avgAmount[1] >=
                                                    0 &&
                                                    total[1]*avgAmount[1] <=
                                                        20
                                                    ? 190
                                                    : total[1]*avgAmount[1] > 20 &&
                                                    total[1]*avgAmount[1] <= 30
                                                    ? 120
                                                    : total[1]*avgAmount[1] > 30 && total[1]*avgAmount[1] <= 40
                                                    ? 80
                                                    : total[1]*avgAmount[1] > 40 && total[1]*avgAmount[1] <= 50
                                                    ? 10
                                                    : 0,
                                              )
                                                  : EdgeInsets.only(
                                                left: 3.0,
                                                bottom: total[1]*avgAmount[1] >
                                                    50 &&
                                                    total[1]*avgAmount[1] <=
                                                        60
                                                    ? 10
                                                    : total[1]*avgAmount[1] > 60 &&
                                                    total[1]*avgAmount[1] <= 70
                                                    ? 60
                                                    : total[1]*avgAmount[1] > 70 && total[1]*avgAmount[1] <= 80
                                                    ? 100
                                                    : total[1]*avgAmount[1] > 80 && total[1]*avgAmount[1] <= 90
                                                    ? 150
                                                    : 170,
                                              ),
                                              child:
                                              AnimatedContainer(
                                                //color: Colors.red,
                                                duration: Duration(
                                                    seconds: 2),
                                                height:
                                                current_ach2_plan_height, //430
                                                width: 40,
                                                child: Image.asset(
                                                    'assets/images/home/Kids_progressbar_greenicon.png'),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  isShow2Achievement
                                      ? Positioned(
                                    left: 0,
                                    bottom: 5,
                                    child: Container(
                                      width:second_char_level_amount_ach2 == '' && third_char_level_amount_ach2 == ''?95:third_char_level_amount_ach2 == ''?115:145,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              total[1]
                                                  .toString(),
                                              style: TextStyle(
                                                color: achievement_bgcolor[
                                                1] !=
                                                    ''
                                                    ? HexColor(achievement_bgcolor[
                                                1])
                                                    .withOpacity(
                                                    1.0)
                                                    : Colors
                                                    .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(1.0) : Colors.white,//Color.fromRGBO(71, 169, 229, 1.0),
                                                fontWeight:
                                                FontWeight
                                                    .w600,
                                                fontSize: 28.0,
                                              )),
                                          Text(
                                              "${achievement_name[1]}"
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                color: Colors
                                                    .black,
                                                fontWeight:
                                                FontWeight
                                                    .w700,
                                                fontSize: 9.0,
                                              ))
                                        ],
                                      ),
                                    ),
                                  )
                                      : SizedBox()
                                ]),
                              )
                                  : Stack(children: [
                                Column(
                                  children: [
                                    Container(

                                        child:Column(
                                          children: [

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                    height: 40,
                                                    width: 30,
                                                    child: Image.asset(
                                                        'assets/images/home/numbers_green_stars_L.png')),

                                                Padding(
                                                  padding: const EdgeInsets.only(top:30.0),
                                                  child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: first_char_level_amount_ach2 ==
                                                          '1'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/green/1_green.png')
                                                          : first_char_level_amount_ach2 ==
                                                          '2'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/green/2_green.png')
                                                          : first_char_level_amount_ach2 ==
                                                          '3'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/green/3_green.png')
                                                          : first_char_level_amount_ach2 == '4'
                                                          ? Image.asset('assets/images/home/numbers/green/4_green.png')
                                                          : first_char_level_amount_ach2 == '5'
                                                          ? Image.asset('assets/images/home/numbers/green/5_green.png')
                                                          : first_char_level_amount_ach2 == '6'
                                                          ? Image.asset('assets/images/home/numbers/green/6_green.png')
                                                          : first_char_level_amount_ach2 == '7'
                                                          ? Image.asset('assets/images/home/numbers/green/7_green.png')
                                                          : first_char_level_amount_ach2 == '8'
                                                          ? Image.asset('assets/images/home/numbers/green/8_green.png')
                                                          : first_char_level_amount_ach2 == '9'
                                                          ? Image.asset('assets/images/home/numbers/green/9_green.png')
                                                          : first_char_level_amount_ach2 == '0'
                                                          ? Image.asset('assets/images/home/numbers/green/0_green.png')
                                                          : SizedBox()),
                                                ),
                                                second_char_level_amount_ach2 != '' ?
                                                Padding(
                                                  padding: const EdgeInsets.only(top:30.0),
                                                  child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: second_char_level_amount_ach2 ==
                                                          '1'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/green/1_green.png')
                                                          : second_char_level_amount_ach2 ==
                                                          '2'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/green/2_green.png')
                                                          : second_char_level_amount_ach2 ==
                                                          '3'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/green/3_green.png')
                                                          : second_char_level_amount_ach2 == '4'
                                                          ? Image.asset('assets/images/home/numbers/green/4_green.png')
                                                          : second_char_level_amount_ach2 == '5'
                                                          ? Image.asset('assets/images/home/numbers/green/5_green.png')
                                                          : second_char_level_amount_ach2 == '6'
                                                          ? Image.asset('assets/images/home/numbers/green/6_green.png')
                                                          : second_char_level_amount_ach2 == '7'
                                                          ? Image.asset('assets/images/home/numbers/green/7_green.png')
                                                          : second_char_level_amount_ach2 == '8'
                                                          ? Image.asset('assets/images/home/numbers/green/8_green.png')
                                                          : second_char_level_amount_ach2 == '9'
                                                          ? Image.asset('assets/images/home/numbers/green/9_green.png')
                                                          : second_char_level_amount_ach2 == '0'
                                                          ? Image.asset('assets/images/home/numbers/green/0_green.png')
                                                          : SizedBox()),
                                                ):
                                                SizedBox(width: 0),
                                                third_char_level_amount_ach2 != '' ?
                                                Padding(
                                                  padding: const EdgeInsets.only(top:30.0),
                                                  child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: third_char_level_amount_ach2 ==
                                                          '1'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/green/1_green.png')
                                                          : third_char_level_amount_ach2 ==
                                                          '2'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/green/2_green.png')
                                                          : third_char_level_amount_ach2 ==
                                                          '3'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/green/3_green.png')
                                                          : third_char_level_amount_ach2 == '4'
                                                          ? Image.asset('assets/images/home/numbers/green/4_green.png')
                                                          : third_char_level_amount_ach2 == '5'
                                                          ? Image.asset('assets/images/home/numbers/green/5_green.png')
                                                          : third_char_level_amount_ach2 == '6'
                                                          ? Image.asset('assets/images/home/numbers/green/6_green.png')
                                                          : third_char_level_amount_ach2 == '7'
                                                          ? Image.asset('assets/images/home/numbers/green/7_green.png')
                                                          : third_char_level_amount_ach2 == '8'
                                                          ? Image.asset('assets/images/home/numbers/green/8_green.png')
                                                          : third_char_level_amount_ach2 == '9'
                                                          ? Image.asset('assets/images/home/numbers/green/9_green.png')
                                                          : third_char_level_amount_ach2 == '0'
                                                          ? Image.asset('assets/images/home/numbers/green/0_green.png')
                                                          : SizedBox()),
                                                ):
                                                SizedBox(width: 0),
                                                Container(
                                                    height: 40,
                                                    width: 30,
                                                    child: Image
                                                        .asset(
                                                        'assets/images/home/numbers_green_stars_R.png'))
                                              ],
                                            )
                                          ],
                                        )
                                    ),




                                  
                                    Expanded(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            top: 5.0,
                                            right: 0.0,
                                            bottom: 45),
                                        child: Stack(children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(
                                                left: 10.0),
                                            child: RotatedBox(
                                              quarterTurns: -1,
                                              child:
                                              LinearPercentIndicator(
                                                width: 240.0,
                                                lineHeight: 24.0,
                                                barRadius: Radius
                                                    .circular(
                                                    10.0),
                                                percent:
                                                0 /
                                                    100,
                                                // backgroundColor: Color.fromRGBO(71, 169, 229, 0.1),
                                                // progressColor: Color.fromRGBO(71, 169, 229, 1.0),
                                                backgroundColor: achievement_bgcolor[
                                                1] !=
                                                    ''
                                                    ? HexColor(
                                                    achievement_bgcolor[
                                                    1])
                                                    .withOpacity(
                                                    0.1)
                                                    : Colors
                                                    .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(0.1) : Colors.white,//HexColor("b74093"),
                                                progressColor: achievement_bgcolor[
                                                1] !=
                                                    ''
                                                    ? HexColor(
                                                    achievement_bgcolor[
                                                    1])
                                                    .withOpacity(
                                                    1.0)
                                                    : Colors
                                                    .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(1.0) : Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(
                                                top: 10.0,
                                                left: 10.0),
                                            child: RotatedBox(
                                              quarterTurns: -1,
                                              child: Container(
                                                  width: 220.0,
                                                  height: 26,
                                                  decoration:
                                                  BoxDecoration(
                                                    border: Border.all(
                                                        width: 3,
                                                        color: Colors
                                                            .black),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        10.0),
                                                  )),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 190),

                                            child:
                                            AnimatedContainer(
                                              //color: Colors.red,
                                              duration: Duration(
                                                  seconds: 2),
                                              height:
                                              current_ach2_plan_height, //430
                                              width: 40,
                                              child: Image.asset(
                                                  'assets/images/home/Kids_progressbar_greenicon.png'),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                                isShow2Achievement
                                    ? Positioned(
                                  left: 0,
                                  bottom: 5,
                                  child: Container(
                                    width:second_char_level_amount_ach2 == '' && third_char_level_amount_ach2 == ''?95:third_char_level_amount_ach2 == ''?115:145,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                            total[1]
                                                .toString(),
                                            style: TextStyle(
                                              color: achievement_bgcolor[
                                              1] !=
                                                  ''
                                                  ? HexColor(achievement_bgcolor[
                                              1])
                                                  .withOpacity(
                                                  1.0)
                                                  : Colors
                                                  .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(1.0) : Colors.white,//Color.fromRGBO(71, 169, 229, 1.0),
                                              fontWeight:
                                              FontWeight
                                                  .w600,
                                              fontSize: 28.0,
                                            )),
                                        Text(
                                            "${achievement_name[1]}"
                                                .toUpperCase(),
                                            style: TextStyle(
                                              color: Colors
                                                  .black,
                                              fontWeight:
                                              FontWeight
                                                  .w700,
                                              fontSize: 9.0,
                                            ))
                                      ],
                                    ),
                                  ),
                                )
                                    : SizedBox()
                              ])
                                  : SizedBox(),
                              inProgressAchievedLists.length == 3
                                  ? isShow3Achievement
                                  ? Container(
                                height: 350,
                                child: Stack(children: [
                                  Column(
                                    children: [

                                      Container(

                                          child:Column(
                                            children: [

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      height: 40,
                                                      width: 30,
                                                      child: Image.asset(
                                                          'assets/images/home/numbers_yellow_stars_L.png')),

                                                  Padding(
                                                    padding: const EdgeInsets.only(top:30.0),
                                                    child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        child: first_char_level_amount_ach3 ==
                                                            '1'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/red/1_red.png')
                                                            : first_char_level_amount_ach3 ==
                                                            '2'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/red/2_red.png')
                                                            : first_char_level_amount_ach3 ==
                                                            '3'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/red/3_red.png')
                                                            : first_char_level_amount_ach3 == '4'
                                                            ? Image.asset('assets/images/home/numbers/red/4_red.png')
                                                            : first_char_level_amount_ach3 == '5'
                                                            ? Image.asset('assets/images/home/numbers/red/5_red.png')
                                                            : first_char_level_amount_ach3 == '6'
                                                            ? Image.asset('assets/images/home/numbers/red/6_red.png')
                                                            : first_char_level_amount_ach3 == '7'
                                                            ? Image.asset('assets/images/home/numbers/red/7_red.png')
                                                            : first_char_level_amount_ach3 == '8'
                                                            ? Image.asset('assets/images/home/numbers/red/8_red.png')
                                                            : first_char_level_amount_ach3 == '9'
                                                            ? Image.asset('assets/images/home/numbers/red/9_red.png')
                                                            : first_char_level_amount_ach3 == '0'
                                                            ? Image.asset('assets/images/home/numbers/red/0_red.png')
                                                            : SizedBox()),
                                                  ),
                                                  second_char_level_amount_ach3 != '' ?
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:30.0),
                                                    child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        child: second_char_level_amount_ach3 ==
                                                            '1'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/red/1_red.png')
                                                            : second_char_level_amount_ach3 ==
                                                            '2'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/red/2_red.png')
                                                            : second_char_level_amount_ach3 ==
                                                            '3'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/red/3_red.png')
                                                            : second_char_level_amount_ach3 == '4'
                                                            ? Image.asset('assets/images/home/numbers/red/4_red.png')
                                                            : second_char_level_amount_ach3 == '5'
                                                            ? Image.asset('assets/images/home/numbers/red/5_red.png')
                                                            : second_char_level_amount_ach3 == '6'
                                                            ? Image.asset('assets/images/home/numbers/red/6_red.png')
                                                            : second_char_level_amount_ach3 == '7'
                                                            ? Image.asset('assets/images/home/numbers/red/7_red.png')
                                                            : second_char_level_amount_ach3 == '8'
                                                            ? Image.asset('assets/images/home/numbers/red/8_red.png')
                                                            : second_char_level_amount_ach3 == '9'
                                                            ? Image.asset('assets/images/home/numbers/red/9_red.png')
                                                            : second_char_level_amount_ach3 == '0'
                                                            ? Image.asset('assets/images/home/numbers/red/0_red.png')
                                                            : SizedBox()),
                                                  ):
                                                  SizedBox(width: 0),

                                                  third_char_level_amount_ach3 != '' ?
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:30.0),
                                                    child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        child: third_char_level_amount_ach3 ==
                                                            '1'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/red/1_red.png')
                                                            : third_char_level_amount_ach3 ==
                                                            '2'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/red/2_red.png')
                                                            : third_char_level_amount_ach3 ==
                                                            '3'
                                                            ? Image.asset(
                                                            'assets/images/home/numbers/red/3_red.png')
                                                            : third_char_level_amount_ach3 == '4'
                                                            ? Image.asset('assets/images/home/numbers/red/4_red.png')
                                                            : third_char_level_amount_ach3 == '5'
                                                            ? Image.asset('assets/images/home/numbers/red/5_red.png')
                                                            : third_char_level_amount_ach3 == '6'
                                                            ? Image.asset('assets/images/home/numbers/red/6_red.png')
                                                            : third_char_level_amount_ach3 == '7'
                                                            ? Image.asset('assets/images/home/numbers/red/7_red.png')
                                                            : third_char_level_amount_ach3 == '8'
                                                            ? Image.asset('assets/images/home/numbers/red/8_red.png')
                                                            : third_char_level_amount_ach3 == '9'
                                                            ? Image.asset('assets/images/home/numbers/red/9_red.png')
                                                            : third_char_level_amount_ach3 == '0'
                                                            ? Image.asset('assets/images/home/numbers/red/0_red.png')
                                                            : SizedBox()),
                                                  ):
                                                  SizedBox(width: 0),
                                                  Container(
                                                      height: 40,
                                                      width: 30,
                                                      child: Image
                                                          .asset(
                                                          'assets/images/home/numbers_yellow_stars_R.png'))
                                                ],
                                              )
                                            ],
                                          )
                                      ),




                                      Expanded(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              top: 5.0,
                                              right: 0.0,
                                              bottom: 45),
                                          child: Stack(children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  left: 0.0),
                                              child: RotatedBox(
                                                quarterTurns: -1,
                                                child:
                                                LinearPercentIndicator(
                                                  width: 240.0,
                                                  lineHeight: 24.0,
                                                  barRadius: Radius
                                                      .circular(
                                                      10.0),
                                                  percent:
                                                  total[2]*avgAmount[2] /
                                                      100,
                                                  // backgroundColor: Color.fromRGBO(71, 169, 229, 0.1),
                                                  // progressColor: Color.fromRGBO(71, 169, 229, 1.0),
                                                  backgroundColor: achievement_bgcolor[
                                                  2] !=
                                                      ''
                                                      ? HexColor(
                                                      achievement_bgcolor[
                                                      2])
                                                      .withOpacity(
                                                      0.1)
                                                      : Colors
                                                      .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(0.1) : Colors.white,//HexColor("b74093"),
                                                  progressColor: achievement_bgcolor[
                                                  2] !=
                                                      ''
                                                      ? HexColor(
                                                      achievement_bgcolor[
                                                      2])
                                                      .withOpacity(
                                                      1.0)
                                                      : Colors
                                                      .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(1.0) : Colors.white,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  top: 10.0,
                                                  left: 0.0),
                                              child: RotatedBox(
                                                quarterTurns: -1,
                                                child: Container(
                                                    width: 220.0,
                                                    height: 26,
                                                    decoration:
                                                    BoxDecoration(
                                                      border: Border.all(
                                                          width: 3,
                                                          color: Colors
                                                              .black),
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          10.0),
                                                    )),
                                              ),
                                            ),
                                            Padding(
                                              padding: total[2]*avgAmount[2] >=
                                                  0 &&
                                                  total[2]*avgAmount[2] <= 50
                                                  ? EdgeInsets.only(
                                                left: 0.0,
                                                top: total[2]*avgAmount[2] >=
                                                    0 &&
                                                    total[2]*avgAmount[2] <=
                                                        20
                                                    ? 170
                                                    : total[2]*avgAmount[2] > 20 &&
                                                    total[2]*avgAmount[2] <= 30
                                                    ? 120
                                                    : total[2]*avgAmount[2] > 30 && total[2]*avgAmount[2] <= 40
                                                    ? 80
                                                    : total[2]*avgAmount[2] > 40 && total[2]*avgAmount[2] <= 50
                                                    ? 10
                                                    : 0,
                                              )
                                                  : EdgeInsets.only(
                                                left: 0.0,
                                                bottom: total[2]*avgAmount[2] >
                                                    50 &&
                                                    total[2]*avgAmount[2] <=
                                                        60
                                                    ? 10
                                                    : total[2]*avgAmount[2] > 60 &&
                                                    total[2]*avgAmount[2] <= 70
                                                    ? 60
                                                    : total[2]*avgAmount[2] > 70 && total[2]*avgAmount[2] <= 80
                                                    ? 100
                                                    : total[2]*avgAmount[2] > 80 && total[2]*avgAmount[2] <= 90
                                                    ? 150
                                                    : 170,
                                              ),
                                              child:
                                              AnimatedContainer(
                                                //color: Colors.red,
                                                duration: Duration(
                                                    seconds: 2),
                                                height:
                                                current_ach3_plan_height, //430
                                                width: 30,
                                                child: Image.asset(
                                                    'assets/images/home/Kids_progressbar_redicon.png'),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  isShow3Achievement
                                      ? Positioned(
                                    //left: 15,
                                    bottom: 5,
                                    right: 0,

                                    child: Container(
                                      width:second_char_level_amount_ach3 == '' && third_char_level_amount_ach3 == ''?105:third_char_level_amount_ach3 == ''?125:155,

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,

                                        children: [
                                          Text(
                                              total[2]
                                                  .toString(),
                                              style: TextStyle(
                                                color: achievement_bgcolor[
                                                2] !=
                                                    ''
                                                    ? HexColor(achievement_bgcolor[
                                                2])
                                                    .withOpacity(
                                                    1.0)
                                                    : Colors
                                                    .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(1.0) : Colors.white,//Color.fromRGBO(71, 169, 229, 1.0),
                                                fontWeight:
                                                FontWeight
                                                    .w600,
                                                fontSize: 28.0,
                                              )),
                                          Text(
                                              "${achievement_name[2]}"
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                color: Colors
                                                    .black,
                                                fontWeight:
                                                FontWeight
                                                    .w700,
                                                fontSize: 9.0,
                                              ))
                                        ],
                                      ),
                                    ),
                                  )
                                      : SizedBox()
                                ]),
                              )
                                  : Stack(children: [
                                Column(
                                  children: [

                                    Container(

                                        child:Column(
                                          children: [

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                    height: 40,
                                                    width: 30,
                                                    child: Image.asset(
                                                        'assets/images/home/numbers_yellow_stars_L.png')),

                                                Padding(
                                                  padding: const EdgeInsets.only(top:30.0),
                                                  child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: first_char_level_amount_ach3 ==
                                                          '1'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/red/1_red.png')
                                                          : first_char_level_amount_ach3 ==
                                                          '2'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/red/2_red.png')
                                                          : first_char_level_amount_ach3 ==
                                                          '3'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/red/3_red.png')
                                                          : first_char_level_amount_ach3 == '4'
                                                          ? Image.asset('assets/images/home/numbers/red/4_red.png')
                                                          : first_char_level_amount_ach3 == '5'
                                                          ? Image.asset('assets/images/home/numbers/red/5_red.png')
                                                          : first_char_level_amount_ach3 == '6'
                                                          ? Image.asset('assets/images/home/numbers/red/6_red.png')
                                                          : first_char_level_amount_ach3 == '7'
                                                          ? Image.asset('assets/images/home/numbers/red/7_red.png')
                                                          : first_char_level_amount_ach3 == '8'
                                                          ? Image.asset('assets/images/home/numbers/red/8_red.png')
                                                          : first_char_level_amount_ach3 == '9'
                                                          ? Image.asset('assets/images/home/numbers/red/9_red.png')
                                                          : first_char_level_amount_ach3 == '0'
                                                          ? Image.asset('assets/images/home/numbers/red/0_red.png')
                                                          : SizedBox()),
                                                ),
                                                second_char_level_amount_ach3 != '' ?
                                                Padding(
                                                  padding: const EdgeInsets.only(top:30.0),
                                                  child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: second_char_level_amount_ach3 ==
                                                          '1'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/red/1_red.png')
                                                          : second_char_level_amount_ach3 ==
                                                          '2'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/red/2_red.png')
                                                          : second_char_level_amount_ach3 ==
                                                          '3'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/red/3_red.png')
                                                          : second_char_level_amount_ach3 == '4'
                                                          ? Image.asset('assets/images/home/numbers/red/4_red.png')
                                                          : second_char_level_amount_ach3 == '5'
                                                          ? Image.asset('assets/images/home/numbers/red/5_red.png')
                                                          : second_char_level_amount_ach3 == '6'
                                                          ? Image.asset('assets/images/home/numbers/red/6_red.png')
                                                          : second_char_level_amount_ach3 == '7'
                                                          ? Image.asset('assets/images/home/numbers/red/7_red.png')
                                                          : second_char_level_amount_ach3 == '8'
                                                          ? Image.asset('assets/images/home/numbers/red/8_red.png')
                                                          : second_char_level_amount_ach3 == '9'
                                                          ? Image.asset('assets/images/home/numbers/red/9_red.png')
                                                          : second_char_level_amount_ach3 == '0'
                                                          ? Image.asset('assets/images/home/numbers/red/0_red.png')
                                                          : SizedBox()),
                                                ):
                                                SizedBox(width: 0),

                                                third_char_level_amount_ach3 != '' ?
                                                Padding(
                                                  padding: const EdgeInsets.only(top:30.0),
                                                  child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: third_char_level_amount_ach3 ==
                                                          '1'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/red/1_red.png')
                                                          : third_char_level_amount_ach3 ==
                                                          '2'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/red/2_red.png')
                                                          : third_char_level_amount_ach3 ==
                                                          '3'
                                                          ? Image.asset(
                                                          'assets/images/home/numbers/red/3_red.png')
                                                          : third_char_level_amount_ach3 == '4'
                                                          ? Image.asset('assets/images/home/numbers/red/4_red.png')
                                                          : third_char_level_amount_ach3 == '5'
                                                          ? Image.asset('assets/images/home/numbers/red/5_red.png')
                                                          : third_char_level_amount_ach3 == '6'
                                                          ? Image.asset('assets/images/home/numbers/red/6_red.png')
                                                          : third_char_level_amount_ach3 == '7'
                                                          ? Image.asset('assets/images/home/numbers/red/7_red.png')
                                                          : third_char_level_amount_ach3 == '8'
                                                          ? Image.asset('assets/images/home/numbers/red/8_red.png')
                                                          : third_char_level_amount_ach3 == '9'
                                                          ? Image.asset('assets/images/home/numbers/red/9_red.png')
                                                          : third_char_level_amount_ach3 == '0'
                                                          ? Image.asset('assets/images/home/numbers/red/0_red.png')
                                                          : SizedBox()),
                                                ):
                                                SizedBox(width: 0),
                                                Container(
                                                    height: 40,
                                                    width: 30,
                                                    child: Image
                                                        .asset(
                                                        'assets/images/home/numbers_yellow_stars_R.png'))
                                              ],
                                            )
                                          ],
                                        )
                                    ),




                                    Expanded(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            top: 5.0,
                                            right: 0.0,
                                            bottom: 45),
                                        child: Stack(children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(
                                                left: 0.0),
                                            child: RotatedBox(
                                              quarterTurns: -1,
                                              child:
                                              LinearPercentIndicator(
                                                width: 240.0,
                                                lineHeight: 24.0,
                                                barRadius: Radius
                                                    .circular(
                                                    10.0),
                                                percent:
                                                0 /
                                                    100,
                                                // backgroundColor: Color.fromRGBO(71, 169, 229, 0.1),
                                                // progressColor: Color.fromRGBO(71, 169, 229, 1.0),
                                                backgroundColor: achievement_bgcolor[
                                                2] !=
                                                    ''
                                                    ? HexColor(
                                                    achievement_bgcolor[
                                                    2])
                                                    .withOpacity(
                                                    0.1)
                                                    : Colors
                                                    .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(0.1) : Colors.white,//HexColor("b74093"),
                                                progressColor: achievement_bgcolor[
                                                2] !=
                                                    ''
                                                    ? HexColor(
                                                    achievement_bgcolor[
                                                    2])
                                                    .withOpacity(
                                                    1.0)
                                                    : Colors
                                                    .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(1.0) : Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(
                                                top: 10.0,
                                                left: 0.0),
                                            child: RotatedBox(
                                              quarterTurns: -1,
                                              child: Container(
                                                  width: 220.0,
                                                  height: 26,
                                                  decoration:
                                                  BoxDecoration(
                                                    border: Border.all(
                                                        width: 3,
                                                        color: Colors
                                                            .black),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        10.0),
                                                  )),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 170,
                                            ),

                                            child:
                                            AnimatedContainer(
                                              //color: Colors.red,
                                              duration: Duration(
                                                  seconds: 2),
                                              height:
                                              current_ach3_plan_height, //430
                                              width: 30,
                                              child: Image.asset(
                                                  'assets/images/home/Kids_progressbar_redicon.png'),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                                isShow3Achievement
                                    ? Positioned(
                                  //left: 15,
                                  bottom: 5,
                                  right: 0,

                                  child: Container(
                                    width:second_char_level_amount_ach3 == '' && third_char_level_amount_ach3 == ''?105:third_char_level_amount_ach3 == ''?125:155,

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: [
                                        Text(
                                            total[2]
                                                .toString(),
                                            style: TextStyle(
                                              color: achievement_bgcolor[
                                              2] !=
                                                  ''
                                                  ? HexColor(achievement_bgcolor[
                                              2])
                                                  .withOpacity(
                                                  1.0)
                                                  : Colors
                                                  .white, //achievmentLists.isNotEmpty ? HexColor(achievmentLists[0]['color']!).withOpacity(1.0) : Colors.white,//Color.fromRGBO(71, 169, 229, 1.0),
                                              fontWeight:
                                              FontWeight
                                                  .w600,
                                              fontSize: 28.0,
                                            )),
                                        Text(
                                            "${achievement_name[2]}"
                                                .toUpperCase(),
                                            style: TextStyle(
                                              color: Colors
                                                  .black,
                                              fontWeight:
                                              FontWeight
                                                  .w700,
                                              fontSize: 9.0,
                                            ))
                                      ],
                                    ),
                                  ),
                                )
                                    : SizedBox()
                              ])
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
      }),
    )),
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
                          right: 150.0, top: 10.0, left: 10.0),
                      child: GridView.builder(
                        itemCount: earnAchievedLists.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
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
                          achievementProfileUrl != ''
                              ? Container(
                                  height: 160,
                                  width: 150,
                                  child: CachedNetworkImage(
                                      imageUrl: achievementProfileUrl,
                                      fit: BoxFit.fitHeight,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator()),
                                )
                              : SizedBox(),
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
                      padding: const EdgeInsets.only(right: 120.0, left: 10.0),
                      child: GridView.builder(
                        itemCount: favBooksLists.length <= 9
                            ? favBooksLists.length
                            : 9,
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
                                             fit: BoxFit.fill,
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
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AuthenticationHelper().signOut();
        },
      ),);
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
