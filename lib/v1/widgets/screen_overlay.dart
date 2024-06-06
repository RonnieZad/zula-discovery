import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/controllers/controllers.dart';
import 'package:zula/v1/controllers/location_controller.dart';
import 'package:zula/v1/controllers/ticket_controller.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScreenOverlay {
  ScreenOverlay._();

  static signInDialog(
    BuildContext context, {
    required String titleText,
    required String description,
    required Function action,
    bool showTextBox = false,
  }) {
    AuthController authController = Get.find();
    return showDialog(
        context: context,
        barrierColor: Colors.black87,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    title(
                      text: 'Sign in',
                      fontSize: 46.sp,
                      color: brandPrimaryColor,
                      fontFamily: 'Poppins',
                    ),
                    10.ph,
                    paragraph(
                        text:
                            'Get started to access world-class and personalised travel experiences for you',
                        color: brandPrimaryColor,
                        fontSize: 21.sp),
                    55.ph,
                    SignInButton(
                      label: 'Continue with Google',
                      icon: 'android_dark_rd_ctn',
                      action: () {
                        authController.signInWithGoogle();
                        Navigator.pop(context);
                      },
                    ),
                    10.ph,
                    SignInButton(
                      color: Colors.black,
                      label: 'Continue with Apple',
                      icon: 'apple-sign-in',
                      action: () {},
                    ),
                    Center(
                        child: TextButton(
                      child: paragraph(text: 'Sign in later'),
                      onPressed: () {},
                    )),
                    20.ph,
                    paragraph(
                        text:
                            'By continuing you agree to our Terms and Conditions and Privacy Policy',
                        fontSize: 18.sp,
                        color: Colors.black54)
                  ]),
            ),
          );
        });
  }

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
          return Dialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: SizedBox(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        title(
                          text: titleText,
                          fontSize: 46.sp,
                          color: brandPrimaryColor,
                          fontFamily: 'Poppins',
                        ),
                        10.ph,
                        paragraph(
                          text: description,
                          color: brandPrimaryColor,
                        ),
                        if (showTextBox == true) ...[
                          25.ph,
                          AppTextBox(
                            isPhone: true,
                            textEditingController: textEditingController!,
                          ),
                        ],
                        10.ph,
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 65.h,
                                child: CupertinoButton(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: brandPrimaryColor.withOpacity(0.8),
                                  child: label(text: 'Continue'),
                                  onPressed: () {
                                    action();
                                  },
                                ),
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
                                    text: 'Cancel', color: brandPrimaryColor)))
                      ]),
                ),
              ),
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
        barrierColor: Colors.white70,
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
                              left: 0.0,
                              right: 0.0,
                              bottom: 95.h,
                              child: sheet),
                          Positioned(
                            bottom: 25.h,
                            left: 120.0,
                            right: 120.0,
                            child: FilledButton.icon(
                              style: ButtonStyle(
                                  padding: const WidgetStatePropertyAll(
                                      EdgeInsets.symmetric(vertical: 15)),
                                  backgroundColor: WidgetStatePropertyAll(
                                      brandPrimaryColor.withOpacity(0.1))),
                              label: paragraph(
                                  text: 'Close', color: brandPrimaryColor),
                              icon: Icon(
                                CupertinoIcons.multiply,
                                color: brandPrimaryColor,
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



class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    this.color,
    required this.label,
    required this.icon,
    required this.action,
  });

  final String label;
  final String icon;
  final VoidCallback action;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
        decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.black26)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon.toSvg,
              width: 20.w,
              color: color != null ? Colors.white : null,
            ),
            10.pw,
            paragraph(
              text: label,
              color: color != null ? Colors.white : null,
            )
          ],
        ),
      ),
    );
  }
}



class AppTextBox extends StatefulWidget {
  const AppTextBox(
      {super.key,
      this.isPhone,
      this.maxLines,
      this.hintText,
      required this.textEditingController});

  final TextEditingController textEditingController;
  final bool? isPhone;
  final int? maxLines;
  final String? hintText;

  @override
  State<AppTextBox> createState() => _AppTextBoxState();
}

class _AppTextBoxState extends State<AppTextBox> {
  int textLengthCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: brandPrimaryColor.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextFormField(
        controller: widget.textEditingController,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: brandPrimaryColor),
        maxLength: widget.isPhone == true ? 9 : null,
        keyboardType: TextInputType.phone,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
            counterText: '',
            suffixText: widget.isPhone == true ? '$textLengthCount/9' : null,
            suffixStyle: TextStyle(
                fontSize: 19.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: brandPrimaryColor),
            prefixText: widget.isPhone == true ? '+256 ' : null,
            prefixStyle: TextStyle(
                fontSize: 19.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: brandPrimaryColor),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: brandPrimaryColor.withOpacity(0.6))),
        onChanged: (value) {
          setState(() {
            textLengthCount = value.length;
          });
        },
      ),
    );
  }
}
