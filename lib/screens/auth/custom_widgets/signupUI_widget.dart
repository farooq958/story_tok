import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scale_button/scale_button.dart';
import 'package:storily/components/input_text_field_widget.dart';
import 'package:storily/components/validator.dart';
import 'package:storily/main.dart';
import 'package:storily/screens/auth/auth_controller.dart/auth_controller.dart';
import 'package:storily/screens/auth/helpers/authentication_helper.dart';
import 'package:storily/screens/auth/screens/childauthorselection_screen.dart';
import 'package:storily/screens/auth/screens/otpverification_screen.dart';
import 'package:storily/screens/auth/screens/twostepverification_screen.dart';

class SignUpUIWidget extends StatefulWidget {
  const SignUpUIWidget({Key? key}) : super(key: key);

  @override
  State<SignUpUIWidget> createState() => _SignUpUIWidgetState();
}

AuthController authController = Get.find<AuthController>();


GlobalKey<FormState> signupKey = GlobalKey<FormState>();

class _SignUpUIWidgetState extends State<SignUpUIWidget> {


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: signupKey,
        child: Column(
          // shrinkWrap: true,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/auth_images/signup_text.png",
              width: 200,
            ),
            SizedBox(
              height: 10,
            ),
            // Image.asset(
            //   "assets/images/auth_images/fullname2_text.png",
            //   width: 80,
            // ),
            Text(
              "Full Name",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 05,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autocorrect: true,
              validator: (value) => Validators.validateFname(
                  value!, "Name is required", "Name is required"),
              controller: authController.signupNameController,
              decoration: InputDecoration(
                fillColor: Colors.grey.withOpacity(.1),
                filled: true,
                errorStyle: const TextStyle(fontSize: 10),
                isCollapsed: true,
                // constraints: BoxConstraints(maxHeight: 30, minHeight: 30),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(color: Colors.black, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2)),
                hintText: "Enter Your Full Name",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              ),
              cursorColor: Colors.black,
              maxLines: 1,
              minLines: 1,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
            ),

            SizedBox(
              height: 05,
            ),
            Text(
              "Email",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 05,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => Validators.validateEmail(value),
              controller: authController.signupEmailController,
              decoration: InputDecoration(
                fillColor: Colors.grey.withOpacity(.1),
                filled: true,
                errorStyle: const TextStyle(fontSize: 10),
                isCollapsed: true,
                // constraints: BoxConstraints(maxHeight: 30, minHeight: 30),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(color: Colors.black, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2)),
                hintText: "Enter Your Email",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              ),
              cursorColor: Colors.black,
              maxLines: 1,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
            ),
            // Container(
            //   width: Get.width,
            //   height: 30,
            //   padding: EdgeInsets.symmetric(horizontal: 10),
            //   child:
            //   decoration: BoxDecoration(
            //       color: Colors.grey.withOpacity(.1),
            //       borderRadius: BorderRadius.circular(7),
            //       border: Border.all(color: Colors.black, width: 3)),
            // ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Password",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 05,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => Validators.validatePassword(value),
              controller: authController.signuppasswordController,
              decoration: InputDecoration(
                fillColor: Colors.grey.withOpacity(.1),
                filled: true,
                errorStyle: const TextStyle(fontSize: 10),
                isCollapsed: true,
                // constraints: BoxConstraints(maxHeight: 30, minHeight: 30),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(color: Colors.black, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2)),
                hintText: "Enter Your Password",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              ),
              cursorColor: Colors.black,
              maxLines: 1,
              obscureText: true,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Confirm Password",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 05,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => Validators.validatePassword(value),
              controller: authController.signupConfirmPasswordController,
              decoration: InputDecoration(
                fillColor: Colors.grey.withOpacity(.1),
                filled: true,
                errorStyle: const TextStyle(fontSize: 10),
                isCollapsed: true,
                // constraints: BoxConstraints(maxHeight: 30, minHeight: 30),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(color: Colors.black, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2)),
                hintText: "Enter Your Confirm Password",
                contentPadding:
                EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              ),
              cursorColor: Colors.black,
              maxLines: 1,
              obscureText: true,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 10,
            ),
            ScaleButton(
              onTap: () async {
                // log(getStorage!.read("signup_Password"));
                // log(getStorage!.read("signup_Email"));
                // log(getStorage!.read("signup_NameFirstLetter"));
                // log(getStorage!.read("signup_Name"));
                if (signupKey.currentState!.validate()) {
                  if(authController.signuppasswordController.text == authController.signupConfirmPasswordController.text) {
                    await AuthenticationHelper().SignUpFirst();
                    //await authController.storeSignUpData();
                   /* var query = FirebaseFirestore.instance
                        .collection('users')
                        .where('email',
                        isEqualTo: authController.signupEmailController.text)
                        .limit(1)
                        .get();*/
                    // var snapshot = await query.snapshots();
                    /*query.then((value) async {
                      print("##### SIZE OF RECORD ${value.size}");
                      if (value.size > 0) {
                        Get.snackbar("Registration", "User already exists!",
                            backgroundColor: Colors.red.withOpacity(0.5));
                      } else {

                        await authController.storeSignUpData();
                      }
                    });*/
                  }else{
                    Get.snackbar("Registration", "Password doesn't match with confirm password!",
                        backgroundColor: Colors.red.withOpacity(0.5));
                  }
                }
              },
              child: Image.asset(
                "assets/images/auth_images/standalone_green_signup.png",
                width: Get.width,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "OR",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/auth_images/singup_google_icon.png",
                  height: 80,
                ),
                Image.asset(
                  "assets/images/auth_images/singup_facebook_icon.png",
                  height: 80,
                ),
                Image.asset(
                  "assets/images/auth_images/signup_amazon_icon.png",
                  height: 80,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
