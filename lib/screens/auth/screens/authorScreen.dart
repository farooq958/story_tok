import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storily/components/image_widget.dart';
import 'package:storily/screens/auth/auth_controller.dart/auth_controller.dart';
import 'package:storily/screens/auth/custom_widgets/corporation_widget.dart';
import 'package:storily/screens/auth/custom_widgets/individuals_widget.dart';

class AuthorScreen extends StatefulWidget {
  const AuthorScreen({Key? key}) : super(key: key);

  @override
  State<AuthorScreen> createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {
  // AuthController authController = Get.put(AuthController());
  AuthController authController = Get.find<AuthController>();

  File? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
      if (image != null) {}
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
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
            Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
                child: ListView(
                  // shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: Get.width),
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: Get.width,
                          height: 130,
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: image == null
                                  ? null
                                  : Border.all(color: Colors.black, width: 5),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(130),
                              child: image != null
                                  ? Image.file(
                                      image!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/images/auth_images/signup_author_icon.png"),

                              // image == null
                              //     ? Image.asset(
                              //         "assets/images/auth_images/signup_author_icon.png")
                              //     : NetworkImageWidget(
                              //         //! MAIN IMAGE
                              //         imageUrl:
                              //             "assets/images/auth_images/signup_author_icon.png",
                              //       ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: -80,
                          child: GestureDetector(
                            onTap: () {
                              // pickImage(ImageSource.camera);
                              showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(6))),
                                backgroundColor: Colors.white,
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 20),
                                      IntrinsicHeight(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    pickImage(
                                                        ImageSource.camera);
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    height: 42,
                                                    width: 42,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      // gradient: const LinearGradient(
                                                      //     colors: gradientColors),
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 3),
                                                    ),
                                                    child: Image.asset(
                                                        "assets/images/auth_images/camera.png"),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  "CAMERA",
                                                  style: TextStyle().copyWith(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )
                                              ],
                                            ),
                                            VerticalDivider(
                                              color: Colors.grey,
                                              thickness: 2,
                                            ),
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    pickImage(
                                                        ImageSource.gallery);
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    height: 42,
                                                    width: 42,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      // gradient: const LinearGradient(
                                                      //     colors: gradientColors),
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 3),
                                                    ),
                                                    child: Image.asset(
                                                        "assets/images/auth_images/galery.png"),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  "GALLERY",
                                                  style: TextStyle().copyWith(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.black, width: 3),
                              ),
                              child: Image.asset(
                                  "assets/images/auth_images/camera.png"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Business type",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            authController.selectdedbussinessType.value = "ind";
                          },
                          child: Obx(
                            () => authController.selectdedbussinessType.value ==
                                    "ind"
                                ? Image.asset(
                                    "assets/images/auth_images/selectiondot_green_full.png",
                                    height: 20,
                                  )
                                : Image.asset(
                                    "assets/images/auth_images/selectiondot_green_empty.png",
                                    height: 20,
                                  ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Individual",
                          style: TextStyle(
                              fontSize: 12, fontFamily: 'Proxima Nova Bold'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            authController.selectdedbussinessType.value = "cop";
                          },
                          child: Obx(
                            () => authController.selectdedbussinessType.value !=
                                    "ind"
                                ? Image.asset(
                                    "assets/images/auth_images/selectiondot_green_full.png",
                                    height: 20,
                                  )
                                : Image.asset(
                                    "assets/images/auth_images/selectiondot_green_empty.png",
                                    height: 20,
                                  ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Corporation",
                          style: TextStyle(
                              fontSize: 12, fontFamily: 'Proxima Nova Bold'),
                        ),
                      ],
                    ),
                    Obx(
                      () =>
                          (authController.selectdedbussinessType.value == "ind")
                              ? IndividualsUiWidgets(
                                  authorImageFile: image,
                                )
                              : CorporationWidget(),
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
