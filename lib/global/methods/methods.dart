import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fluttertoast/fluttertoast.dart';
import '../constants/app_constants.dart';

//* ============== |> will be back where we want <| ============== */
void goPage(BuildContext? context, page) {
  Navigator.push(
    context!,
    MaterialPageRoute(builder: (context) => page),
  );
}

goPageWithName(BuildContext? context, page) {
  Navigator.of(context!).pushNamed(page);
}

goPageAndRemove(BuildContext? context, page) {
  Navigator.pushNamedAndRemoveUntil(
    context!,
    page,
    (route) => false,
  );
}

//* ============== |>   toast    <| ============== */
void showToast(message, BuildContext? context) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

//* ============== |>   snackBar    <| ============== */
void errorSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: Colors.red,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void successSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: Colors.green,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

//* ============== |>   Asset Image Path    <| ============== */

//* ======== |> will be back where we want || for ios app <| ========== */
/* Future<bool> onWillPopWarning(BuildContext context) async {
  AuthProvider _authProvider =
      Provider.of<AuthProvider>(context, listen: false);
  return (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // insetPadding: EdgeInsets.zero,
            elevation: 0,
            title: Center(
              child: Text(
                getTranslated("warning", context),
                style: TextStyles.boldTextStyle(context),
              ),
            ),
            content: Text(
              getTranslated("strat_from_initial", context),
              textAlign: TextAlign.center,
            ),
            actions: [
              Column(
                children: [
                  const Divider(
                    height: 1.0,
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            goPageAndRemove(context, StartingScreen.id);
                            _authProvider.authModel.resStatusCode == 0;
                            _authProvider.authModel.statuscode == 0;
                          },
                          child: Text(
                            getTranslated("agree", context),
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const VerticalDivider(
                          width: 1.0,
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(getTranslated("contine", context)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      )) ??
      false;
} */

//* ============== |> onWillPop when logout <| ============== */
/* Future<bool> onWillPopLogout(BuildContext context) async {
  return (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer<AuthProvider>(
              builder: (context, _authProvider, child) {
            return AlertDialog(
              elevation: 0,
              title: Center(
                child: Text(
                  getTranslated("log_out", context),
                  style: TextStyles.boldTextStyle(context),
                ),
              ),
              content: Text(
                getTranslated("want_to_logout", context),
                textAlign: TextAlign.center,
              ),
              actions: [
                Column(
                  children: [
                    const Divider(
                      height: 1.0,
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("cancel"),
                          ),
                          const VerticalDivider(
                            width: 1.0,
                            thickness: 0.5,
                            color: Colors.grey,
                          ),
                          TextButton(
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              //await prefs.remove(AppConstants.token);
                              await prefs.clear();
                              _authProvider.clearUserData();
                              _authProvider.authModel.statuscode == 0;
                              //goPageAndRemove(context, SigninScreen.id);
                              print("${_authProvider.authModel.data?.token}");
                            },
                            child: Text("log_out",                      
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          });
        },
      )) ??
      true;
} */


//* ============== |> onWillPop when exit <| ============== */
Future<bool> onWillPopExit(BuildContext context, key) async {
 
  return (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // insetPadding: EdgeInsets.zero,
            elevation: 0,
            title: Center(
              child: Text("Exit !!",
                
              ),
            ),
            content: Text("Want to exit",
              textAlign: TextAlign.center,
            ),
            actions: [
              Column(
                children: [
                  const Divider(
                    height: 1.0,
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("No"),
                        ),
                        const VerticalDivider(
                          width: 1.0,
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        TextButton(
                          onPressed: () {
                            exit(0);
                          },
                          child: Text(
                           "Yes",
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      )) ??
      false;
}

//------> 

