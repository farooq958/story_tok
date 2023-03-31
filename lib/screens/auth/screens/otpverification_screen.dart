import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:storily/screens/auth/custom_widgets/signupUI_widget.dart';
import 'package:storily/screens/auth/helpers/authentication_helper.dart';
import 'package:storily/screens/auth/screens/childauthorselection_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
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
            SizedBox(
              height: 15,
            ),
            Text(
              "Enter the phone number where you would like to receive one time password\n(OTP).",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Enter OTP",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              child: Pinput(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                AuthenticationHelper()
                    .verifyOTP(authController.otpController.text, context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(
                    "assets/images/auth_images/standalone_green_continue.png"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// final defaultPinTheme = PinTheme(
//   width: 71.5,
//   height: 55,
//   textStyle: const TextStyle(
//       fontSize: 16,
//       color: Colors.black,
//       fontWeight: FontWeight.w700,
//       fontFamily: 'Proxima Nova'),
//   decoration: BoxDecoration(
//     color: Colors.grey,
//     // border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
//     borderRadius: BorderRadius.circular(10),
//   ),
// );
// final focusedPinTheme = PinTheme(
//   width: 71.5,
//   height: 55,
//   textStyle: const TextStyle(
//       fontSize: 16,
//       color: Colors.black,
//       fontWeight: FontWeight.w700,
//       fontFamily: 'Proxima Nova'),
//   decoration: BoxDecoration(
//     color: Colors.grey,
//     border: Border.all(color: Colors.black, width: 1),
//     borderRadius: BorderRadius.circular(10),
//   ),
// );
// final submittedPinTheme = PinTheme(
//   width: 71.5,
//   height: 55,
//   textStyle: const TextStyle(
//       fontSize: 16,
//       color: Colors.black,
//       fontWeight: FontWeight.w700,
//       fontFamily: 'Proxima Nova'),
//   decoration: BoxDecoration(
//     color: Colors.black,
//     border: Border.all(color: Colors.black, width: 1),
//     borderRadius: BorderRadius.circular(10),
//   ),
// );
