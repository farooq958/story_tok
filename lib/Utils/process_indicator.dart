import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'internet_error.dart';

class Circle {
  static final _instance = new Circle.internal();
  factory Circle() => _instance;
  Circle.internal();

  static bool entry = false;
  static OverlayEntry viewEntry =
      new OverlayEntry(builder: (BuildContext context) {
    return ProcessIndicator();
  });

  InternetError internetError = new InternetError();

  show(context) async {
    return addOverlayEntry(context);
  }

  void hide(context) => removeOverlay();

  bool get isShow => isShowNetworkOrCircle();

  bool isShowNetworkOrCircle() {
    return internetError.isShow || entry == true;
  }

  addOverlayEntry(context) async {
    if (entry == true) return;
    entry = true;
    return addOverlay(viewEntry, context);
  }

  addOverlay(OverlayEntry entry, context) async {
    try {
      return Overlay.of(context)!.insert(entry);
    } catch (e) {
      return Future.error(e);
    }
  }

  removeOverlay() async {
    try {
      entry = false;
      viewEntry.remove();
    } catch (e) {
      return Future.error(e);
    }
  }
}

class ProcessIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
      child: Material(
        color: Colors.black26,
        child: Center(
          child: Container(
            height: 60.0,
            width: 60.0,
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: CircularProgressIndicator(
              strokeWidth: 4,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

// class Circle2 {
//   static final _instance2 = new Circle2.internal();
//   factory Circle2() => _instance2;
//   Circle2.internal();

//   static bool entry = false;
//   static OverlayEntry viewEntry =
//       new OverlayEntry(builder: (BuildContext context) {
//     return ProcessIndicator2();
//   });

//   InternetError internetError = new InternetError();

//   show(context) async {
//     return addOverlayEntry(context);
//   }

//   void hide(context) => removeOverlay();

//   bool get isShow => isShowNetworkOrCircle();

//   bool isShowNetworkOrCircle() {
//     return internetError.isShow || entry == true;
//   }

//   addOverlayEntry(context) async {
//     if (entry == true) return;
//     entry = true;
//     return addOverlay(viewEntry, context);
//   }

//   addOverlay(OverlayEntry entry, context) async {
//     try {
//       return Overlay.of(context).insert(entry);
//     } catch (e) {
//       return Future.error(e);
//     }
//   }

//   removeOverlay() async {
//     try {
//       entry = false;
//       viewEntry.remove();
//     } catch (e) {
//       return Future.error(e);
//     }
//   }
// }

// class ProcessIndicator2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
//       child: Material(
//         color: Colors.black26,
//         child: Center(
//           child: Container(
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             alignment: Alignment.center,
//             height: 70.0,
//             width: Get.width,
//             padding: EdgeInsets.all(15.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             child: Row(
//               children: [
//                 width10,
//                 CircularProgressIndicator(
//                   strokeWidth: 4,
//                   color: primaryBlack,
//                 ),
//                 customWidth(20),
//                 Text(
//                   "Preparing PDF file...",
//                   style: AppTextStyle.normalBold14.copyWith(
//                       color: primaryBlack.withOpacity(0.5),
//                       fontWeight: FontWeight.w400),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
