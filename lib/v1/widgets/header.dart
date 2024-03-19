//  ENYUMBA MOBILE APP
//
//  Created by Ronald Zad Muhanguzi .
//  2023, Enyumba App. All rights reserved.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:zula/v1/screens/dicover_page.dart';
import 'package:zula/v1/screens/notification_center.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/screen_overlay.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.titleText,
    required this.headingText,
    this.hasBackButton = false,
    this.bottomWidget,
  }) : super(key: key);
  final String titleText;
  final String headingText;
  final bool? hasBackButton;
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 10.0),
        child: Container(
          padding: EdgeInsets.only(
              bottom: 10.h,
              top: 40.h,
              right: 20.w,
              left: hasBackButton! ? 20.w : 20.w),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                          child: const Icon(
                            LineIcons.arrowLeft,
                            color: Colors.white,
                          ))
                      : const SizedBox.shrink(),
                  hasBackButton! ? 10.pw : 0.ph,
                  titleText.isEmpty
                      ? const SizedBox.shrink()
                      : title(
              text: titleText,
              fontSize: 46.sp,
              color: Colors.white,
              fontFamily: 'Broncks',
              textAlign: TextAlign.center
              ),
                      
                     
                  if (hasBackButton == false) ...[
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        LucideIcons.compass,
                        color: Colors.white,
                        size: 35.w,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DiscoverPage()));
                      },
                    ),
                    // 10.pw,
                    IconButton(
                      icon: Icon(
                        LucideIcons.bell,
                        color: Colors.white,
                        size: 35.w,
                      ),
                      onPressed: () {
                        ScreenOverlay.showAppSheet(context,
                            sheet: NotificationCenter());
                      },
                    ),
                  ]
                ],
              ),
              10.ph,
              headingText.isEmpty
                  ? const SizedBox.shrink()
                  : heading(text: headingText, color: Colors.white70),
            ],
          ),
        ),
      ),
    );
  }
}
