import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:storily/global/constants/assets.dart';

Widget dropShadowWidget({context, imageUrl}) {
  return Container(
    margin: EdgeInsets.only(left: 8.0),
    height: MediaQuery.of(context).size.height / 3.8,
    width: MediaQuery.of(context).size.width / 2.2,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
          imageUrl,
        ),
      ),
    ),
  );
}


class MainMenuWidget extends StatefulWidget {
  MainMenuWidget(
      {Key? key,
        this.boxImageUrl,
        required this.ontap,
        this.addFilesImageUrl,
        this.dropShadow})
      : super(key: key);
  Function()? ontap;
  String? boxImageUrl;
  String? addFilesImageUrl;
  String? dropShadow;
  @override
  State<MainMenuWidget> createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<MainMenuWidget> {
  late bool boolVal;
  ValueNotifier<bool> buttton = ValueNotifier(false);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    boolVal = false;
    print("object");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,

      onTapDown: (c) async {
        buttton.value = true;
        buttton.notifyListeners();
      },

      onTap: widget.ontap,

      onTapUp: (v) {
        buttton.value = false;
        buttton.notifyListeners();
      },

      child: ValueListenableBuilder<bool>(
          valueListenable: buttton,
          builder: (context, val, child) {
            return Stack(
              children: [
                dropShadowWidget(
                  imageUrl: widget.dropShadow,
                  context: context,
                ),
                TweenAnimationBuilder<Offset>(
                  curve: Curves.bounceInOut,
                  tween: Tween<Offset>(
                      begin: val ? Offset(0, 0) : Offset(0, 0),
                      end: val ? Offset(10, 5) : Offset(-70, -60)),
                  duration: Duration(milliseconds: 10),
                  builder: (context, value, child) {
                    return Transform.translate(
                        offset: Offset(
                            value.dx.clamp(0, 10), value.dy.clamp(-3, 5)),
                        child: child!);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 6.0),
                    height: MediaQuery.of(context).size.height / 3.8,
                    width: MediaQuery.of(context).size.width / 2.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          widget.boxImageUrl!,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          widget.addFilesImageUrl!,
                          width: MediaQuery.of(context).size.height * 0.19,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
    ;
  }
}
