import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vybe/v1/utils/typography.dart';

class ScreenOverlay {
  ScreenOverlay._();

  static showAppSheet(BuildContext context,
      {required Widget sheet, bool showDismissButton = false}) {
    HapticFeedback.lightImpact();
    return showCupertinoModalPopup(
        filter: ImageFilter.blur(sigmaX: 80.0, sigmaY: 80.0),
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return !showDismissButton;
            },
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                  width: double.infinity,
                  child: Material(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        topRight: Radius.circular(10.r),
                      ),
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          Positioned(
                              left: 0.0,
                              right: 0.0,
                              bottom: 130.h,
                              child: sheet),
                          Positioned(
                            bottom: 30.h,
                            left: 140.0,
                            right: 140.0,
                            child: FilledButton.icon(
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.white30)
                              ),
                              
                              label: paragraph(text: 'Close',color: Colors.black),
                              icon: const Icon(CupertinoIcons.multiply, color: Colors.black,),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          )
                        ],
                      ))),
            ),
          );
        });
  }
}
