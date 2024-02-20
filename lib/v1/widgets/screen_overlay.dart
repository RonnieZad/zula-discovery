
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';

class ScreenOverlay {
  ScreenOverlay._();

  static showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String description,
    required Function action,
  }) {
    return showDialog(
        context: context,
        barrierColor: Colors.black87,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            backgroundColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    heading(text: title, color: brandPrimaryColor),
                    10.ph,
                    paragraph(
                        text: description,
                        color: brandPrimaryColor),
                    25.ph,
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            borderRadius: BorderRadius.circular(50.0),
                            color: brandPrimaryColor.withOpacity(0.8),
                            child: label(text: 'Continue'),
                            onPressed: () {
                              action();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    10.ph,
                    Center(
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child:
                                label(text: 'Cancel', color: brandPrimaryColor)))
                  ]),
            ),
          );
        });
  }

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
                            // top: 10.h,
                              left: 0.0,
                              right: 0.0,
                              bottom: 90.h,
                              child: sheet),
                          Positioned(
                            bottom: 30.h,
                            left: 140.0,
                            right: 140.0,
                            child: FilledButton.icon(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white30)),
                              label:
                                  paragraph(text: 'Close', color: Colors.black),
                              icon: const Icon(
                                CupertinoIcons.multiply,
                                color: Colors.black,
                              ),
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
