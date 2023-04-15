import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storily/screens/auth/screens/signup_screen.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  late Query collectionRefGameCondition;
  late QuerySnapshot querySnapshotGameCondition;
  var gameConditionLists = [];
  String intro_op_info = '';
  String signup_receive = '';
  String signup_bonus = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGameConditionData();
  }

  Future<void> getGameConditionData() async {
    collectionRefGameCondition =
        FirebaseFirestore.instance.collection('in_game_conditions');

    // Get docs from collection reference
    querySnapshotGameCondition = await collectionRefGameCondition.get();

    // Get data from docs and convert map to List
    gameConditionLists =
        querySnapshotGameCondition.docs.map((doc) => doc.data()).toList();

    if (gameConditionLists.isNotEmpty) {
      intro_op_info = gameConditionLists[0]['introduction_operate_info'];
      signup_receive = gameConditionLists[0]['signup_and_Recieve'];
      signup_bonus = gameConditionLists[0]['signup_bonus'];

      setState(() {
        intro_op_info;
        signup_receive;
        signup_bonus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "assets/images/auth_images/background_signup_colour.png"),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            Positioned(
              top: Get.height * 0.08,
              left: Get.width * 0.45,
              child: Image.asset(
                "assets/images/background_circledots.png",
                height: 120,
                width: 120,
              ),
            ),
            //! SMALL STARS
            Positioned(
              top: Get.height * 0.15,
              left: Get.width * 0.05,
              child: Image.asset(
                "assets/images/background_kids_cross2.png",
                height: 20,
                width: 20,
              ),
            ),
            Positioned(
              top: Get.height * 0.3,
              right: Get.width * 0.05,
              child: Image.asset(
                "assets/images/background_kids_cross2.png",
                height: 20,
                width: 20,
              ),
            ),
            Positioned(
              top: Get.height * 0.6,
              left: Get.width * 0.05,
              child: Image.asset(
                "assets/images/background_kids_cross2.png",
                height: 20,
                width: 20,
              ),
            ),
            Positioned(
              top: Get.height * 0.05,
              right: Get.width * 0.1,
              child: Image.asset(
                "assets/images/background_kids_cross1.png",
                height: 40,
                width: 40,
              ),
            ),

            Positioned(
              left: Get.width * 0.08,
              top: Get.width * 0.2,
              child: Image.asset(
                "assets/images/background_squiggle.png",
                height: 40,
                width: 40,
              ),
            ),
            Positioned(
              left: Get.width * 0.15,
              top: Get.width * 0.15,
              child: Image.asset(
                "assets/images/background_triangle.png",
                height: 20,
                width: 20,
              ),
            ),
            Positioned(
              right: Get.width * 0.15,
              top: Get.height * 0.2,
              child: Image.asset(
                "assets/images/background_kids_circle1.png",
                height: 30,
                width: 30,
              ),
            ),
            Positioned(
              left: Get.width * 0.15,
              top: Get.height * 0.2,
              child: Image.asset(
                "assets/images/background_kids_circle2.png",
                height: 20,
                width: 20,
              ),
            ),
            //! BOTTOM
            Positioned(
              left: Get.width * 0.05,
              bottom: Get.height * 0.01,
              child: Image.asset(
                "assets/images/background_square.png",
                height: 50,
                width: 50,
              ),
            ),
            Positioned(
              left: Get.width * 0.05,
              bottom: Get.width * 0.141,
              child: Image.asset(
                "assets/images/background_square.png",
                height: 50,
                width: 50,
              ),
            ),
            Positioned(
              right: Get.width * 0.25,
              bottom: -Get.height * 0.1,
              child: Transform.rotate(
                angle: 1.58,
                child: Image.asset(
                  "assets/images/background_rectangledots.png",
                  height: 230,
                  // width: 200,
                ),
              ),
            ),
            Positioned(
              left: Get.width * 0.38,
              bottom: Get.height * 0.08,
              child: Transform.rotate(
                angle: -0.8,
                child: Image.asset(
                  "assets/images/background_kids_squiggle1.png",
                  height: 30,
                  width: 30,
                ),
              ),
            ),
            Positioned(
              left: Get.width * 0.25,
              bottom: Get.height * 0.02,
              child: Image.asset(
                "assets/images/background_kids_circle1.png",
                height: 30,
                width: 30,
              ),
            ),
            Positioned(
              right: Get.width * 0.05,
              bottom: Get.height * 0.12,
              child: Transform.rotate(
                angle: 1.4,
                child: Image.asset(
                  "assets/images/background_triangle.png",
                  height: 30,
                  width: 30,
                ),
              ),
            ),

            //! MAIN CONTENT
            Positioned(
              top: Get.height * 0.02,
              right: Get.width * 0.15,
              left: Get.width * 0.15,
              bottom: Get.height * 0.00,
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: Get.height * 0.15,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 80,
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        //"Choose a friend!",
                        '',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/images/how_we_operate/how_we_operate_text.png"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Enjoy a whole month of...",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Image.asset(
                    "assets/images/how_we_operate/freebooks_text.png",
                    height: 30,
                    // width: 30,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    "assets/images/how_we_operate/audiobooks_text.png",
                    height: 30,
                    // width: 30,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    "assets/images/how_we_operate/activities_text.png",
                    height: 30,
                    // width: 30,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    "assets/images/how_we_operate/educationalvideos_text.png",
                    height: 30,
                    // width: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      intro_op_info,
                      textAlign: TextAlign.justify,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),

                  Text(
                    signup_receive,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    signup_bonus,
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.green,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      Get.to(() => SignUpScreen(isSignupSelected: true));
                    },
                    child: Image.asset(
                      "assets/images/auth_images/standalone_green_signup.png",
                      width: Get.width,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      Get.to(() => SignUpScreen(isSignupSelected: false));
                    },
                    child: Image.asset(
                      "assets/images/auth_images/standalone_green_login.png",
                      width: Get.width,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
