import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    log("auth data ==> ${authController.profileImageFromFireStore.length} ");
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: Get.height * 0.2,
            ),
            Container(
              alignment: Alignment.center,
              height: 80,
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "Choose a friend!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
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
              () => Image.network(
                authController.selectedCheerCartoon.value,
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
                            authController.profileImageFromFireStore[index];
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
                        child: Image.network(
                          authController
                              .profileAvatarImagesFromFireStore[index],
                          height: 80,
                        ),
                      ),
                    );
                  },
                  itemCount:
                      authController.profileAvatarImagesFromFireStore.length,
                  scrollDirection: Axis.horizontal,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 4),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Which are you?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
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
                        getStorage!.write(
                            "selectedLevel", authController.slectedLevel.value);
                      },
                      child: WhichAreYouWidget(
                        countImagePath: authController
                            .whichAreYouDataList[index]["CountImage"],
                        headerColor: authController.whichAreYouDataList[index]
                            [Color],
                        headerText: authController.whichAreYouDataList[index]
                            ["Type"],
                        des: authController.whichAreYouDataList[index]["Dis"],
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Image.asset(
                    "assets/images/auth_images/standalone_green_continue.png"),
              ),
            )
          ]),
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
        color: Colors.grey.withOpacity(.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 4),
      ),
    );
  }
}
