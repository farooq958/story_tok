import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storily/components/image_widget.dart';
import 'package:storily/main.dart';
import 'package:storily/screens/auth/auth_controller.dart/auth_controller.dart';
import 'package:storily/screens/auth/helpers/authentication_helper.dart';

class ChildScreen extends StatefulWidget {
  const ChildScreen({Key? key}) : super(key: key);

  @override
  State<ChildScreen> createState() => _ChildScreenState();
}

class _ChildScreenState extends State<ChildScreen> {
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    authController.getCheerCartoonImages();
    log("auth data ==> ${authController.profileImageFromFireStore} ");
    authController.selectedCheerCartoon.value =
        authController.profileImageFromFireStore.first;
  }

  @override
  void dispose() {
    super.dispose();
    authController.selectedCheerCartoon.value =
        authController.profileImageFromFireStore.first;
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
              right: Get.width * 0.05,
              left: Get.width * 0.05,
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
                        "Choose a friend!",
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
                  Obx(
                    () => NetworkImageWidget(
                      imageUrl: authController.selectedCheerCartoon.value,
                      height: 300,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Obx(
                    () => Container(
                      width: Get.width,
                      height: 150,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              authController.selectedCheerCartoon.value =
                                  authController
                                      .profileImageFromFireStore[index];
                              getStorage!.write(
                                  "selected_avtar_Profile",
                                  authController
                                      .profileAvatarImagesFromFireStore[index]);
                              getStorage!.write("selected_avtar_Pheer_Profile",
                                  authController.selectedCheerCartoon.value);
                              Get.snackbar("Selected",
                                  "Image has been selected successfully.");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: NetworkImageWidget(
                                imageUrl: authController
                                    .profileAvatarImagesFromFireStore[index],
                                height: 80,
                              ),
                            ),
                          );
                        },
                        itemCount: authController
                            .profileAvatarImagesFromFireStore.length,
                        scrollDirection: Axis.horizontal,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffD3D3D3),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 4),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Which are you?",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                    ),
                  ),
                  ...List.generate(
                      authController.whichAreYouDataList.length,
                      (index) => InkWell(
                            onTap: () {
                              Get.snackbar("Selected",
                                  "Level ${index + 1} has been selected successfully.");
                              authController.slectedLevel.value = index + 1;
                              log("selectde level ${authController.slectedLevel.value}");
                              getStorage!.write("selectedLevel",
                                  authController.slectedLevel.value);
                            },
                            child: WhichAreYouWidget(
                              countImagePath: authController
                                  .whichAreYouDataList[index]["CountImage"],
                              headerColor: authController
                                  .whichAreYouDataList[index][Color],
                              headerText: authController
                                  .whichAreYouDataList[index]["Type"],
                              des: authController.whichAreYouDataList[index]
                                  ["Dis"],
                            ),
                          )),
                  GestureDetector(
                    onTap: () async {
                      log(getStorage!.read("signup_Email"));
                      await AuthenticationHelper().signupUser(
                        signUpType: "child",
                        context: context,
                        signupEmail: getStorage!.read("signup_Email"),
                        signupPassword: getStorage!.read("signup_Password"),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      child: Image.asset(
                          "assets/images/auth_images/standalone_green_continue.png"),
                    ),
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WhichAreYouWidget extends StatelessWidget {
  WhichAreYouWidget(
      {Key? key,
      this.des,
      this.countImagePath,
      this.headerColor,
      this.headerText})
      : super(key: key);

  String? countImagePath;
  String? des;
  String? headerText;
  Color? headerColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 110,
      alignment: Alignment.center,
      width: Get.width,
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Image.asset(
            countImagePath!,
            height: 80,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                headerText!,
                style: TextStyle(
                    fontSize: 28,
                    color: headerColor!,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                des!,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w900),
              )
            ],
          ),
        )
      ]),
      decoration: BoxDecoration(
        color: Color(0xffD3D3D3),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 4),
      ),
    );
  }
}
