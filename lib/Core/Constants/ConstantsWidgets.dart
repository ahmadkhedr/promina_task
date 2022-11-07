// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';

mixin ConstantWidgets {
  showLoaderDialog(BuildContext context,String title) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("$title...")),
        ],
      ),
    );

    
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
