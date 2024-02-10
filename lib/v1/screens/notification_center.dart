import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:vybe/v1/utils/extensions.dart';
import 'package:vybe/v1/utils/typography.dart';
import 'package:vybe/v1/widgets/app_background.dart';

class NotificationCenter extends StatefulWidget {
  const NotificationCenter({super.key});

  @override
  State<NotificationCenter> createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
      const AppBackground(),
          Positioned(
            top: 60.h,
            left: 20.w,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    Icon(CupertinoIcons.arrow_left,
                        color: Colors.white, size: 30.w),
                    20.pw,
                    heading(
                        text: 'Notification Center',
                        fontSize: 30.sp,
                        color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
top: 160.h,
            left: 20.w,
            right: 20.w,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  heading(
                      text: 'Updates will appear here', color: Colors.white70),
                  20.ph,
                  Icon(
                    LucideIcons.bellMinus,
                    size: 60.w,
                    color: Colors.white70,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
