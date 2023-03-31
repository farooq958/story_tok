import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetError {
  static final _instance = InternetError.internal();
  factory InternetError() => _instance;
  InternetError.internal();

  static OverlayEntry? entry;

  void show(context, page) => addOverlayEntry(context);
  void hide() => removeOverlay();

  bool get isShow => entry != null;

  addOverlayEntry(context) {
    if (entry != null) return;
    entry = OverlayEntry(builder: (BuildContext context) {
      return LayoutBuilder(builder: (_, BoxConstraints constraints) {
        return Material(
          color: Colors.black,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image.asset(AppAsset.nointernet),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "No internet connection",
                    // style: AppTextStyle.normalBold20,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Please check your keyword or try again your browsing keyword",
                    // style: AppTextStyle.normalRegular16
                    //     .copyWith(color: primaryWhite.withOpacity(0.60)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      child: Text(""),
                      onPressed: () {
                        removeOverlay();
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 60,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: Text(
                          "Check your network",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });

    addoverlay(entry!, context);
  }

  addoverlay(OverlayEntry entry, context) async {
    Overlay.of(context).insert(entry);
  }

  removeOverlay() {
    entry?.remove();
    entry = null;
  }
}
