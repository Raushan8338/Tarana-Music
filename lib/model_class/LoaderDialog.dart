import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoaderDialog {
  static Future<void> showLoadingDialog(BuildContext context, GlobalKey key) async {
    var wid = MediaQuery.of(context).size.width / 2;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(left: 50 , right: 50),
          child: Dialog(
              key: key,
              backgroundColor: Colors.white,
              child: Container(
                height: 110,
                child:  Column(
                  children: [
                    Image.asset(
                      'assets/images/loader_waiting.gif',
                      height: 80,
                      width: 80,
                    ),
                    Text("Please wait... !")
                  ],
                ),
              )
          ),
        );
      },
    );
  }
}