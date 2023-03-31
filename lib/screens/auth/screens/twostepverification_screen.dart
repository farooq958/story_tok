import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storily/main.dart';
import 'package:storily/screens/auth/auth_controller.dart/auth_controller.dart';
import 'package:storily/screens/auth/helpers/authentication_helper.dart';
import 'package:storily/screens/auth/screens/otpverification_screen.dart';

class TwoStepVerification extends StatefulWidget {
  const TwoStepVerification({Key? key}) : super(key: key);

  @override
  State<TwoStepVerification> createState() => _TwoStepVerificationState();
}

class _TwoStepVerificationState extends State<TwoStepVerification> {
  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
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
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
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
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      countryListTheme: CountryListThemeData(
                        flagSize: 25,
                        backgroundColor: Colors.white,
                        textStyle:
                            TextStyle(fontSize: 16, color: Colors.blueGrey),
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
                              color: const Color(0xFF8C98A8).withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                      onSelect: (Country country) {
                        authController.selectedCountryPhoneCode.value =
                            country.phoneCode;
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
                                  fontWeight: FontWeight.w900, fontSize: 12),
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
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    // width: 180,
                    height: 30,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: authController.mobileController,
                      onChanged: (value) {},
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        counterText: "",
                        hintText: "Enter Your mobile number",
                        contentPadding: EdgeInsets.only(bottom: 8),
                      ),
                      cursorColor: Colors.black,
                      maxLines: 1,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.1),
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: Colors.black, width: 3)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Message and data rates may apply.",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                log("${getStorage!.read("signup_FullName")}");
                // log("+" +
                //     authController.selectedCountryPhoneCode.value +
                //     authController.mobileController.text);

                AuthenticationHelper().sendOTP(
                    "+${authController.selectedCountryPhoneCode.value + " " + authController.mobileController.text}",
                    context);
                getStorage!
                    .write("phone", authController.mobileController.text);
                // Get.to(() => OtpVerificationScreen());
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
    );
  }
}
