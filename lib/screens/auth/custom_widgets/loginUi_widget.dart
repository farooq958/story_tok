import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:pinput/pinput.dart';
import 'package:scale_button/scale_button.dart';
import 'package:storily/components/validator.dart';
import 'package:storily/screens/auth/auth_controller.dart/auth_controller.dart';
import 'package:storily/screens/auth/helpers/authentication_helper.dart';
import 'package:storily/screens/auth/screens/otpverification_screen.dart';

class LoginUiWidget extends StatefulWidget {
  LoginUiWidget({Key? key}) : super(key: key);

  @override
  State<LoginUiWidget> createState() => _LoginUiWidgetState();
}

class _LoginUiWidgetState extends State<LoginUiWidget> {
  AuthController authController = Get.find<AuthController>();

  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: loginKey,
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
            TextFormField(
              // autofocus: true,\
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => Validators.validateEmail(value),
              controller: authController.loginEmailController,
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
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => Validators.validatePassword(value),
              controller: authController.loginPasswordController,
              obscureText: true,
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
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: ()async {AuthenticationHelper().ResetPassword();},
                child:Text(
                "Forgot Password?",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),)
            ),
            SizedBox(
              height: 10,
            ),
            ScaleButton(
              onTap: () async {
                if (loginKey.currentState!.validate()) {
                  if (authController.loginEmailController.length == 0 ||
                      authController.loginEmailController.length == 0) {
                    Get.snackbar(
                        "Error", "Please enter valide Email or Password",
                        backgroundColor: Colors.red.withOpacity(0.5));
                  } else {

                    await AuthenticationHelper()
                        .signInUser(
                      context: context,
                      signupEmail: authController.loginEmailController.text,
                      signupPassword:
                      authController.loginPasswordController.text,
                    )
                        .whenComplete(() {

                      // authController.loginEmailController.clear();
                      // authController.loginPasswordController.clear();
                    });
                  }
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
      ),
    );
  }
}
