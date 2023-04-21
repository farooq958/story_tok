import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:scale_button/scale_button.dart';
import 'package:storily/screens/auth/custom_widgets/signupUI_widget.dart';
import 'package:storily/screens/auth/helpers/authentication_helper.dart';
import 'package:storily/screens/auth/screens/childauthorselection_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  OtpVerificationScreen({Key? key, this.fromLogin, this.resolver}) : super(key: key);

  bool? fromLogin;
  MultiFactorResolver? resolver;
  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
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
              // top: Get.height * 0.35,
              right: Get.width * 0.15,
              left: Get.width * 0.15,
              bottom: Get.height * 0.25,
              child: Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom * 0.3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/auth_images/twostepverification_Text.png",
                      width: Get.width,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Enter the phone number where you would like to receive one time password\n(OTP).",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Enter OTP",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: Pinput(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        // validator: (val) {
                        //   return Validators.validateDigits(val!, "OTP", 6);
                        // },
                        length: 6,
                        controller: authController.otpController,
                        defaultPinTheme: PinTheme(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.black),
                          margin: EdgeInsets.only(right: 1.5, left: 1.5),
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.5), width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Message and data rates may apply.",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          widget.fromLogin! == true?
                            AuthenticationHelper().sendSignInOTP(
                              widget.resolver!,
                              context
                              )
                            : AuthenticationHelper().EnrollSendOTP(
                              "+${authController.selectedCountryPhoneCode.value + " " + authController.mobileController.text}",
                              context);
                        },
                        child: Text(
                          "Resend Otp",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ScaleButton(
                        onTap: () {
                          widget.fromLogin! ==true?
                          AuthenticationHelper().verifySignInOTP(
                              authController.otpController.text,
                              widget.resolver!,
                              context)
                          : AuthenticationHelper().verifyEnrollOTP(
                            authController.otpController.text,
                            context
                          );
                        },
                        child: Image.asset(
                            "assets/images/auth_images/standalone_green_continue.png"),
                      ),
                    )
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
