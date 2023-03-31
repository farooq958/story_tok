import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:pinput/pinput.dart';
import 'package:storily/screens/auth/auth_controller.dart/auth_controller.dart';
import 'package:storily/screens/auth/helpers/authentication_helper.dart';

class LoginUiWidget extends StatelessWidget {
  LoginUiWidget({Key? key}) : super(key: key);

  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.translate(
            offset: Offset(-20, 0),
            child: Image.asset(
              "assets/images/auth_images/login_text.png",
              width: 200,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Email",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Proxima Nova',
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
              controller: authController.loginEmailController,
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
            height: 10,
          ),
          Text(
            "Password",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Proxima Nova',
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
              controller: authController.loginPasswordController,
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
              border: Border.all(color: Colors.black, width: 3),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Forgot Password?",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () async {
              if (authController.loginEmailController.length == 0 ||
                  authController.loginEmailController.length == 0) {
                Get.snackbar("Error", "Please enter valide Email or Password",
                    backgroundColor: Colors.red.withOpacity(0.5));
              } else {
                await AuthenticationHelper()
                    .signInUser(
                  context: context,
                  signupEmail: authController.loginEmailController.text,
                  signupPassword: authController.loginPasswordController.text,
                )
                    .whenComplete(() {
                  authController.loginEmailController.clear();
                  authController.loginPasswordController.clear();
                });
              }
            },
            child: Image.asset(
              "assets/images/auth_images/standalone_green_login.png",
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
