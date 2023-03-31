import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storily/screens/auth/screens/authorScreen.dart';
import 'package:storily/screens/auth/screens/childscreen.dart';

class ChildAuthorSelectionScreen extends StatelessWidget {
  const ChildAuthorSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 80,
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "Which are You?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/auth_images/chooseafriend_box.png"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => ChildScreen());
                    },
                    child: Column(
                      children: [
                        Text(
                          "Child",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image.asset(
                          "assets/images/auth_images/signup_kids_icon.png",
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => AuthorScreen());
                    },
                    child: Column(
                      children: [
                        Text(
                          "Author",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image.asset(
                          "assets/images/auth_images/signup_author_icon.png",
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
