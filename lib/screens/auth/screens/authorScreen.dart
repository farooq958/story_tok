import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storily/screens/auth/auth_controller.dart/auth_controller.dart';
import 'package:storily/screens/auth/custom_widgets/corporation_widget.dart';
import 'package:storily/screens/auth/custom_widgets/individuals_widget.dart';

class AuthorScreen extends StatefulWidget {
  const AuthorScreen({Key? key}) : super(key: key);

  @override
  State<AuthorScreen> createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {
  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: Get.width),
            Image.asset(
              "assets/images/auth_images/signup_author_icon.png",
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Business type",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
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
                    () => authController.selectdedbussinessType.value == "ind"
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
                  style:
                      TextStyle(fontSize: 12, fontFamily: 'Proxima Nova Bold'),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    authController.selectdedbussinessType.value = "cop";
                  },
                  child: Obx(
                    () => authController.selectdedbussinessType.value != "ind"
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
                  style:
                      TextStyle(fontSize: 12, fontFamily: 'Proxima Nova Bold'),
                ),
              ],
            ),
            Obx(
              () => (authController.selectdedbussinessType.value == "ind")
                  ? IndividualsUiWidgets()
                  : CorporationWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
