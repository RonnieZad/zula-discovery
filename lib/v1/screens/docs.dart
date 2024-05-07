import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';

class DocsPages extends StatelessWidget {
  const DocsPages({
    super.key,
    required this.termsOfServie,
    required this.headingText,
    this.textAlign,
  });

  final String termsOfServie;
  final String headingText;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            children: [
              100.ph,
              Center(
                  child: title(
                      text: headingText,
                      textAlign: TextAlign.center,
                      fontSize: 36.sp)),
              20.ph,
              paragraph(
                  text: termsOfServie,
                  fontSize: 22.sp,
                  textAlign: textAlign ?? TextAlign.justify)
            ],
          ),
          Positioned(
            bottom: 30.h,
            left: 120.0,
            right: 120.0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                HapticFeedback.selectionClick();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.r),
                  border: Border.all(color: Colors.white60, width: 0.8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60.r),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60.r),
                          color: Colors.black38),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          paragraph(text: 'Close', color: Colors.white),
                          10.pw,
                          const Icon(
                            CupertinoIcons.multiply,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
