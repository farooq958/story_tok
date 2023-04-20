import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinput/pinput.dart';
import 'package:storily/components/validator.dart';
import 'package:storily/main.dart';
import 'package:storily/screens/auth/screens/twostepverification_screen.dart';

class AuthController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCheerCartoonImages();
  }

  RxList profileImageFromFireStore = [].obs;
  RxList profileAvatarImagesFromFireStore = [].obs;
  RxString selectedCheerCartoon =
      "https://firebasestorage.googleapis.com/v0/b/storily-f38a6.appspot.com/o/child_profile%2Fbanana_cheer.png?alt=media&token=01a8292a-e4dd-4486-85db-a54550f864ca"
          .obs;
  RxInt slectedLevel = 1.obs;

  Future getCheerCartoonImages() async {
    //! CHEER CARTOON
    final Reference storageRef =
        FirebaseStorage.instance.ref().child('child_profile');
    final ListResult result = await storageRef.listAll();
    profileImageFromFireStore.value = await Future.wait(
        result.items.map((Reference ref) => ref.getDownloadURL()));

    //! AVATAR PROFILE IMAGE multiFactor
    final Reference storageRefAvatar =
        FirebaseStorage.instance.ref().child('child_avatar_profile');
    final ListResult avatarResult = await storageRefAvatar.listAll();

    profileAvatarImagesFromFireStore.value = await Future.wait(
        avatarResult.items.map((Reference ref) => ref.getDownloadURL()));
    log("STore ref ${profileImageFromFireStore.toString()}");
    log("STore ref av ${profileAvatarImagesFromFireStore.toString()}");
  }

  RxString selectedAuthType = "login".obs;
  RxString selectdedbussinessType = "ind".obs;

  //! CONTROLLERS

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signuppasswordController = TextEditingController();
  TextEditingController signupConfirmPasswordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  RxString selectedCountyCode = "us".obs;
  RxString selectedCountryPhoneCode = "1".obs;
  RxString selectedCountyCodeIndividual = "us".obs;
  RxString selectedCountryPhoneCodeIndividual = "1".obs;
  RxString selectedCountyCodeCorporate = "us".obs;
  RxString selectedCountryPhoneCodeCorporate = "1".obs;

  // List chooseFriendList = [
  //   "assets/images/choose_friend/banana_icon.png",
  //   "assets/images/choose_friend/basketball_icon.png",
  //   "assets/images/choose_friend/bunny_icon.png",
  //   "assets/images/choose_friend/cat_icon.png",
  //   "assets/images/choose_friend/cherry_icon.png",
  //   "assets/images/choose_friend/flame_icon.png",
  //   "assets/images/choose_friend/flower_icon.png",
  //   "assets/images/choose_friend/orange_icon.png",
  //   "assets/images/choose_friend/plant_icon.png",
  //   "assets/images/choose_friend/popsicle_icon.png",
  //   "assets/images/choose_friend/soccer_icon.png",
  //   "assets/images/choose_friend/star_icon.png"
  // ];

  // List selectedCheerCarttonList = [
  //   "assets/images/choose_friend/banana_cheer.png",
  //   "assets/images/choose_friend/basketball_cheer.png",
  //   "assets/images/choose_friend/bunny_cheer.png",
  //   "assets/images/choose_friend/cat_cheer.png",
  //   "assets/images/choose_friend/cherry_cheer.png",
  //   "assets/images/choose_friend/flame_cheer.png",
  //   "assets/images/choose_friend/flower_cheer.png",
  //   "assets/images/choose_friend/orange_cheer.png",
  //   "assets/images/choose_friend/plant_cheer.png",
  //   "assets/images/choose_friend/popsicle_cheer.png",
  //   "assets/images/choose_friend/soccer_cheer.png",
  //   "assets/images/choose_friend/star_cheer.png"
  // ];

  // TextEditingController indFullNameController = TextEditingController();
  // TextEditingController indDOBController = TextEditingController();
  // TextEditingController indAddresssLineOneController = TextEditingController();
  // TextEditingController indAddresssLineTwoController = TextEditingController();
  // TextEditingController indFullCityController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  RxString selectedCountryName = "".obs;
  setIndividulesData() {
    getStorage!.write("DOB", individualsFielsList[1]["textController"].text);
    getStorage!.write("ad1", individualsFielsList[2]["textController"].text);
    getStorage!.write("ad2", individualsFielsList[3]["textController"].text);
    getStorage!.write("city", individualsFielsList[4]["textController"].text);
    getStorage!.write("state", individualsFielsList[5]["textController"].text);
    getStorage!.write("postalCode", postalCodeController.text);
    getStorage!.write("country", selectedCountryName.value);
    // getStorage!.write("phone", mobileController.text);
  }

  setCorporationData() {
    getStorage!
        .write("companyName", corporateFielsList[0]["textController"].text);
    getStorage!.write("DOI", corporateFielsList[1]["textController"].text);
    getStorage!.write("ad1", corporateFielsList[2]["textController"].text);
    getStorage!.write("ad2", corporateFielsList[3]["textController"].text);
    getStorage!.write("city", corporateFielsList[4]["textController"].text);
    getStorage!.write("state", corporateFielsList[5]["textController"].text);
    getStorage!.write("postalCode", postalCodeController.text);
    getStorage!.write("country", selectedCountryName.value);
    // getStorage!.write("phone", mobileController.text);
  }

  storeSignUpData() async {
    getStorage!.write("signup_Name", signupNameController.text);
    getStorage!.write(
        "signup_NameFirstLetter", signupNameController.text[0].toUpperCase());
    log("2");
    getStorage!.write("signup_Email", signupEmailController.text);
    log("3");
    getStorage!.write("signup_Password", signuppasswordController.text);
    log("4");
    await Get.to(() => TwoStepVerification(
          fromLogin: false,
        ));

    log("5");
  }

  List individualsFielsList = [
    {
      "headerName": "Full Name",
      "textController": TextEditingController(),
      "Validatior": (String? v) {
        return Validators.validateFname(v, "Full Name", "Full Name");
      }
    },
    {
      "headerName": "Date of Birth",
      "textController": TextEditingController(),
      "Validatior": (String? v) {
        return Validators.validateRequired(v!, "DOB");
      }
    },
    {
      "headerName": "Address Line 1",
      "textController": TextEditingController(),
      "Validatior": (String? v) {
        return Validators.validateRequired(
          v!,
          "Address Line 1",
        );
      }
    },
    {
      "headerName": "Address Line 2",
      "textController": TextEditingController(),
      // "Validatior": (String? v) {
      //   return Validators.validateRequired(
      //     v!,
      //     "Address Line 1",
      //   );
      // }
    },
    {
      "headerName": "City",
      "textController": TextEditingController(),
      "Validatior": (String? v) {
        return Validators.validateRequired(
          v!,
          "City",
        );
      }
    },
    {
      "headerName": "State/Province/Region",
      "textController": TextEditingController(),
      "Validatior": (String? v) {
        return Validators.validateRequired(
          v!,
          "State/Province/Region",
        );
      }
    }
  ];

  List corporateFielsList = [
    {
      "headerName": "Company Name",
      "textController": TextEditingController(),
      "Validatior": (String? v) {
        return Validators.validateRequired(v!, "Company name");
      }
    },
    {
      "headerName": "Date of Incorporation",
      "textController": TextEditingController(),
      "Validatior": (String? v) {
        return Validators.validateRequired(
          v!,
          "Date of incorporation",
        );
      }
    },
    {
      "headerName": "Address Line 1",
      "textController": TextEditingController(),
      "Validatior": (String? v) {
        return Validators.validateRequired(
          v!,
          "Address Line 1",
        );
      }
    },
    {
      "headerName": "Address Line 2",
      "textController": TextEditingController(),
      // "Validatior": (String? v) {
      //   return Validators.validateRequired(
      //     v!,
      //     "Address Line 1",
      //   );
      // }
    },
    {
      "headerName": "City",
      "textController": TextEditingController(),
      "Validatior": (String? v) {
        return Validators.validateRequired(
          v!,
          "City",
        );
      }
    },
    {
      "headerName": "State/Province/Region",
      "textController": TextEditingController(),
      "Validatior": (String? v) {
        return Validators.validateRequired(
          v!,
          "State/Province/Region",
        );
      }
    }
  ];

  List whichAreYouDataList = [
    {
      "CountImage": "assets/images/auth_images/readinglevel_1_icon.png",
      "Type": "Starter",
      "Dis": "Basic reading, word repetition and short sentences",
      Color: Colors.green
    },
    {
      "CountImage": "assets/images/auth_images/readinglevel_2_icon.png",
      "Type": "Beginner",
      "Dis": "short sentences, familiar words, and simple concepts",
      Color: Colors.redAccent
    },
    {
      "CountImage": "assets/images/auth_images/readinglevel_3_icon.png",
      "Type": "Intermediate",
      "Dis": "Engaging stories, longer sentences, and language play",
      Color: Colors.blueAccent
    },
    {
      "CountImage": "assets/images/auth_images/readinglevel_4_icon.png",
      "Type": "Advanced",
      "Dis": "Short paragraphs, chapters, and exciting themes",
      Color: Colors.yellow
    }
  ];

  clearAllController() {
    signupEmailController.clear();
    signupNameController.clear();
    signuppasswordController.clear();
    loginEmailController.clear();
    loginPasswordController.clear();
    mobileController.clear();
    phoneController.clear();
    otpController.clear();
    individualsFielsList.forEach((e) {
      e["textController"].clear();
    });
    corporateFielsList.forEach((e) {
      e["textController"].clear();
    });
    postalCodeController.clear();
  }
}
