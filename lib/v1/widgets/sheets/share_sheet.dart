

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:vybe/v1/utils/extensions.dart';
import 'package:vybe/v1/utils/typography.dart';

class ShareSheet extends StatelessWidget {
  const ShareSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 20.w),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          heading(
              text: 'Share',
              fontSize: 27.sp,
              color: Colors.white),
          20.ph,
          Row(
            children: [
              Column(
                children: [
                  Icon(LineIcons.facebook,
                      color: Colors.white,
                      size: 30.w),
                  10.ph,
                  paragraph(
                      text: 'Facebook',
                      fontSize: 20.sp,
                      color: Colors.white70)
                ],
              ),
              20.pw,
              Column(
                children: [
                  Icon(LineIcons.twitter,
                      color: Colors.white,
                      size: 30.w),
                  10.ph,
                  paragraph(
                      text: 'Twitter',
                      fontSize: 20.sp,
                      color: Colors.white70)
                ],
              ),
              20.pw,
              Column(
                children: [
                  Icon(LineIcons.instagram,
                      color: Colors.white,
                      size: 30.w),
                  10.ph,
                  paragraph(
                      text: 'Instagram',
                      fontSize: 20.sp,
                      color: Colors.white70)
                ],
              ),
              20.pw,
              Column(
                children: [
                  Icon(LineIcons.sms,
                      color: Colors.white,
                      size: 30.w),
                  10.ph,
                  paragraph(
                      text: 'SMS',
                      fontSize: 20.sp,
                      color: Colors.white70)
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}


