import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:storily/components/validator.dart';
import 'package:storily/main.dart';
import 'package:storily/screens/auth/auth_controller.dart/auth_controller.dart';
import 'package:storily/screens/auth/helpers/authentication_helper.dart';

class IndividualsUiWidgets extends StatefulWidget {
  IndividualsUiWidgets({Key? key, this.authorImageFile}) : super(key: key);

  File? authorImageFile;

  @override
  State<IndividualsUiWidgets> createState() => _IndividualsUiWidgetsState();
}

class _IndividualsUiWidgetsState extends State<IndividualsUiWidgets> {
  AuthController authController = Get.find<AuthController>();

  GlobalKey<FormState> individualsKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    log("datatatatata  ${authController.individualsFielsList[2]["textController"].text}");
    return Form(
      key: individualsKey,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          ...List.generate(
            authController.individualsFielsList.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child: Text(
                        authController.individualsFielsList[index]
                            ["headerName"],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    readOnly: index == 1 ? true : false,
                    onTap: index == 1
                        ? () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now());
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd-MMM-yyyy').format(pickedDate);

                              setState(() {
                                (authController.individualsFielsList[1]
                                            ["textController"]
                                        as TextEditingController)
                                    .text = formattedDate;
                              });
                            } else {
                              print("Date is not selected");
                            }
                          }
                        : null,
                    autofocus: false,
                    controller: authController.individualsFielsList[index]
                        ["textController"],
                    validator: authController.individualsFielsList[index]
                        ["Validatior"],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      fillColor: Color(0xffD3D3D3),
                      filled: true,
                      errorStyle: const TextStyle(fontSize: 10),
                      isCollapsed: true,
                      // constraints: BoxConstraints(maxHeight: 30, minHeight: 30),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2)),

                      contentPadding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    ),
                    cursorColor: Colors.black,
                    minLines: 1,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
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
            child: IntrinsicHeight(
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
                        TextFormField(
                          autofocus: false,
                          controller: authController.postalCodeController,
                          keyboardType: TextInputType.number,
                          validator: (value) => Validators.validateDigits(
                            value!,
                            "PostCode",
                            6,
                          ),
                          maxLength: 6,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            counterText: "",
                            fillColor: Color(0xffD3D3D3),
                            filled: true,
                            errorStyle: const TextStyle(fontSize: 10),
                            isCollapsed: true,
                            // constraints: BoxConstraints(maxHeight: 30, minHeight: 30),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2)),
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2)),

                            contentPadding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 10),
                          ),
                          cursorColor: Colors.black,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w900),
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
                                          fontSize: 12),
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
                                color: Color(0xffD3D3D3),
                                borderRadius: BorderRadius.circular(7),
                                border:
                                    Border.all(color: Colors.black, width: 3)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autofocus: false,
                  controller: authController.mobileController,
                  validator: (value) => Validators.validateContact(value!),
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    counterText: "",
                    fillColor: Color(0xffD3D3D3),
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

                    contentPadding:
                        EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  ),
                  cursorColor: Colors.black,
                  minLines: 1,
                  maxLength: 13,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () async {
              if (individualsKey.currentState!.validate()) {
                log("in");
                if (authController.selectedCountryName.value == null &&
                    widget.authorImageFile == null) {
                  Get.snackbar("Required",
                      "Image and country is required, Please select first.",
                      backgroundColor: Colors.red.withOpacity(0.5));
                } else if (authController.selectedCountryName.value == null) {
                  Get.snackbar(
                      "Required", "country is required, Please select first.",
                      backgroundColor: Colors.red.withOpacity(0.5));
                } else if (widget.authorImageFile == null) {
                  Get.snackbar(
                      "Required", "Image is required, Please select first.",
                      backgroundColor: Colors.red.withOpacity(0.5));
                } else {
                  authController.setIndividulesData();
                  // AuthenticationHelper()
                  //     .uploadAuthorsProfile(widget.authorImageFile, context);
                  // AuthenticationHelper().uploadUserDataInFireStore("author");
                  // AuthenticationHelper().uploadAutherUserDataInFireStore();
                  await AuthenticationHelper()
                      .signupUser(
                    imagePath: widget.authorImageFile,
                    context: context,
                    signupEmail: getStorage!.read("signup_Email"),
                    signupPassword: getStorage!.read("signup_Password"),
                    signUpType: 'author',
                  )
                      .whenComplete(() {
                    log("WHEN COMPLETED");
                    authController.clearAllController();
                    getStorage!.erase();
                  });
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: Image.asset(
                  "assets/images/auth_images/standalone_green_continue.png"),
            ),
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
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
        authController.selectedCountryName.value =
            country.displayNameNoCountryCode;
        authController.selectedCountryPhoneCodeIndividual.value =
            country.phoneCode;
        authController.selectedCountyCodeIndividual.value = country.countryCode;
      },
    );
  }
}
