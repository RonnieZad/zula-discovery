
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';

class NotificationCenter extends StatefulWidget {
  const NotificationCenter({super.key});

  @override
  State<NotificationCenter> createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.7.sh,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          title(
              text: 'Notification Center',
              fontSize: 46.sp,
              color: brandPrimaryColor,
              fontFamily: 'Broncks',
              textAlign: TextAlign.center),
          250.ph,
          Center(
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
          )
        ],
      ),
    );
  }
}
