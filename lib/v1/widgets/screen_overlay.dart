import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/controllers/location_controller.dart';
import 'package:zula/v1/controllers/ticket_controller.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/app_background.dart';

class ScreenOverlay {
  ScreenOverlay._();

  static showConfirmationDialog(
    BuildContext context, {
    required String titleText,
    required String description,
    required Function action,
    TextEditingController? textEditingController,
    bool showTextBox = false,
  }) {
    return showDialog(
        context: context,
        barrierColor: Colors.black87,
        builder: (context) {
          TickerController tickerController = Get.find();
          return Dialog(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Obx(() {
                return SizedBox(
                  height: 460,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const AppBackground(),
                      tickerController.showPaymentProcessing.value
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 15.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  title(
                                      text: 'Processing Payment',
                                      fontSize: 46.sp,
                                      color: brandPrimaryColor,
                                      fontFamily: 'Broncks',
                                      textAlign: TextAlign.center),
                                  40.ph,
                                  Lottie.asset(
                                    'assets/images/loading_anim.json',
                                  ),
                                  60.ph,
                                  paragraph(
                                      text:
                                          'We are processing your payment please wait. Hold on a second!',
                                      textAlign: TextAlign.center),
                                ],
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 15.h),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    title(
                                        text: titleText,
                                        fontSize: 46.sp,
                                        color: brandPrimaryColor,
                                        fontFamily: 'Broncks',
                                        textAlign: TextAlign.center),
                                    10.ph,
                                    paragraph(
                                        text: description,
                                        color: brandPrimaryColor,
                                        textAlign: TextAlign.center),
                                    if (showTextBox == true) ...[
                                      25.ph,
                                      AppTextBox(
                                        textEditingController:
                                            textEditingController!,
                                      ),
                                    ],
                                    30.ph,
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CupertinoButton(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            color: brandPrimaryColor
                                                .withOpacity(0.8),
                                            child: label(text: 'Continue'),
                                            onPressed: () {
                                              action();
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
                                            child: label(
                                                text: 'Cancel',
                                                color: brandPrimaryColor)))
                                  ]),
                            ),
                    ],
                  ),
                );
              }),
            ),
          );
        });
  }

  static showAppSheet(BuildContext context,
      {required Widget sheet,
      bool showDismissButton = false,
      bool playHomeVideoFrame = true}) {
    HapticFeedback.lightImpact();
    LocationController locationController = Get.find();

    return showCupertinoModalPopup(
        filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
        context: context,
        builder: (context) {
          return PopScope(
            canPop: !showDismissButton,
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
                      color: Colors.white24,
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
                            left: 120.0,
                            right: 120.0,
                            child: FilledButton.icon(
                              style: const ButtonStyle(
                                  padding: MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(vertical: 15)),
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white30)),
                              label:
                                  paragraph(text: 'Close', color: Colors.white),
                              icon: const Icon(
                                CupertinoIcons.multiply,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                if (playHomeVideoFrame) {
                                  locationController.resumeFramePlay();
                                }
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

class AppTextBox extends StatefulWidget {
  const AppTextBox({super.key, required this.textEditingController});

  final TextEditingController textEditingController;

  @override
  State<AppTextBox> createState() => _AppTextBoxState();
}

class _AppTextBoxState extends State<AppTextBox> {
  int textLengthCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white54),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: TextFormField(
        controller: widget.textEditingController,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: brandPrimaryColor),
        maxLength: 9,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            counterText: '',
            suffixText: '$textLengthCount/9',
            suffixStyle: TextStyle(
                fontSize: 19.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: brandPrimaryColor),
            prefixText: '+256 ',
            prefixStyle: TextStyle(
                fontSize: 19.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: brandPrimaryColor),
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
            border: InputBorder.none,
            hintText: 'Enter mobile phone',
            hintStyle: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: brandPrimaryColor)),
        onChanged: (value) {
          setState(() {
            textLengthCount = value.length;
          });
        },
      ),
    );
  }
}
