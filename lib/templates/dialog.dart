import 'package:flutter/cupertino.dart';

import 'package:google_fonts/google_fonts.dart';

import 'custom_color.dart';

class AlertDialog {
  static Future showAlert(BuildContext context,
      {String? title,
      String? content,
      String? buttonText,
      Function? action}) async {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: title != null
            ? Text(title,
                style: TextStyle(
                    fontFamily: '.SF UI Text',
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: CustomColor.black))
            : null,
        content: content != null
            ? Text(content,
                style: TextStyle(
                    fontFamily: '.SF UI Text',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: CustomColor.black))
            : null,
        actions: <Widget>[
          CupertinoDialogAction(
              child: Text(buttonText!),
              onPressed: () {
                if (action != null) {
                  action();
                }
              }),
        ],
      ),
    );
  }
}
