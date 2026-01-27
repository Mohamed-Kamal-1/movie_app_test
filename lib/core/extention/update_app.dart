import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension UpdateApp on BuildContext {
  void showMessageUpdate() {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('update is ready'),
          content: Text(
            'The update has been downloaded successfully. Please restart the app to activate it.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text('close'),
            ),
          ],
        );
      },
    );
  }
}
