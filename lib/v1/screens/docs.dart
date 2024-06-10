import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zula/v1/constants/colors.dart';
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
          CustomScrollView(
            slivers: [
              _appBar(context),
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: paragraph(
                      text: termsOfServie,
                      fontSize: 22.sp,
                      textAlign: textAlign ?? TextAlign.justify),
                )
              ]))
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

  SliverAppBar _appBar(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: true,
      stretch: true,
      automaticallyImplyLeading: false,
      toolbarHeight: 130,
      expandedHeight: 130.0,
      backgroundColor: Colors.white,
      centerTitle: true,
      surfaceTintColor: brandPrimaryColor.withOpacity(0.2),
      title: title(
          text: headingText,
          fontSize: 46.sp,
          color: brandPrimaryColor,
          fontFamily: 'TypoGraphica',
          textAlign: TextAlign.center),
    );
  }
}
