import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storily/Utils/process_indicator.dart';
import 'package:storily/components/common_upload_book_format.dart';
import 'package:storily/main.dart';
import 'package:storily/screens/auth/auth.dart';
import 'package:storily/screens/auth/auth_controller.dart/auth_controller.dart';
import 'package:storily/screens/auth/screens/childauthorselection_screen.dart';
import 'package:storily/screens/auth/screens/otpverification_screen.dart';
import 'package:storily/screens/dashboard/widgets/home_screen.dart';
import 'package:storily/screens/main_home_screen.dart';
import 'package:storily/utils.dart';

import '../../dashboard/feed_dashboard.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthController authController = Get.put(AuthController());
  User get user => _auth.currentUser!;
  String userName = '';
  var currentUser = [];

  Future ResetPassword() async
  {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: user.email!);
  }

  Future SignUpFirst() async
  {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: authController.signupEmailController.text,
        password: authController.signuppasswordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Registration", "User already exists!",
            backgroundColor: Colors.red.withOpacity(0.5));
      }
    } catch (e) {
      print(e);
    }
    await user?.sendEmailVerification();
  }

  Future signupUser(
      {required String signupEmail,
      required String signupPassword,
      required BuildContext context,
      File? imagePath,
      required String signUpType}) async {
    Circle().show(context);
    try {
      userName = getStorage!.read("signup_Name");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userName', userName);
      if(signUpType == "author" || signUpType == "corpo"){
        prefs.setString('userType', 'Author');
      }else{
        prefs.setString('userType', 'child');
      }

      if (signUpType == "author" || signUpType == "corpo") {
        uploadUserDataInFireStore(signUpType, imagePath, context);
        //uploadAutherUserDataInFireStore();
      } else {
        uploadUserDataInFireStore(signUpType, imagePath, context);
      }
      Circle().hide(context);
      authController.clearAllController();
      if (signUpType == "child") {
        await Get.offAll(() => FeedDashboard());
      } else {
        await Get.offAll(() => MainHomeScreen(name: userName));
      }

      // final credential = EmailAuthProvider.credential(
      //     email: signupEmail, password: signupPassword);
      // if (user != null) {
      //   await FirebaseAuth.instance.currentUser
      //       ?.linkWithCredential(credential)
      //       .then((user_) {
      //     log("email ==> ${user_.user!.email} ==> ${user_.user!.phoneNumber}");
      //   }).catchError((error) {
      //     print("bhumit---" + error.toString());
      //   });
      //
      //   if (imagePath != null) await uploadAuthorsProfile(imagePath, context);
      //   if (signUpType == "author" || signUpType == "corpo") {
      //     uploadUserDataInFireStore(signUpType);
      //     //uploadAutherUserDataInFireStore();
      //   } else {
      //     uploadUserDataInFireStore(signUpType);
      //   }
      //   Circle().hide(context);
      //   getStorage!.erase();
      //   authController.clearAllController();
      //   if (signUpType == "child") {
      //     await Get.offAll(() => FeedDashboard());
      //   } else {
      //     await Get.offAll(() => MainHomeScreen());
      //   }
      // }
      // Circle().hide(context);
      return null;
    } on FirebaseAuthException catch (e) {
      Circle().hide(context);
      log(e.code);
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        Get.snackbar("Error", "The password provided is too weak.",
            backgroundColor: Colors.red.withOpacity(0.5));
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        Get.snackbar("Error", "The account already exists for that email.",
            backgroundColor: Colors.red.withOpacity(0.5));
      } else {
        Get.snackbar("Error", "Please Enter valid Email or Password.",
            backgroundColor: Colors.red.withOpacity(0.5));
      }
    } catch (e) {
      print(e);
    }
  }

//! UPLOAD AUTHOR's PROFILE IMAGE INTO FIRESTORE

  String? downloadUrl;

  uploadAuthorsProfile(_imagePath, context, refID) async {
    Circle().show(context);
    // final Reference storageRef = FirebaseStorage.instance.ref().child(
    //     'author_profile_image/${FirebaseAuth.instance.currentUser!.uid}${_imagePath.path.split('.').last}');

    final Reference storageRef = FirebaseStorage.instance.ref().child(
        'author_profile_image/${refID}${_imagePath.path.split('.').last}');

    final TaskSnapshot task = await storageRef.putFile(_imagePath);

    downloadUrl = await storageRef.getDownloadURL();

    log('File uploaded: $downloadUrl');
    Circle().hide(context);
  }

