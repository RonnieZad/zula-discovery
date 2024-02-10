//  ENYUMBA MOBILE APP
//
//  Created by Ronald Zad Muhanguzi .
//  2023, Enyumba App. All rights reserved.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:vybe/v1/utils/extensions.dart';
import 'package:vybe/v1/utils/typography.dart';


class Header extends StatelessWidget {
  const Header(
      {Key? key,
      required this.titleText,
      required this.headingText,
      this.hasBackButton = false,
      this.bottomWidget})
      : super(key: key);
  final String titleText;
  final String headingText;
  final bool? hasBackButton;
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
        child: Container(
          width: double.infinity,
          
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Positioned(
                  //   top: -100,
                  //   child: ShaderMask(
                  //     shaderCallback: (bounds) {
                  //       return const LinearGradient(
                  //         begin: Alignment.topCenter,
                  //         end: Alignment.bottomCenter,
                  //         stops: [0.2, 0.79],
                  //         colors: [Colors.white, Colors.transparent],
                  //       ).createShader(bounds);
                  //     },
                  //     // blendMode: BlendMode.dstATop,
                  //     child: SvgPicture.asset(
                  //       'assets/images/pat.svg',
                  //       width: 500.w,
                  //       // color: Theme.of(context).primaryColor,
                  //     ),
                  //   ),
                  // ),

                  //           padding:
                  // EdgeInsets.only(left: 20.w, right: 20.w, top: 40.h, bottom: 10.h),
                  Padding(
                      padding: EdgeInsets.only(
                          top: 60.h, left: hasBackButton! ? 20.w : 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              hasBackButton!
                                  ? GestureDetector(
                                      onTap: () {
                                        HapticFeedback.lightImpact();
                                        Navigator.pop(context);
                                      },
                                      child: Icon(LineIcons.arrowLeft))
                                  : const SizedBox.shrink(),

                                  hasBackButton! ? 10.pw : 0.ph,
                              title(text: titleText, fontSize: 35.sp, color: Colors.white),
                            ],
                          ),
                          5.ph,
                          heading(text: headingText, color: Colors.white60),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
