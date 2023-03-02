import 'package:flutter/material.dart';
import 'package:storily/global/methods/methods.dart';

FloatingActionButton likeFlootBtn = FloatingActionButton(
  heroTag: "btn1",
  elevation: 0.0,
  child: new Icon(Icons.favorite),
  backgroundColor: new Color(0xFFE57373),
  onPressed: () {
    //
  },
);

FloatingActionButton commentFlootBtn = FloatingActionButton(
  heroTag: "btn2",
  elevation: 0.0,
  child: new Icon(Icons.comment),
  backgroundColor: new Color(0xFFE57373),
  onPressed: () {},
);

FloatingActionButton buyFlootBtn = FloatingActionButton(
  heroTag: "btn3",
  elevation: 0.0,
  child: new Icon(Icons.shopping_cart_sharp),
  backgroundColor: new Color(0xFFE57373),
  onPressed: () {},
);
