import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storily/Utils/process_indicator.dart';
import 'package:storily/components/common_upload_book_format.dart';
import 'package:storily/main.dart';
import 'package:storily/screens/auth/auth.dart';
import 'package:storily/screens/auth/auth_controller.dart/auth_controller.dart';
import 'package:storily/screens/auth/screens/childauthorselection_screen.dart';
import 'package:storily/screens/auth/screens/otpverification_screen.dart';
import 'package:storily/screens/dashboard/widgets/home_screen.dart';
import 'package:storily/screens/main_home_screen.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User get user => _auth.currentUser!;

  Future signupUser(
      {required String signupEmail,
      required String signupPassword,
      required BuildContext context,
      File? imagePath,
      required String signUpType}) async {
    Circle().show(context);
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: signupEmail,
        password: signupPassword,
      );
      if (user != null) {
        log(credential.user!.uid);
        if (imagePath != null) await uploadAuthorsProfile(imagePath, context);
        if (signUpType == "author" || signUpType == "corpo") {
          uploadUserDataInFireStore(signUpType);
          uploadAutherUserDataInFireStore();
        } else {
          uploadUserDataInFireStore(signUpType);
        }
        Circle().hide(context);
        await Get.offAll(() => MainHomeScreen());
        getStorage!.erase();
      }
      Circle().hide(context);
      return null;
    } on FirebaseAuthException catch (e) {
      Circle().hide(context);
      log(e.code);
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        Get.snackbar("Error", "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        Get.snackbar("Error", "The account already exists for that email.");
      } else {
        Get.snackbar("Error", "Please Enter valid Email or Password.");
      }
    } catch (e) {
      print(e);
    }
  }

//! UPLOAD AUTHOR's PROFILE IMAGE INTO FIRESTORE

  String? downloadUrl;

  uploadAuthorsProfile(_imagePath, context) async {
    Circle().show(context);
    final Reference storageRef = FirebaseStorage.instance.ref().child(
        'author_profile_image/${FirebaseAuth.instance.currentUser!.uid}${_imagePath.path.split('.').last}');

    final TaskSnapshot task = await storageRef.putFile(_imagePath);

    downloadUrl = await storageRef.getDownloadURL();

    log('File uploaded: $downloadUrl');
    Circle().hide(context);
  }

//! SET DATA ON FIRESTORE

  uploadUserDataInFireStore(String signupType) async {
    final DocumentReference docRef =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

    final Map<String, dynamic> data = {
      'author_id':
          signupType == "corpo" || signupType == "author" ? user.uid : null,
      'type': signupType == "author" ? 'Author' : 'child',
      if (signupType == "author") 'Dob': getStorage!.read("DOB"),
      if (signupType == "corpo")
        'company_name': getStorage!.read("companyName"),
      if (signupType == "corpo") 'DOI': getStorage!.read("DOI"),
      if (signupType == "author") 'address_line_1': getStorage!.read("ad1"),
      if (signupType == "author") 'address_line_2': getStorage!.read("ad2"),
      if (signupType == "author") 'city': getStorage!.read("city"),
      if (signupType == "author") 'state': getStorage!.read("state"),
      if (signupType == "author") 'postCode': getStorage!.read("postalCode"),
      if (signupType == "author") 'country': getStorage!.read("country"),
      if (signupType == "author") 'phonenumber': getStorage!.read("phone"),
      'email': user.email,
      'name': getStorage!.read("signup_Name"),
      'nameIndex': getStorage!.read("signup_NameFirstLetter"),
      'premiumMember': false,
      'profile_url': signupType == "corpo" || signupType == "author"
          ? downloadUrl
          : getStorage!.read("selected_avtar_Pheer_Profile"),
      'reading_level': getStorage!.read("selectedLevel"),
      'uid': user.uid,
    };
    docRef.set(data).then((value) {
      Get.snackbar("Sign Up", "Sign up successfully.",
          backgroundColor: Colors.green.withOpacity(0.5));
    }).catchError((error) {
      Get.snackbar("ERROR", error.toString(),
          backgroundColor: Colors.red.withOpacity(0.5));
    });
    log("FIRESTORE DATA ==> ${data}");
  }

  List booksDocIdList = [];
  uploadAutherUserDataInFireStore() async {
    final DocumentReference docRef =
        FirebaseFirestore.instance.collection('book_authors').doc(user.uid);

    final Map<String, dynamic> data = {
      'avatar_url': downloadUrl,
      'boigraphy': "",
      'name': getStorage!.read("signup_Name"),
      'books_doc_id': booksDocIdList,
      'user_id': user.uid,
    };
    docRef.set(data).then((value) {
      Get.snackbar("Sign Up", "Sign up successfully.",
          backgroundColor: Colors.green.withOpacity(0.5));
    }).catchError((error) {
      Get.snackbar("ERROR", error.toString(),
          backgroundColor: Colors.red.withOpacity(0.5));
    });
    log("FIRESTORE DATA ==> ${data}");
  }

//! LOGIN
  Future signInUser(
      {required String signupEmail,
      required String signupPassword,
      required BuildContext context}) async {
    log("signup data ==> $signupEmail ==> $signupPassword");
    try {
      Circle().show(context);
      await _auth.signInWithEmailAndPassword(
          email: signupEmail, password: signupPassword);
      if (user != null) {
        Get.offAll(() => MainHomeScreen());
      }
      log(user.toString());

      Circle().hide(context);
      return null;
    } on FirebaseAuthException catch (e) {
      log("ERROR $e");
      Circle().hide(context);
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red.withOpacity(0.5));
      return e.message;
    }
  }

  Future signOut() async {
    await _auth.signOut();
    Get.offAll(() => FirebaseSession());
    Get.snackbar("Log Out", "Log Out successfully.",
        backgroundColor: Colors.green.withOpacity(0.5));
    print('signout');
  }

  Future<void> sendOTP(String phoneNumber, BuildContext context) async {
    Get.snackbar("OTP", "We'll sent the OTP to your number!",
        backgroundColor: Colors.green.withOpacity(0.5));

    Circle().show(context);
    log("number ==> $phoneNumber");
    await _auth.verifyPhoneNumber(
      timeout: Duration(seconds: 60),
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        log("ERROR FROM OTP  $e");
        Get.snackbar("Error", e.toString(),
            backgroundColor: Colors.red.withOpacity(0.5));
      },
      codeSent: (String verificationId, int? resendToken) async {
        Get.snackbar("OTP", "We've sent the OTP you your number!",
            backgroundColor: Colors.green.withOpacity(0.5));

        await getStorage!.write("otpVerificationID", verificationId);
        log("--------->> $verificationId ---->>${getStorage!.read("otpVerificationID")} ");

        Get.off(() => OtpVerificationScreen());
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    Circle().hide(context);
  }

  Future<void> verifyOTP(String smsCode, BuildContext context) async {
    Circle().show(context);
    log("otp verification data ==> $smsCode ==> ${getStorage!.read("otpVerificationID")}");
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: getStorage!.read("otpVerificationID"),
      smsCode: smsCode,
    );
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;
    if (user != null) {
      Get.off(() => ChildAuthorSelectionScreen());
      // The user has been successfully authenticated
    } else {
      Get.snackbar("Error", "Something wend wrong please try again");
      // Authentication failed
    }
    Circle().hide(context);
  }
}
