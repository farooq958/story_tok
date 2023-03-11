import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider with ChangeNotifier {
  SharedPreferences prefs;
  StorageProvider(this.prefs);

  String _name = "";
  String get name =>  _name;
  void changeName(name) {
    _name = name;
    notifyListeners();
  }

  String _lastName = "";
  String get lastName => _lastName;
  void changeLastName(lastName) {
    _lastName = lastName;
    notifyListeners();
  }

  //!========================
  String _chooseLang = "null";
  String get lang => _chooseLang;
  void changeLang(lang) {
    _chooseLang = lang;
    ChangeNotifier();
  }

  //!======================== 
  String _userType = "2";
  String get userType => _userType;
  void updateUserType(userType) {
    _userType = userType;
    prefs.setString("user_type", userType);
    ChangeNotifier();
  }

  //!========================
  String _email = "";
  String get email => _email;
  //String get email => prefs.getString("user_email") ?? _email;
  void updateUserEmail(email) {
    _email = email;
    //prefs.setString("user_email", userType);
    notifyListeners();
  }

  String _savedEmail = "";
  String get savedEmail => prefs.getString("saved_email") ?? _savedEmail;
  void updateSavedUserEmail(email) {
    _savedEmail = email;
    prefs.setString("saved_email", savedEmail);
    notifyListeners();
  }

  String _gender = "null";
  String get gender => _gender;
  void changeGenderl(gender) {
    _gender = gender;
    ChangeNotifier();
  }


  // String _fcmToken = "";
  String get fcmToken => prefs.getString("fcmToken") ?? "null";
  void updateFcmToken(String token) {
    prefs.setString("fcmToken", token);
    // _fcmToken = token;
    // ChangeNotifier();
  }

  //

  // Local CreditCard portion;
  List<String> get getCard => cardGetter();

  List<String> cardGetter() {
    if (prefs.containsKey('card_list')) {
      return prefs.getStringList('card_list') ?? [];
    } else {
      prefs.setStringList('card_list', <String>[]);
      return [];
    }
  }

  // void addCardDetails(ManualCreditCard card) {
  //   List<String> currentList = cardGetter();
  //   currentList.add(card.toJson());
  //     prefs.setStringList('card_list', currentList);
  //   notifyListeners();
  // }

  removeCardDetails(String card) {
        List<String> currentList = cardGetter();
        currentList.removeWhere((element) => element == card);
      prefs.setStringList('card_list', currentList);
    notifyListeners();
  }
// Local Card portionEnd;



  // store card index
  int? _cardIndex;
  int get cardIndex => _cardIndex!;
  void updateCardIndex(cardIndex) {
    _cardIndex = cardIndex;
    ChangeNotifier();
  }
}
