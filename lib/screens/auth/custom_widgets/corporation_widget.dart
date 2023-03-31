import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storily/main.dart';
import 'package:storily/screens/auth/helpers/authentication_helper.dart';

import '../auth_controller.dart/auth_controller.dart';

class CorporationWidget extends StatefulWidget {
  const CorporationWidget({Key? key}) : super(key: key);

  @override
  State<CorporationWidget> createState() => _CorporationWidgetState();
}

class _CorporationWidgetState extends State<CorporationWidget> {
  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        ...List.generate(
          authController.corporateFielsList.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0, top: 10),
                  child: Text(
                      authController.corporateFielsList[index]["headerName"],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: Get.width,
                  height: 30,
                  padding: EdgeInsets.only(left: 5),
                  child: TextFormField(
                    controller: authController.corporateFielsList[index]
                        ["textController"],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      counterText: "",
                      contentPadding: EdgeInsets.only(bottom: 8),
                      // border: InputBorder.none,
                      // hintText: "",
                      // contentPadding: EdgeInsets.only(left: 20, bottom: 15),
                    ),
                    cursorColor: Colors.black,
                    minLines: 1,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: Colors.black, width: 3)),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Container(
              //   alignment: Alignment.center,
              //   width: 150,
              //   height: 30,
              //   child: TextFormField(
              //     controller: authController.mobileController,
              //     keyboardType: TextInputType.number,
              //     decoration: InputDecoration(
              //         border: InputBorder.none,
              //         contentPadding: EdgeInsets.only(left: 10, bottom: 8)),
              //     cursorColor: Colors.black,
              //     minLines: 1,
              //     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
              //   ),
              //   decoration: BoxDecoration(
              //       color: Colors.red,
              //       image: DecorationImage(
              //           image: AssetImage(
              //               "assets/images/auth_images/signup_inputbox_5.png"),
              //           fit: BoxFit.fitHeight)),
              // ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Postal Code",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 165,
                        child: TextFormField(
                          controller: authController.postalCodeController,
                          keyboardType: TextInputType.number,
                          // validator: (value) {
                          //   if (value!.length > 6) {
                          //     return "Please Enter 6 digit Postalcode";
                          //   }
                          //   return null;
                          // },
                          maxLength: 6,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            counterText: "",
                            contentPadding: EdgeInsets.only(bottom: 8),
                          ),
                          cursorColor: Colors.black,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w900),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.1),
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: Colors.black, width: 3)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),

              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Country",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        showCountryCode(context);
                      },
                      child: Container(
                        height: 30,
                        width: 165,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Obx(
                                () => Text(
                                  "${authController.selectedCountryName.value}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 17,
                            )
                          ],
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.1),
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: Colors.black, width: 3)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Text(
                "Phone",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: Get.width,
              height: 30,
              child: TextFormField(
                controller: authController.mobileController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  counterText: "",
                  contentPadding: EdgeInsets.only(bottom: 8),
                ),
                cursorColor: Colors.black,
                minLines: 1,
                maxLength: 13,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
              ),
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                // image: DecorationImage(
                //   image: AssetImage(
                //       "assets/images/auth_images/signup_inputbox_4.png"),
                // ),

                color: Colors.grey.withOpacity(.1),
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: Colors.black, width: 3),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        GestureDetector(
          onTap: () async {
            authController.setCorporationData();
            // AuthenticationHelper().uploadUserDataInFireStore("corpo");
            // AuthenticationHelper().uploadAutherUserDataInFireStore();
            await AuthenticationHelper().signupUser(
              signUpType: "corpo",
              context: context,
              signupEmail: getStorage!.read("signup_Email"),
              signupPassword: getStorage!.read("signup_Password"),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: Image.asset(
                "assets/images/auth_images/standalone_green_continue.png"),
          ),
        )
      ],
    );
  }

  void showCountryCode(BuildContext context) {
    return showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
        bottomSheetHeight: 500, // Optional. Country list modal height
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
        authController.selectedCountryPhoneCodeCorporate.value =
            country.phoneCode;
        authController.selectedCountryName.value =
            country.displayNameNoCountryCode;
      },
    );
  }
}
