import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storily/components/validator.dart';
import 'package:storily/main.dart';
import 'package:storily/screens/auth/auth_controller.dart/auth_controller.dart';
import 'package:storily/screens/auth/helpers/authentication_helper.dart';
import 'package:storily/screens/auth/screens/childauthorselection_screen.dart';
import 'package:storily/screens/auth/screens/otpverification_screen.dart';

class TwoStepVerification extends StatefulWidget {
  TwoStepVerification({Key? key, required this.fromLogin}) : super(key: key);

  bool fromLogin;

  @override
  State<TwoStepVerification> createState() => _TwoStepVerificationState();
}

class _TwoStepVerificationState extends State<TwoStepVerification> {
  AuthController authController = Get.find<AuthController>();
  GlobalKey<FormState> twoStepKey = GlobalKey<FormState>();

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
              right: Get.width * 0.15,
              left: Get.width * 0.15,
              bottom: Get.height * 0.25,
              child: Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom * 0.3),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Form(
                    key: twoStepKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/auth_images/twostepverification_Text.png",
                          width: Get.width,
                        ),
                        // Text(
                        //   "Two-Step\nVerification",
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 40,
                        //     fontFamily: 'Proxima Nova Bold',
                        //   ),
                        // ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Enter the phone number where you would like to receive one time password\n(OTP).",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Enter your mobile number",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showCountryPicker(
                                    context: context,
                                    countryListTheme: CountryListThemeData(
                                      flagSize: 25,
                                      backgroundColor: Colors.white,
                                      textStyle: TextStyle(
                                          fontSize: 16, color: Colors.blueGrey),
                                      bottomSheetHeight:
                                          500, // Optional. Country list modal height
                                      //Optional. Sets the border radius for the bottomsheet.
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(20.0),
                                      ),

                                      //Optional. Styles the search field.
                                      inputDecoration: InputDecoration(
                                        labelText: 'Search',
                                        hintText: 'Start typing to search',
                                        prefixIcon: const Icon(Icons.search),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: const Color(0xFF8C98A8)
                                                .withOpacity(0.2),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onSelect: (Country country) {
                                      authController.selectedCountryName.value =
                                          country.displayNameNoCountryCode;
                                      authController.selectedCountryPhoneCode
                                          .value = country.phoneCode;
                                      authController.selectedCountyCode.value =
                                          country.countryCode;
                                    },
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  width: 80,
                                  height: 30,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Obx(
                                          () => Text(
                                            "${authController.selectedCountyCode.value} + ${authController.selectedCountryPhoneCode.value}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Image.asset(
                                        "assets/images/auth_images/down_arrow_icon.png",
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(.1),
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                        color: Colors.black, width: 3),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    log("CHecl");
                                    return Validators.validateContact(value!);
                                  },
                                  controller: authController.mobileController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.withOpacity(.1),
                                    filled: true,
                                    errorStyle: const TextStyle(fontSize: 10),
                                    isCollapsed: true,
                                    // constraints: BoxConstraints(maxHeight: 30, minHeight: 30),
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 2)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 2)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 2)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 2)),
                                    hintText: "Enter your mobile number",
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 7, horizontal: 10),
                                  ),
                                  cursorColor: Colors.black,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900),
                                ),
                                // Container(
                                //   alignment: Alignment.center,
                                //   // width: 180,
                                //   height: 30,
                                //   padding: EdgeInsets.symmetric(horizontal: 10),
                                //   child:
                                //   decoration: BoxDecoration(
                                //       color: Colors.grey.withOpacity(.1),
                                //       borderRadius: BorderRadius.circular(7),
                                //       border: Border.all(color: Colors.black, width: 3)),
                                // ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Message and data rates may apply.",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (twoStepKey.currentState!.validate()) {
                              log("inininn");
                              // if (authController.mobileController)
                              log("${getStorage!.read("signup_FullName")}");
                              // log("+" +
                              //     authController.selectedCountryPhoneCode.value +
                              //     authController.mobileController.text);

                              getStorage!.write("phone",
                                  "+${authController.selectedCountryPhoneCode.value + "" + authController.mobileController.text}"
                                 // authController.mobileController.text
                              );
                              AuthenticationHelper().sendOTP(
                                  "+${authController.selectedCountryPhoneCode.value + " " + authController.mobileController.text}",
                                  context,
                                  false);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Image.asset(
                                "assets/images/auth_images/standalone_green_OTP.png"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
