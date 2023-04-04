import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storily/components/my_storily_author_page.dart';
import 'package:storily/screens/auth/auth_controller.dart/auth_controller.dart';
import 'package:storily/screens/auth/screens/authorScreen.dart';
import 'package:storily/screens/auth/screens/childscreen.dart';

class ChildAuthorSelectionScreen extends StatelessWidget {
  ChildAuthorSelectionScreen({Key? key}) : super(key: key);

  AuthController authController = Get.find<AuthController>();

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
              top: Get.height * 0.35,
              right: Get.width * 0.1,
              left: Get.width * 0.1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 80,
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Which are You?",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/auth_images/chooseafriend_box.png"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => ChildScreen());
                            },
                            child: Column(
                              children: [
                                Text(
                                  "Child",
                                  style: TextStyle(
                                      fontSize: 28,
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.w900),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Image.asset(
                                  "assets/images/auth_images/signup_kids_icon.png",
                                  height: 100,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              (authController.individualsFielsList[0]
                                              ["textController"]
                                          as TextEditingController)
                                      .text =
                                  authController.signupNameController.text;

                              Get.to(() => AuthorScreen());
                            },
                            child: Column(
                              children: [
                                Text(
                                  "Author",
                                  style: TextStyle(
                                      fontSize: 28,
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.w900),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Image.asset(
                                  "assets/images/auth_images/signup_author_icon.png",
                                  height: 100,
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
          ],
        ),
      ),
    );
  }
}
