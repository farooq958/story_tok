import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storily/main.dart';
import 'package:storily/screens/auth/auth_controller.dart/auth_controller.dart';
import 'package:storily/screens/auth/helpers/authentication_helper.dart';
import 'package:storily/screens/auth/screens/twostepverification_screen.dart';

class SignUpUIWidget extends StatefulWidget {
  const SignUpUIWidget({Key? key}) : super(key: key);

  @override
  State<SignUpUIWidget> createState() => _SignUpUIWidgetState();
}

AuthController authController = Get.find<AuthController>();

class _SignUpUIWidgetState extends State<SignUpUIWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Container(
            width: Get.width,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: authController.signupNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                counterText: "",
                hintText: "Enter Your Full Name",
                contentPadding: EdgeInsets.only(bottom: 8),
              ),
              cursorColor: Colors.black,
              maxLines: 1,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
            ),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.1),
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: Colors.black, width: 3),
            ),
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
          Container(
            width: Get.width,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: authController.signupEmailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                counterText: "",
                hintText: "Enter Your Email",
                contentPadding: EdgeInsets.only(bottom: 8),
              ),
              cursorColor: Colors.black,
              maxLines: 1,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
            ),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.1),
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: Colors.black, width: 3)),
          ),
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
          Container(
            width: Get.width,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: authController.signuppasswordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                counterText: "",
                hintText: "Enter Your Password",
                contentPadding: EdgeInsets.only(bottom: 8),
              ),
              cursorColor: Colors.black,
              maxLines: 1,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
            ),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.1),
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: Colors.black, width: 3)),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () async {
              log(getStorage!.read("signup_Password"));
              log(getStorage!.read("signup_Email"));
              log(getStorage!.read("signup_NameFirstLetter"));
              log(getStorage!.read("signup_Name"));
              await authController.storeSignUpData();
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
    );
  }
}
