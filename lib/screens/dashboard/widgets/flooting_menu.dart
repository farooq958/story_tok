import 'package:flutter/material.dart';
import 'package:storily/global/methods/methods.dart';

FloatingActionButton authorFlootBtn(BuildContext context) {
  return FloatingActionButton(
    heroTag: "btn1",
    elevation: 0.0,
    child: new Icon(Icons.account_circle_outlined),
    backgroundColor: new Color(0xFFE57373),
    onPressed: () {
      showToast("authorFlootBtn", context);
    },
  );
}

FloatingActionButton likeFlootBtn(BuildContext context) {
  return FloatingActionButton(
    heroTag: "btn2",
    elevation: 0.0,
    child: new Icon(Icons.favorite),
    backgroundColor: new Color(0xFFE57373),
    onPressed: () {
      showToast("likeFlootBtn", context);
    },
  );
}

FloatingActionButton commentFlootBtn(BuildContext context) {
  return FloatingActionButton(
    heroTag: "btn3",
    elevation: 0.0,
    child: new Icon(Icons.insert_comment_rounded),
    backgroundColor: new Color(0xFFE57373),
    onPressed: () {
      showToast("commentFlootBtn", context);
    },
  );
}

FloatingActionButton buyFlootBtn(BuildContext context) {
  return FloatingActionButton(
    heroTag: "btn4",
    elevation: 0.0,
    child: new Icon(Icons.shopping_cart),
    backgroundColor: new Color(0xFFE57373),
    onPressed: () {
      showToast("buyFlootBtn", context);
    },
  );
}

FloatingActionButton personFlootBtn(BuildContext context) {
  return FloatingActionButton(
    heroTag: "btn5",
    elevation: 0.0,
    child: new Icon(Icons.account_circle_outlined),
    backgroundColor: new Color(0xFFE57373),
    onPressed: () {
      showToast("personFlootBtn", context);
    },
  );
}