//! SET DATA ON FIRESTORE

  uploadUserDataInFireStore(
      String signupType, File? imagePath, BuildContext context) async {
    // final DocumentReference docRef =
    //     FirebaseFirestore.instance.collection('users').doc(user.uid);
    final DocumentReference docRef =
        FirebaseFirestore.instance.collection('users').doc();

    final Map<String, dynamic> data = {
      // 'author_id':
      //     signupType == "corpo" || signupType == "author" ? user.uid : null,
      'author_id': '',
      'type':
          signupType == "corpo" || signupType == "author" ? 'Author' : 'child',
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
      'phonenumber': getStorage!.read("phone"),
      'email': getStorage!.read("signup_Email"),
      'name': getStorage!.read("signup_Name"),
      'nameIndex': getStorage!.read("signup_NameFirstLetter"),
      'premiumMember': false,
      // 'profile_url': signupType == "corpo" || signupType == "author"
      //     ? downloadUrl
      //     : getStorage!.read("selected_avtar_Pheer_Profile"),

      'reading_level': getStorage!.read("selectedLevel") ?? 1,
      'uid': ''
      //'uid': user.uid,
    };
    docRef.set(data).then((value) {
      final DocumentReference docRef1 =
          FirebaseFirestore.instance.collection('users').doc(docRef.id);
      docRef1.update({'uid': user.uid, 'author_id': signupType == "corpo" || signupType == "author" ? docRef.id : null});
      uploadAutherUserDataInFireStore(
          docRef.id, imagePath, context, signupType);
      Get.snackbar("Sign Up", "Sign up successfully.",
          backgroundColor: Colors.green.withOpacity(0.5));
    }).catchError((error) {
      Get.snackbar("ERROR", error.toString(),
          backgroundColor: Colors.red.withOpacity(0.5));
    });
    log("FIRESTORE DATA ==> ${data}");
  }

  List booksDocIdList = [];
  uploadAutherUserDataInFireStore(String refID, File? imagePath,
      BuildContext context, String signupType) async {
    // final DocumentReference docRef =
    //     FirebaseFirestore.instance.collection('book_authors').doc(user.uid);

    final DocumentReference docRef =
        FirebaseFirestore.instance.collection('book_authors').doc(refID);
    if (imagePath != null)
      await uploadAuthorsProfile(imagePath, context, refID);

    final Map<String, dynamic> data = {
      'avatar_url': downloadUrl,
      'boigraphy': "",
      'name': getStorage!.read("signup_Name"),
      'books_doc_id': booksDocIdList,
      'user_id': user.uid,
    };
    Future.delayed(const Duration(milliseconds: 2000), () {
      docRef.set(data).then((value) async {
        final DocumentReference docRef1 =
            FirebaseFirestore.instance.collection('users').doc(refID);
        docRef1.update({
          'profile_url': signupType == "corpo" || signupType == "author"
              ? downloadUrl
              : getStorage!.read("selected_avtar_Pheer_Profile"),
        });
        getStorage!.erase();

        // Get.snackbar("Sign Up", "Sign up successfully.",
        //     backgroundColor: Colors.green.withOpacity(0.5));
      }).catchError((error) {
        Get.snackbar("ERROR", error.toString(),
            backgroundColor: Colors.red.withOpacity(0.5));
      });
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
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: signupEmail,
            password: signupPassword
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar("Signin", "User doesn't exists!",
              backgroundColor: Colors.red.withOpacity(0.5));
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Signin", "Email password does not match, forgot your password?",
              backgroundColor: Colors.red.withOpacity(0.5));
        }
      }
      var query = FirebaseFirestore.instance
          .collection('users')
          .where('user_id', isEqualTo: user.uid)
          .limit(1)
          .get();
      // var snapshot = await query.snapshots();
      query.then((value) async {
        if (value.size > 0) {
          currentUser = value.docs.map((doc) => doc.data()).toList();
          sendOTP(currentUser[0]['phonenumber'], context, true);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if(currentUser[0]['type'] == "Author" ){
            prefs.setString('userType', 'Author');
          }else{
            prefs.setString('userType', 'child');
          }


          // authController.clearAllController();
        } else {
          Get.snackbar("Signin", "User doesn't exists!",
              backgroundColor: Colors.red.withOpacity(0.5));
        }
      });

      // await _auth.signInWithEmailAndPassword(
      //     email: signupEmail, password: signupPassword);
      // if (user != null) {
      //   sendOTP(user.phoneNumber!, context, true);
      //   authController.clearAllController();
      //   log("user mobile ==> ${user.phoneNumber}");
      //   // sendOTP(user.phoneNumber!, context);
      // }
      // log(user.toString());

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userName');
    Get.offAll(() => FirebaseSession());
    authController.clearAllController();
    getStorage!.erase();
    authController.selectedAuthType.value = "login";
    Get.snackbar("Log Out", "Log Out successfully.",
        backgroundColor: Colors.green.withOpacity(0.5));
    // FirebaseUser user = await FirebaseAuth.instance.currentUser();
    //_auth.currentUser?.delete();
    print('signout');
  }

  Future<void> sendOTP(
      String phoneNumber, BuildContext context, bool fromLogin) async {
    Get.snackbar("OTP", "We'll sent the OTP to your number!",
        backgroundColor: Colors.green.withOpacity(0.5));
    final session = await user.multiFactor.getSession();
    //final auth = FirebaseAuth.instance;
    Circle().show(context);
    log("number ==> $phoneNumber");
    // if(!fromLogin){
    //   getStorage!.write("phone", phoneNumber);
    // }

    await _auth.verifyPhoneNumber(
      multiFactorSession: session,
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        log("in var complete");
        String verificationCode = credential.smsCode!;
        log("message $verificationCode");
        // UserCredential userCredential =
        //     await _auth.signInWithCredential(credential);
        // User user = userCredential.user!;

        // // Sign in with email and password
        // _auth
        //     .signInWithEmailAndPassword(email: email, password: password)
        //     .then((UserCredential userCredential) async {
        //   User user = userCredential.user!;

        //   // Link phone credential to email credential
        //   AuthCredential emailCredential = EmailAuthProvider.credential(
        //     email: email,
        //     password: password,
        //   );
        //   await user.linkWithCredential(emailCredential);
        //   Get.to(() => ChildAuthorSelectionScreen());
        // }).catchError((error) {
        //   // Handle sign-in errors
        // });
      },
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

        Get.to(() => OtpVerificationScreen(
              fromLogin: fromLogin,
            ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    Circle().hide(context);
  }

  AuthCredential? phoneCredentials;
  Future<void> verifyOTP(
    String smsCode,
    BuildContext context,
    bool fromLogin,
  ) async {
    Circle().show(context);
    log("otp verification data ==> $smsCode ==> ${getStorage!.read("otpVerificationID")}");

    try {
      var credential = PhoneAuthProvider.credential(
        verificationId: getStorage!.read("otpVerificationID"),
        smsCode: smsCode,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      // final User? user = userCredential.user;
      // Get.off(() => ChildAuthorSelectionScreen());
      if (userCredential.user != null) {
        phoneCredentials = userCredential.credential;
        if (fromLogin) {
          var query = FirebaseFirestore.instance
              .collection('users')
              .where('email',
                  isEqualTo: authController.loginEmailController.text)
              .limit(1)
              .get();
          query.then((value) async {
            if (value.size > 0) {
              value.docs.forEach((doc) async {
                if (doc["type"] == 'Author') {
                  getStorage!.write("authorname", doc["name"]);
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('userName', userName);
                  authController.otpController.clear();
                  Get.offAll(() => MainHomeScreen(name: doc["name"]));
                } else {
                  authController.otpController.clear();
                  Get.offAll(() => FeedDashboard());
                }
              });
            }
          });
        } else {
          Get.off(() => ChildAuthorSelectionScreen());
        }
        // fromLogin == true
        //     ? Get.offAll(() => MainHomeScreen())
        //     : Get.off(() => ChildAuthorSelectionScreen());
        // The user has been successfully authenticated
      } else {
        Circle().hide(context);
        Get.snackbar("Error", "Something wend wrong please try again");
        // Authentication failed
      }
    } catch (e) {
      Get.snackbar("ERROR", e.toString(),
          backgroundColor: Colors.red.withOpacity(0.5));
    }

    Circle().hide(context);
  }
}
