import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
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
                          border: Border.all(width: 5, color: Colors.black)),
                      child: Image.asset('assets/images/home/cat_wave.png'),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: Stack(children: [
                Container(
                  // height: 30,
                  // width: 30,
                  child: Image.asset(
                      'assets/images/home/achievements_textbox.png'),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 100,
                  top: 2,
                  child: Column(
                    children: [
                      Text("Intermediate",
                          style: TextStyle(
                            color: Color.fromRGBO(71, 169, 229, 1.0),
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
                )
              ]),
            ),
            Container(
              height: 100,
              width: 100,
              child: Image.asset(
                  'assets/images/home/home_readinglevel_1_icon.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              height: 30,
                              width: 30,
                              child: Image.asset(
                                  'assets/images/home/numbers/blue/5_blue.png')),
                          Container(
                              height: 30,
                              width: 30,
                              child: Image.asset(
                                  'assets/images/home/numbers/blue/0_blue.png')),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: RotatedBox(
                          quarterTurns: -1,
                          child: LinearPercentIndicator(
                            width: 240.0,
                            lineHeight: 24.0,
                            barRadius: Radius.circular(10.0),
                            percent: 0.5,
                            backgroundColor: Color.fromRGBO(71, 169, 229, 0.1),
                            progressColor: Color.fromRGBO(71, 169, 229, 1.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                        child: Column(
                          children: [
                            Text("00",
                                style: TextStyle(
                                  color: Color.fromRGBO(71, 169, 229, 1.0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 28.0,
                                )),
                            Text("Books Read!".toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.0,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              height: 30,
                              width: 30,
                              child: Image.asset(
                                  'assets/images/home/numbers/green/7_green.png')),
                          Container(
                              height: 30,
                              width: 30,
                              child: Image.asset(
                                  'assets/images/home/numbers/green/5_green.png')),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: RotatedBox(
                          quarterTurns: -1,
                          child: LinearPercentIndicator(
                            width: 240.0,
                            lineHeight: 24.0,
                            barRadius: Radius.circular(10.0),
                            percent: 0.75,
                            backgroundColor: Color.fromRGBO(121, 205, 31, 0.1),
                            progressColor: Color.fromRGBO(121, 205, 31, 1.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                        child: Column(
                          children: [
                            Text("00",
                                style: TextStyle(
                                  color: Color.fromRGBO(121, 205, 31, 1.0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 28.0,
                                )),
                            Text("Problem Solved!".toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.0,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              height: 30,
                              width: 30,
                              child: Image.asset(
                                  'assets/images/home/numbers/red/9_red.png')),
                          Container(
                              height: 30,
                              width: 30,
                              child: Image.asset(
                                  'assets/images/home/numbers/red/5_red.png')),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: RotatedBox(
                          quarterTurns: -1,
                          child: LinearPercentIndicator(
                            width: 240.0,
                            lineHeight: 24.0,
                            barRadius: Radius.circular(10.0),
                            percent: 0.95,
                            backgroundColor: Color.fromRGBO(242, 25, 43, 0.1),
                            progressColor: Color.fromRGBO(242, 25, 43, 1.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                        child: Column(
                          children: [
                            Text("00",
                                style: TextStyle(
                                  color: Color.fromRGBO(242, 25, 43, 1.0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 28.0,
                                )),
                            Text("Day Streak!".toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.0,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ],
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
                            fontSize: 20.0,
                          )),
                      Text("Look at all your achievements!",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ))
                    ],
                  ),
                )
              ]),
            ),
            Stack(children: [
              Padding(
                padding: const EdgeInsets.only(right: 100.0),
                child: GridView.builder(
                  itemCount: 12,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
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
                                height: 100,
                                width: 100,
                                // child: CachedNetworkImage(
                                //     imageUrl: bookLists[index]['cover_url'],
                                //     fit: BoxFit.fill,
                                //     placeholder: (context, url) => Transform.scale(
                                //       scale: 0.5,
                                //       child: CircularProgressIndicator(
                                //         color: Color.fromRGBO(216, 209, 231, 1.0),
                                //       ),
                                //     )
                                //   //  Image.asset('assets/images/profile.png'),
                                //   // child: Image.network(
                                //   //     mainCategoryData[index]
                                //   //         ['catimage1url']),
                                // ),
                                child: index == 0
                                    ? Image.asset(
                                        'assets/images/home/achievement/award_achievement_1star.png')
                                    : index == 1
                                        ? Image.asset(
                                            'assets/images/home/achievement/book_achievement_3star.png')
                                        : index == 2
                                            ? Image.asset(
                                                'assets/images/home/achievement/bullseye_achievement_2star.png')
                                            : index == 3
                                                ? Image.asset(
                                                    'assets/images/home/achievement/crown_achievement_1star.png')
                                                : index == 4
                                                    ? Image.asset(
                                                        'assets/images/home/achievement/explore_achievement_3star.png')
                                                    : index == 5
                                                        ? Image.asset(
                                                            'assets/images/home/achievement/fire_achievement_1star.png')
                                                        : index == 6
                                                            ? Image.asset(
                                                                'assets/images/home/achievement/levelup_achievement_2star.png')
                                                            : index == 7
                                                                ? Image.asset(
                                                                    'assets/images/home/achievement/pencil_achievement_3star.png')
                                                                : index == 8
                                                                    ? Image.asset(
                                                                        'assets/images/home/achievement/smile_achievement_3star.png')
                                                                    : index == 9
                                                                        ? Image.asset(
                                                                            'assets/images/home/achievement/thumbsup_achievement_2star.png')
                                                                        : index ==
                                                                                10
                                                                            ? Image.asset('assets/images/home/achievement/thunder_achievement_1star.png')
                                                                            : Image.asset('assets/images/home/achievement/ticket_achievement_3star.png'),
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
                      height: 150,
                      width: 90,

                      child: Image.asset('assets/images/home/cat_wave.png'),
                    ),
                  ],
                ),
              )
            ])
          ],
        ),
      ),
    );
  }
}
