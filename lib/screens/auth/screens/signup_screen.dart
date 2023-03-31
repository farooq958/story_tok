import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storily/screens/auth/auth_controller.dart/auth_controller.dart';
import 'package:storily/screens/auth/custom_widgets/loginUi_widget.dart';
import 'package:storily/screens/auth/custom_widgets/signupUI_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
              Positioned(
                top: Get.height * 0.26,
                right: Get.width * 0.15,
                child: Row(
                  children: [
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          authController.selectedAuthType.value = "signup";
                        },
                        child: authController.selectedAuthType.value == "signup"
                            ? Image.asset(
                                "assets/images/auth_images/signup_button.png",
                                width: 80,
                              )
                            : Text(
                                "SIGN UP",
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          authController.selectedAuthType.value = "login";
                        },
                        child: authController.selectedAuthType.value == "login"
                            ? Image.asset(
                                "assets/images/auth_images/login_button.png",
                                width: 80,
                              )
                            : Text(
                                "LOG IN",
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              //! MAIN CONTENT
              Obx(
                () => Positioned(
                  top: Get.height * 0.325,
                  right: Get.width * 0.15,
                  left: Get.width * 0.15,
                  bottom: Get.height * 0.07,
                  child: authController.selectedAuthType.value == "signup"
                      ? SignUpUIWidget()
                      : LoginUiWidget(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
